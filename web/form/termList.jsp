<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP for termListForm form</title>
<script language="JavaScript" type="text/javascript">
var LN = "\n";
  
function onchangeHandler() {
  var field   = document.forms[0].elements['selectedField'].value;
  var pattern = document.forms[0].elements['pattern'].value;
  
  setTimeout(function(){uptadeValues(field, pattern);}, 1000);
  
  /*
  var location = "termListFragment.do"
               + "?pattern=" + pattern 
               + "&selectedField=" + field;
  frames['dynLoadFrame'].location = location;
  */
}

function uptadeValues(origField, origPattern) {
  var pattern = document.forms[0].elements['pattern'].value;
  var field   = document.forms[0].elements['selectedField'].value;
  
  // refresh only if the data are the same - preventing too much server calls
  if(pattern == origPattern) {
	  var location = "termListFragment.do"
  	             + "?pattern=" + pattern 
    	           + "&selectedField=" + field;
	  frames['dynLoadFrame'].location = location;
	} else {
		alert('it is changed since');
	}
}

function getSelectedTerms() {
  var selectedTerms = document.forms[0].elements['selectedTerms'];
  if ( selectedTerms == null )
    return;
    
  var terms = frames['dynLoadFrame'].document.forms['termListFragmentForm'].elements;
  terms.value = "";
  selectedTerms.value = "";

  for (var i=0; i < terms.length; i++) {
    if (terms[i].checked==true) {
      if( selectedTerms.value != "" ) {
        selectedTerms.value += " OR ";
      }
      selectedTerms.value += terms[i].value;
    }
  }
}
</script>
</head>

<body style="margin: 0" onLoad="document.forms[0].elements[1].focus()">

<html:form action="/termList" target="content" enctype="utf-8" 
	onsubmit="return false;">
<html:hidden property="selectedTerms" />
	
<table cellspacing="0" cellpadding="5" border="0" width="100%" style="height: 100%; min-height: 400px;">
  <tr style="height: 100%">
	<td width="50%" align="left" valign="top" style="height: 100%">

	<table cellspacing="0" cellpadding="5" border="0" width="100%">
		<tr>
			<td class="header2"><bean:message key="termquery.title" /></td>
		</tr>
		<tr>
			<td><bean:message key="termquery.desc" /></td>
		</tr>
	</table>

	<table cellspacing="0" cellpadding="5" border="0" width="100%" align="left">
		<tr valign="top">
			<td><bean:message key="termquery.term" /></td>
			<td><html:text styleClass="header2" property="pattern" 
				value="" onkeyup="onchangeHandler()" /></td>
		</tr>
		<tr valign="top">
			<td><bean:message key="termquery.field" /></td>
			<td><html:select name="termListForm"
			                 property="selectedField"
			                 value=""
			                 onchange="onchangeHandler()" >
             <html:options styleClass="header2"
                           name="termListForm"
                           property="fieldList" />
   			</html:select></td>
		</tr>
		<tr valign="top">
			<td><b><bean:message key="termquery.search" /></b></td>
			<td><html:image src="icons/e_search.gif" 
			                altKey="application.ssearch"
			                titleKey="application.ssearch"
			                property="queryButt"
			                onkeyup="getSelectedTerms()" /></td>
		</tr>
	</table>
    </td>
    <td width="50%"><iframe name="dynLoadFrame"
        id="dynLoadFrame"
        src="termListFragment.do?i=<% java.util.Random rand = new java.util.Random(); out.write(rand.nextInt());%>"
        title="dynLoadTitle"
        frameborder="1"
        width="100%"
        align="left" 
        height="90%"
        scrolling="auto"></iframe></td>
 </tr>
</table>

</html:form>

</body>
</html>
