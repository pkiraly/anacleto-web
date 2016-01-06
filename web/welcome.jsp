<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><bean:message key="index.title" /></title>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type="text/css">
body {
  background-color: white;
}
#main {
  margin: 20px;
}

h1 {
  text-align: center;
}

p.targy {
  margin: 5px;
}
p.targy2 {
  margin: 5px 5px 5px 15px;
}
</style>
</head>

<body>

<div style="height: 25px;">
  <div class="header2" style="padding: 4px 0 3px 10px;">
 Századok
  </div>
</div>

<div id="main">
<h1>Századok</h1>

<p align="center"><img src="image/arcanum_logo.jpg" title="<bean:message key="welcome.arcanum" /> - logo"></p>

<% 
	org.securityfilter.realm.SimplePrincipal principal = (org.securityfilter.realm.SimplePrincipal)session.getAttribute(
		"org.securityfilter.filter.SecurityRequestWrapper.PRINCIPAL");
	if(null == principal) {
%>
<form method="POST" action="j_security_check" target="_top">
<table width="30%" align="center">
	<tr>
		<td width="20%" align="right"><bean:message key="login.user" /></td>
		<td><input type="text" name="j_username" class="header2" /></td>
	</tr>
	<tr>
		<td align="right"><bean:message key="login.password" /></td>
		<td><input type="password" name="j_password" class="header2"/></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="Login" />&nbsp; 
			<input type="reset"  value="Clear"/>
		</td>
	</tr>
</table>
</form>
<% } else { %>
<center>
	<% out.print("<!-- Et tu mi fili " + principal.getName() + "? -->"); %>
	<bean:message key="login.user" />: <% out.print(principal.getName()); %>
</center>
<% } %>

<p align="right"><img src="image/nka_logo.jpg" title="Nemzeti Kulturális Alap - logo"></p>
<p align="right">Az adatbázis elkészítését a Nemzeti Kulturális Alap támogatása tette lehetővé</p>
</div>


</body>
</html>
