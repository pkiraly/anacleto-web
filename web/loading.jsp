<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><bean:message key="loading.title" /></title>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type="text/css">
body, #content {
	background-color: white;
	text-align: center;
}
</style>
</head>
<body>
<div id="content">
<p><img src="image/ajax-loader.gif" alt="<bean:message key="loading.load" />"></p>
<h1><bean:message key="loading.load" /></h1>
</div>
</body>
</html>
