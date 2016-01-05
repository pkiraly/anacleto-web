<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>termList</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <style type="text/css">
  tr.selected {
  	background-color: #ccc;
  }
  </style>
  <script type="text/JavaScript" language="JavaScript" src="js/termListFragment.js"></script>
</head>
<body>

<bean:define id="pattern" name="termListFragmentForm" property="pattern" />
<html:form action="/termListFragment" method="get">
	<html:hidden property="pattern"/>
	<html:hidden property="offset"/>
	<html:hidden property="pageNumber"/>
	<html:hidden property="selectedField"/>

<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0">
<logic:present name="termListFragmentForm" property="termColl">
	<tr>
		<td align="left" colspan="2"><html:image src="icons/e_up.gif" 
				titleKey="arcquery.pageUp" 
				property="prevButt"
				onclick="getFirstTerm();" 
				style="display: inline" /></td>								
		<td align="right"><html:image src="icons/e_down.gif" 
				titleKey="arcquery.pageDown" 
				property="nextButt" 
				onclick="getLastTerm();"
				style="display: inline" /></td>								
	</tr>
	<tr class="header2">
		<td align="center" width="20" style="font-weight: bold; color: maroon; font-size: bigger;"></td>
		<td><bean:message key="termquery.term" /></td>
		<td align="right" width="10%"><bean:message key="termquery.freq" /></td>
	</tr>
<logic:iterate id="termBean" name="termListFragmentForm" property="termColl">
<tr valign="top"<logic:equal name="termBean" property="term" value="${pattern}"
	> class="selected"</logic:equal>>
	<td align="left" width="20"><input type="checkbox" name="selectedTerms" value="<bean:write name="termBean" property="term" />" onClick="checkBoxClicked(this)"/></td>
	<td><bean:write name="termBean" property="term" filter="false" /></td>
	<td align="right"><bean:write name="termBean" property="freq"/></td>
</tr></logic:iterate>
</logic:present>
</table>
</html:form>
</body>
</html>
