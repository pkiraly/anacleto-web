<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>pdf document in inline frame</title>
</head>
<body marginheight="0" marginwidth="0">

<iframe id="pdf1" src="<bean:write name="pdfHolderForm" property="url" filter="true" />" 
width="100%" height="100%" style="width: 100%; height: 100%; margin: 0;" align="left">
[Your browser does <em>not</em> support <code>iframe</code>, or has been 
configured not to display inline frames.]
</iframe>

</body>
</html>
