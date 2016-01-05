<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://tesujionline.com/anacleto/anacleto.tld" prefix="anacleto"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <title>Anacleto</title>
<script language="JavaScript" type="text/javascript">
function hideContentHead()
{
  top.redrawContentHead = true;
  top.hideContentHead();
}
</script>
</head>
<body style="margin:0; padding:0;">

<table cellpadding="0" cellspacing="0" width="100%" border="0" height="63">
  <tr>
    <td align="left"><img src="image/anacleto.gif" border="0" alt="Anacleto Digital Library"></td>
  </tr>
</table>

<html:form action="/searchResult.do" target="content" onsubmit="this.maxResult.value = top.maxResult;">
  <input type="hidden" name="maxResult" value="10" />
<div style="background-color: #4682B4; font-size: 8pt; padding: 0 0 0 10px;">
  <span style="vertical-align: 2px; color: white; font-weight: bold;">
	<bean:message key="searchres.search" />:
  </span>
  <html:text property="query" size="20" styleClass="header2" />
  <html:image src="icons/e_search.gif" titleKey="searchres.startSearch" 
    altKey="searchres.startSearch" 
    property="search" style="border: 0;" />
</div>
</html:form>

</body>
</html>
