<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MOCA System Monitor</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{background:#0d1117;color:#c9d1d9;font-family:'Segoe UI',sans-serif;font-size:14px;min-height:100vh}
header{background:#161b22;border-bottom:1px solid #30363d;padding:14px 24px;display:flex;align-items:center;justify-content:space-between}
header h1{font-size:16px;font-weight:600;color:#f0f6fc;letter-spacing:.5px}
header h1 span{color:#58a6ff}
.hdr-right{display:flex;align-items:center;gap:16px;font-size:12px;color:#8b949e}
.uptime{color:#8b949e}
.dot{width:8px;height:8px;border-radius:50%;background:#238636;display:inline-block;margin-right:6px;animation:pulse 2s infinite}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.4}}
.refresh-btn{background:#21262d;border:1px solid #30363d;color:#c9d1d9;padding:4px 12px;border-radius:6px;cursor:pointer;font-size:12px}
.refresh-btn:hover{background:#30363d}

main{padding:20px 24px;max-width:1200px;margin:0 auto}
.updated{font-size:12px;color:#6e7681;margin-bottom:16px}

/* 섹션 타이틀 */
.section-title{font-size:12px;font-weight:600;color:#8b949e;text-transform:uppercase;letter-spacing:.8px;margin:24px 0 10px}
.section-title:first-of-type{margin-top:0}

/* 카드 그리드 */
.cards{display:grid;gap:12px}
.cards.col2{grid-template-columns:repeat(2,1fr)}
.cards.col4{grid-template-columns:repeat(4,1fr)}
@media(max-width:900px){.cards.col4{grid-template-columns:repeat(2,1fr)}}
@media(max-width:600px){.cards.col2,.cards.col4{grid-template-columns:1fr}}

.card{background:#161b22;border:1px solid #30363d;border-radius:8px;padding:16px}
.card-label{font-size:11px;color:#8b949e;margin-bottom:8px;font-weight:500}
.card-value{font-size:22px;font-weight:700;color:#f0f6fc;line-height:1}
.card-sub{font-size:11px;color:#6e7681;margin-top:6px}

/* 진행바 */
.bar-wrap{background:#21262d;border-radius:4px;height:6px;margin-top:10px;overflow:hidden}
.bar-fill{height:100%;border-radius:4px;transition:width .5s}
.bar-ok{background:#238636}
.bar-warn{background:#d29922}
.bar-danger{background:#da3633}

/* 풀 테이블 */
.pool-table{width:100%;border-collapse:collapse;font-size:13px}
.pool-table th{color:#8b949e;font-weight:500;padding:6px 10px;text-align:left;border-bottom:1px solid #21262d;font-size:11px}
.pool-table td{padding:7px 10px;border-bottom:1px solid #21262d;color:#c9d1d9}
.pool-table tr:last-child td{border-bottom:none}
.pool-table tr:hover td{background:#21262d}
.badge{display:inline-block;padding:1px 7px;border-radius:10px;font-size:11px;font-weight:600}
.badge-heap{background:#0d419d33;color:#58a6ff;border:1px solid #0d419d}
.badge-nonheap{background:#6e40c933;color:#bc8cff;border:1px solid #6e40c9}
.tag-ok{color:#3fb950}
.tag-warn{color:#d29922}
.tag-danger{color:#f85149}

/* DB 상태 */
.db-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}
@media(max-width:600px){.db-grid{grid-template-columns:1fr 1fr}}
.db-item{background:#0d1117;border:1px solid #21262d;border-radius:6px;padding:12px;text-align:center}
.db-item-val{font-size:20px;font-weight:700;color:#f0f6fc}
.db-item-lbl{font-size:11px;color:#6e7681;margin-top:4px}
.db-pending{color:#f85149 !important}

.loading{color:#8b949e;font-size:13px;padding:40px 0;text-align:center}
.error-msg{background:#da363322;border:1px solid #da3633;border-radius:6px;padding:12px;color:#f85149;font-size:13px;margin-top:8px}
</style>
</head>
<body>
<header>
  <h1><span>MOCA</span> System Monitor</h1>
  <div class="hdr-right">
    <span id="uptimeTxt" class="uptime"></span>
    <span><span class="dot"></span><span id="nowTxt">연결 중...</span></span>
    <button class="refresh-btn" onclick="load()">새로고침</button>
    <button class="refresh-btn" style="background:#21262d;border-color:#da3633;color:#f85149" onclick="forceGc()">GC 실행</button>
  </div>
</header>

<main>
  <div class="updated" id="updatedTxt">로딩 중...</div>

  <!-- JVM 힙 메모리 -->
  <div class="section-title">JVM Heap Memory</div>
  <div class="cards col4" id="heapCards">
    <div class="loading">데이터 로딩 중...</div>
  </div>

  <!-- Non-Heap / Metaspace -->
  <div class="section-title">Non-Heap Memory Pools</div>
  <div class="card" id="poolCard">
    <div class="loading">데이터 로딩 중...</div>
  </div>

  <!-- 디스크 -->
  <div class="section-title">Disk Space</div>
  <div class="cards col2" id="diskCards">
    <div class="loading">데이터 로딩 중...</div>
  </div>

  <!-- DB 커넥션 -->
  <div class="section-title">DB Connection Pool (HikariCP)</div>
  <div class="card" id="dbCard">
    <div class="loading">데이터 로딩 중...</div>
  </div>

  <!-- 스레드 -->
  <div class="section-title">Threads</div>
  <div class="cards col4" id="threadCards">
    <div class="loading">데이터 로딩 중...</div>
  </div>
</main>

<script>
function barClass(pct) {
  if (pct < 0)  return 'bar-ok';
  if (pct >= 85) return 'bar-danger';
  if (pct >= 60) return 'bar-warn';
  return 'bar-ok';
}
function tagClass(pct) {
  if (pct < 0)  return 'tag-ok';
  if (pct >= 85) return 'tag-danger';
  if (pct >= 60) return 'tag-warn';
  return 'tag-ok';
}
function bar(pct) {
  var w = pct < 0 ? 0 : pct;
  return '<div class="bar-wrap"><div class="bar-fill ' + barClass(pct) + '" style="width:' + w + '%"></div></div>';
}
function pctLabel(pct) {
  if (pct < 0) return '<span class="tag-ok">제한없음</span>';
  return '<span class="' + tagClass(pct) + '">' + pct + '%</span>';
}
function card(label, value, sub, pct) {
  return '<div class="card"><div class="card-label">' + label + '</div>'
    + '<div class="card-value">' + value + '</div>'
    + '<div class="card-sub">' + (sub||'') + '</div>'
    + (pct !== undefined ? bar(pct) : '')
    + '</div>';
}

function load() {
  fetch('/monitor/stats.do')
    .then(function(r){ return r.json(); })
    .then(function(d) {
      document.getElementById('nowTxt').textContent    = d.now || '';
      document.getElementById('uptimeTxt').textContent = '가동: ' + (d.uptime || '');
      document.getElementById('updatedTxt').textContent = '최종 갱신: ' + (d.now || '') + ' (5초마다 자동 갱신)';

      /* ── Heap ── */
      var h = d.heap || {};
      document.getElementById('heapCards').innerHTML =
        card('사용 중 / 전체',      h.usedMb + ' MB / ' + h.maxMb + ' MB', '', h.pct)
      + card('확보됨 (Committed)', h.committedMb + ' MB', '실제 OS에서 확보한 메모리')
      + card('여유 (Free)',         (h.maxMb - h.usedMb) + ' MB', '-Xmx ' + h.maxMb + ' MB 기준')
      + card('사용률',              h.pct + '%', h.pct >= 85 ? '⚠ 위험: GC 부하 높음' : h.pct >= 60 ? '주의' : '정상', h.pct);

      /* ── Memory Pools ── */
      var pools = d.pools || [];
      var rows = pools.map(function(p) {
        var isNH = p.type === 'Non-heap memory';
        var badge = isNH
          ? '<span class="badge badge-nonheap">Non-Heap</span>'
          : '<span class="badge badge-heap">Heap</span>';
        var maxStr   = p.maxMb < 0 ? '<span class="tag-ok">제한없음</span>' : p.maxMb + ' MB';
        var pctStr   = pctLabel(p.pct);
        var barHtml  = p.pct < 0
          ? '<div class="bar-wrap"><div class="bar-fill bar-ok" style="width:0%"></div></div>'
          : '<div class="bar-wrap" style="margin-top:4px"><div class="bar-fill ' + barClass(p.pct) + '" style="width:' + p.pct + '%"></div></div>';
        return '<tr>'
          + '<td>' + badge + ' ' + p.name + '</td>'
          + '<td class="tar"><b>' + p.usedMb + '</b> MB</td>'
          + '<td class="tar">' + p.committedMb + ' MB</td>'
          + '<td class="tar">' + maxStr + '</td>'
          + '<td style="min-width:120px">' + pctStr + barHtml + '</td>'
          + '</tr>';
      }).join('');

      document.getElementById('poolCard').innerHTML =
        '<table class="pool-table">'
        + '<thead><tr><th>Pool 이름</th><th class="tar">Used</th><th class="tar">Committed</th><th class="tar">Max</th><th>사용률</th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>';

      /* ── Disk ── */
      var dk = d.disk || {};
      document.getElementById('diskCards').innerHTML =
        card('디스크 사용', (dk.totalGb - dk.freeGb).toFixed(1) + ' GB / ' + dk.totalGb + ' GB', '사용 중 / 전체', dk.pct)
      + card('디스크 여유', dk.freeGb + ' GB', '사용 가능한 공간');

      /* ── DB ── */
      var db = d.db || {};
      if (db.error) {
        document.getElementById('dbCard').innerHTML = '<div class="error-msg">커넥션 풀 조회 오류: ' + db.error + '</div>';
      } else if (db.notReady) {
        document.getElementById('dbCard').innerHTML = '<div style="color:#8b949e;font-size:13px;padding:8px 0">아직 DB 커넥션이 생성되지 않았습니다. 화면에 한 번 접속하면 풀이 초기화됩니다. (Max Pool: ' + db.maxPool + ')</div>';
      } else {
        var pend = db.pending > 0 ? '<span class="db-item-val db-pending">' + db.pending + '</span>' : '<span class="db-item-val">0</span>';
        document.getElementById('dbCard').innerHTML =
          '<div class="db-grid">'
          + '<div class="db-item"><div class="db-item-val tag-danger">' + db.active  + '</div><div class="db-item-lbl">Active (사용 중)</div></div>'
          + '<div class="db-item"><div class="db-item-val tag-ok">'     + db.idle    + '</div><div class="db-item-lbl">Idle (대기)</div></div>'
          + '<div class="db-item"><div class="db-item-val">'            + db.total   + ' / ' + db.maxPool + '</div><div class="db-item-lbl">Total / Max Pool</div></div>'
          + '<div class="db-item">' + pend + '<div class="db-item-lbl">Pending (대기 스레드)</div></div>'
          + '<div class="db-item"><div class="db-item-val ' + tagClass(db.pct) + '">' + db.pct + '%</div><div class="db-item-lbl">풀 사용률</div></div>'
          + '</div>'
          + bar(db.pct);
      }

      /* ── Threads ── */
      var t = d.threads || {};
      document.getElementById('threadCards').innerHTML =
        card('현재 스레드', t.live   + ' 개', 'Live threads')
      + card('최대치',       t.peak   + ' 개', 'Peak thread count')
      + card('데몬 스레드',  t.daemon + ' 개', 'Daemon threads')
      + card('사용자 스레드',(t.live - t.daemon) + ' 개', 'User threads');
    })
    .catch(function(e) {
      document.getElementById('updatedTxt').textContent = '오류: ' + e.message;
    });
}

function forceGc() {
  fetch('/monitor/gc.do')
    .then(function(r){ return r.json(); })
    .then(function(d) {
      alert('GC 완료\n실행 전: ' + d.before + '\n실행 후: ' + d.after + '\n해제: ' + d.freed);
      load();
    });
}

load();
setInterval(load, 5000);
</script>
</body>
</html>
