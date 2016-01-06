<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"	 prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html"	 prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"   prefix="logic"
%><%@ taglib uri="http://tesujionline.com/anacleto/anacleto.tld" prefix="anacleto"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <title>Anacleto</title>
<script type="text/JavaScript">
var intervalId = null;
var currentLoc = '';

function checkLocationOfContent() {
	var now = new Date();
	var time = now.getMinutes() 
						+ ':' + now.getSeconds()
						+ ',' + now.getMilliseconds();

	var oCnt = getContentRef();
	var oCntHead = getContentHeadRef();
	if(oCntHead == null || ! getLoc(oCntHead)) {
		return;
	}
	if(currentLoc != getLoc(oCntHead)) {
		currentLoc = getLoc(oCntHead);
		if(currentLoc.indexOf("welcome.jsp") == -1) {
			window.top.redrawContentHead = true;
			window.top.showContentHead();
			window.top.redrawContentHead = false;
		}
	}
}

function getContentHeadRef() {
	// var oFrm = top.document.getElementById('content');
	var oFrm = window.top.frames['contentHead'];
	return oFrm;
}

function getContentRef() {
	// var oFrm = top.document.getElementById('content');
	var oFrm = window.top.frames['content'];
	return oFrm;
}

function getLoc(oFrm) {
	var oFrm = window.top.frames['contentHead'];
	return oFrm.window.location.href;
}
intervalId = setInterval(checkLocationOfContent, 1000);
</script>
</head>
<body style="margin:0; padding:0;">

<table cellpadding="0" cellspacing="0" width="100%" border="0" height="20">
  <tr bgcolor="#4682B4" valign="middle" height="20">
    <td align="right" nowrap style="padding-right:10px;">
      |&nbsp;<html:link styleClass="white" action="/arcanumFieldQuery" target="content"><bean:message key="header.advquery" /></html:link>&nbsp;
      |&nbsp;<html:link styleClass="white" href="welcome.jsp" target="content"><bean:message key="header.home" /></html:link>&nbsp;
      |&nbsp;<html:link styleClass="white" href="form/logout.jsp" target="content"><bean:message key="header.logout" /></html:link>
    </td>
  </tr>
</table>

</body>
</html>