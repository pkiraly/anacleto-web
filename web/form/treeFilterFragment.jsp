<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>treeFilterFragment</title>
<script type="text/JavaScript" language="JavaScript">
function onloadHandler()
{
  var oTree = [ <bean:write name="treeFilterFragmentForm" property="menuDesc" filter="false"/> ];
  var oTreeStr = "<bean:write name="treeFilterFragmentForm" property="menuDesc" filter="false"/>";
  if( parent.location != self.location )
  {
    parent.oTreeStr = oTreeStr;
    parent.upload_complete( oTree );
  } else {
    var oBody = document.getElementsByTagName( 'body' )[0];
    oBody.innerHTML = oTreeStr;
  }
}
</script>
</head>  
<body onload="onloadHandler()">
</body>
</html>
