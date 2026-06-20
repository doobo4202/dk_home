package com.landingDoobo.controller;

import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.io.File;
import java.lang.management.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class MonitorController {

    private static final Logger logger = LoggerFactory.getLogger(MonitorController.class);

    private final DataSource dataSource;

    public MonitorController(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/monitor")
    public String monitorPage() {
        return "monitor";
    }

    @GetMapping("/monitor/gc.do")
    @ResponseBody
    public Map<String, Object> forceGc() {
        long before = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
        System.gc();
        long after = Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory();
        Map<String, Object> r = new LinkedHashMap<>();
        r.put("before", before / 1024 / 1024 + " MB");
        r.put("after",  after  / 1024 / 1024 + " MB");
        r.put("freed",  (before - after) / 1024 / 1024 + " MB");
        logger.info("수동 GC 실행 — before={}MB after={}MB", before/1024/1024, after/1024/1024);
        return r;
    }

    @GetMapping("/monitor/stats.do")
    @ResponseBody
    public Map<String, Object> stats() {
        Map<String, Object> result = new HashMap<>();

        // ── JVM Heap ──────────────────────────────────────────────
        MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
        MemoryUsage heap    = memBean.getHeapMemoryUsage();
        MemoryUsage nonHeap = memBean.getNonHeapMemoryUsage();

        Map<String, Object> heapMap = new LinkedHashMap<>();
        heapMap.put("usedMb",      toMb(heap.getUsed()));
        heapMap.put("committedMb", toMb(heap.getCommitted()));
        heapMap.put("maxMb",       toMb(heap.getMax()));
        heapMap.put("pct",         pct(heap.getUsed(), heap.getMax()));
        result.put("heap", heapMap);

        Map<String, Object> nonHeapMap = new LinkedHashMap<>();
        nonHeapMap.put("usedMb",      toMb(nonHeap.getUsed()));
        nonHeapMap.put("committedMb", toMb(nonHeap.getCommitted()));
        result.put("nonHeap", nonHeapMap);

        // ── 전체 메모리 풀 (Metaspace, Eden, Old Gen, Code Cache 등) ──
        List<Map<String, Object>> pools = new ArrayList<>();
        for (MemoryPoolMXBean pool : ManagementFactory.getMemoryPoolMXBeans()) {
            MemoryUsage mu = pool.getUsage();
            if (mu == null) continue;
            Map<String, Object> p = new LinkedHashMap<>();
            p.put("name",      pool.getName());
            p.put("type",      pool.getType().toString());
            p.put("usedMb",    toMb(mu.getUsed()));
            p.put("committedMb", toMb(mu.getCommitted()));
            long maxVal = mu.getMax();
            p.put("maxMb",     maxVal < 0 ? -1 : toMb(maxVal));
            p.put("pct",       maxVal < 0 ? -1 : pct(mu.getUsed(), maxVal));
            pools.add(p);
        }
        result.put("pools", pools);

        // ── Disk ──────────────────────────────────────────────────
        File root = new File(System.getProperty("user.dir"));
        Map<String, Object> diskMap = new LinkedHashMap<>();
        diskMap.put("totalGb",  toGb(root.getTotalSpace()));
        diskMap.put("freeGb",   toGb(root.getUsableSpace()));
        diskMap.put("pct",      pct(root.getTotalSpace() - root.getUsableSpace(), root.getTotalSpace()));
        result.put("disk", diskMap);

        // ── DB Connections (HikariCP) ─────────────────────────────
        Map<String, Object> dbMap = new LinkedHashMap<>();
        try {
            HikariDataSource hikari = dataSource.unwrap(HikariDataSource.class);
            var poolMx  = hikari.getHikariPoolMXBean();
            int maxPool = hikari.getMaximumPoolSize();
            dbMap.put("maxPool", maxPool);

            if (poolMx == null) {
                dbMap.put("active",  0);
                dbMap.put("idle",    0);
                dbMap.put("total",   0);
                dbMap.put("pending", 0);
                dbMap.put("pct",     0);
                dbMap.put("notReady", true);
            } else {
                int active  = poolMx.getActiveConnections();
                int idle    = poolMx.getIdleConnections();
                int total   = poolMx.getTotalConnections();
                int pending = poolMx.getThreadsAwaitingConnection();
                dbMap.put("active",  active);
                dbMap.put("idle",    idle);
                dbMap.put("total",   total);
                dbMap.put("pending", pending);
                dbMap.put("pct",     pct(active, maxPool));
            }
        } catch (Exception e) {
            logger.warn("HikariCP 풀 정보 조회 실패", e);
            dbMap.put("error", e.getMessage());
        }
        result.put("db", dbMap);

        // ── Threads ───────────────────────────────────────────────
        ThreadMXBean threadBean = ManagementFactory.getThreadMXBean();
        Map<String, Object> threadMap = new LinkedHashMap<>();
        threadMap.put("live",   threadBean.getThreadCount());
        threadMap.put("peak",   threadBean.getPeakThreadCount());
        threadMap.put("daemon", threadBean.getDaemonThreadCount());
        result.put("threads", threadMap);

        // ── Uptime ────────────────────────────────────────────────
        long uptimeSec = ManagementFactory.getRuntimeMXBean().getUptime() / 1000;
        result.put("uptime", String.format("%d시간 %d분 %d초",
                uptimeSec / 3600, (uptimeSec % 3600) / 60, uptimeSec % 60));
        result.put("now", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        return result;
    }

    private long   toMb(long bytes)  { return bytes / 1024 / 1024; }
    private double toGb(long bytes)  { return Math.round(bytes / 1024.0 / 1024.0 / 1024.0 * 10) / 10.0; }
    private int    pct(long u, long m) { return m <= 0 ? -1 : (int)(u * 100 / m); }
}
