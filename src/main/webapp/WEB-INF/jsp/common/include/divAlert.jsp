<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.divAlertControl { display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:99999; }
.divAlertMain { position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); background:#fff; border-radius:8px; padding:24px; min-width:280px; box-shadow:0 4px 20px rgba(0,0,0,.3); z-index:2; }
.divAlertContentArea { padding:16px 0; font-size:15px; text-align:center; }
.divAlertBtnArea { text-align:center; }
.divAlertBtn { background:#786bbf; color:#fff; border:none; border-radius:6px; padding:8px 24px; cursor:pointer; font-size:14px; }
.divAlertBack { position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,.45); z-index:1; }
</style>
<div class="divAlertControl">
    <div class="divAlertMain">
        <div class="divAlertContentArea"><div class="divAlertContent"></div></div>
        <div class="divAlertBtnArea"><button class="divAlertBtn" onclick="DIV_CLOSE();">확인</button></div>
    </div>
    <div class="divAlertBack"></div>
</div>
