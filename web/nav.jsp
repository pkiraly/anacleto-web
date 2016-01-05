<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>navigation frameset</title>
<script language="JavaScript" type="text/JavaScript">
<!--
function xGetElementById(e) {
  if(typeof(e)!='string') return e;
  if(document.getElementById) e=document.getElementById(e);
  else if(document.all) e=document.all[e];
  else e=null;
  return e;
}
//-->
</script>
</head>

<frameset id="navigationFrameset" rows="*,25" style="border: 0; padding: 0" border="0" frameborder="no">
  <frame src="navigationContent.jsp" name="navigationContent" id="navigationContent" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" >
  <frame src="navigationSelector.jsp" name="navigationSelector" id="navigationSelector" scrolling="no" frameborder="0" marginwidth="0" marginheight="0" >
</frameset>

<body bgcolor="#ffffff" text="#000000" link="#ff0000" vlink="#800000" alink="#ff00ff">

</body>
</html>
