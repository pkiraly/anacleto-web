<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"	prefix="bean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><bean:message key="treehead.resources"/></title>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
</head>

<body>
<div style="height: 25px;">
  <div class="header2" style="padding: 4px 0 3px 0px; text-align: center;">
<script language="JavaScript" type="text/javascript">
if( window.parent.frames[1].location.href.indexOf( 'treeFilter' ) > -1 )
{
  document.write( '<bean:message key="treehead.queryterm"/>: ' + top.query );
} else {
  document.write( '<bean:message key="treehead.resources"/>' );
}
</script>
  </div>
</div>

</body>
</html>
