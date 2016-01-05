<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"  prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"  prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>fieldQuery form</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
</head>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0"
	marginheight="0" marginwidth="0">

<html:form action="/fieldQuery">

	<table cellspacing="0" cellpadding="5" border="0" width="100%">
		<tr>
			<td class="header2"><bean:message key="fieldquery.title" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.desc" /></td>
		</tr>


	</table>

	<table cellpadding="5" cellspacing="0" cellpadding="10" border="0"
		width="50%" align="center">
		<tr>
			<td><b><bean:message key="fieldquery.field" /></b></td>
			<td><b><bean:message key="fieldquery.crite" /></b></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.titlef" /></td>
			<td><html:text property="title" styleClass="header2" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.authf" /></td>
			<td><html:text property="author" styleClass="header2" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.editf" /></td>
			<td><html:text property="editor" styleClass="header2" /></td>
		</tr>
		
		<tr>
			<td><bean:message key="fieldquery.publf" /></td>
			<td><html:text property="publisher" styleClass="header2" /></td>
		</tr>

		<tr>
			<td><bean:message key="fieldquery.pubaf" /></td>
			<td><html:text property="pubPlace" styleClass="header2" /></td>
		</tr>

		<tr>
			<td><bean:message key="fieldquery.pubif" /></td>
			<td><html:text property="pubDate" styleClass="header2" /></td>
		</tr>

		<tr>
			<td><bean:message key="fieldquery.contf" /></td>
			<td><html:text property="content" styleClass="header2" /></td>
		</tr>

		<tr>
			<td><bean:message key="fieldquery.allfi" /></td>
			<td><html:checkbox property="andLogic" styleClass="header2" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.simila" /></td>
			<td><html:checkbox property="similarities" styleClass="header2" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.exact" /></td>
			<td><html:checkbox property="exactMatch" styleClass="header2"/></td>
		</tr>

		<tr></tr>

		<tr>
			<td><bean:message key="fieldquery.prox" /></td>
			<td><html:text property="proximity" styleClass="header2" /></td>
		</tr>
		<tr>
			<td><bean:message key="fieldquery.dist" /></td>
			<td><html:text property="proxDistance" styleClass="header2" /></td>
		</tr>

		
		<tr>
			<td><b><bean:message key="application.ssearch" /></b></td>
			<td><html:image src="icons/e_search.gif" title="Start search"
				property="queryButt" /></td>
		</tr>
	</table>
</html:form>
</body>
</html>
