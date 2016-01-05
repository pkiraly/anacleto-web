<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"	prefix="bean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Footer</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type="text/css">
a, a:link, a:active, a:visited, a:hover {
  color: white;
}
</style>
</head>

<body style="margin:0; padding:0">

<table cellpadding="0" cellspacing="0" width="100%" border="0">
  <tr class="header1" style="">
    <td style="color: white; padding-left: 5pt;" width="25">
      <a href="http://www.tesuji.eu/" target="_top" class="white">
        <img src="image/tesuji_mini_logo.jpg" 
             border="0" 
             alt="Tesuji S.r.l."
             height="20" align="middle">
      </a>
    </td>
    <td align="left" style="color: white;">
      <bean:message key="footer.copy" />
    </td>
    <td align="right" style="color: white; padding-right: 5pt; vertical-align: middle;">
    |<a href="http://www.tesuji.eu/" target="_top">
    <bean:message key="footer.visitus" /></a></td>
 </tr>
</table>

</body>
</html>
