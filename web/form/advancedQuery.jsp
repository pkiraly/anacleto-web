<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"	prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"	prefix="html"%>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="Author" content="Kelvin Tan">
  <title>Lucene Query Constructor Demo and Introduction</title>
<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<script type="text/javascript" src="js/luceneQueryConstructor.js"></script>
<script type="text/javascript" src="js/luceneQueryValidator.js"></script>
<script type="text/javascript">
submitForm = true // necessary for luceneQueryConstructor not to submit the form upon query construction
function doSubmitForm(frm) {
  if(frm["noField-phrase-input"].value.length > 0)
    frm["noField-phrase"].value = quote(frm["noField-phrase-input"].value)
  else if(frm["noField-phrase"].value.length > 0)
    frm["noField-phrase"].value = ''
  doMakeQuery(frm.query);
  frm.submit();
}
</script>
</head>

<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" marginheight="0" marginwidth="0">

<html:form action="/searchResult.do" target="content">

	<table cellspacing="0" cellpadding="5" border="0" width="100%">
		<tr>
			<td class="header2"><bean:message key="advancedquery.title" /></td>
		</tr>
	</table>
	<table cellspacing="0" cellpadding="5" border="0" width="100%">
		<tr>
			<th></th>
			<td width="25%"></td>
		</tr>
		<tr>
			<th><input name="noField-andModifier" value="+|0" type="hidden">
			<b><bean:message key="advancedquery.findres" /></b></th>
			<td><bean:message key="advancedquery.withall" /></td>
			<td><input type="text" class="header2" name="noField-and" size="25">
			</td>
		</tr>
		<tr>
			<th><input name="noField-phraseModifier" value="+|+" type="hidden"></th>
			<td><bean:message key="advancedquery.withexact" /></td>
			<td><input type="text" name="noField-phrase-input" class="header2"
				size="25"> <input type="hidden" name="noField-phrase"></td>
		</tr>
		<tr>
			<th><input name="noField-orModifier" value=" |+" type="hidden"></th>
			<td><bean:message key="advancedquery.withone" /></td>
			<td><input type="text" name="noField-or" class="header2" size="25"></td>
		</tr>
		<tr>
			<th><input name="noField-notModifier" value="-|0" type="hidden"></th>
			<td><bean:message key="advancedquery.without" /></td>
			<td><input type="text" name="noField-not" class="header2" size="25">
			</td>

		</tr>
		<tr>
			<th><b><bean:message key="application.ssearch" /></B></th>
			<td></td>
			<td align="left"><html:image src="icons/e_search.gif"
				title="Start Search" property="search"
				onclick="doSubmitForm(this.form);" /></td>
		</tr>
	</table>
	<input type="hidden" name="query" />
</html:form>
</body>
</html>
