<%@ page language="java" contentType="text/html; charset=UTF-8"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>Advanced Query</title>
  <script type="text/JavaScript" language="JavaScript" src="js/arcanumFieldQuery.js?rand=<% java.util.Random rand = new java.util.Random(); out.write( "" + rand.nextInt());%>"></script>
  <script type="text/JavaScript" language="JavaScript" src="js/arcanumFieldQueryTab.js"></script>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <link rel="stylesheet" type="text/css" href="css/arcanumFieldQuery.css">

<script type="text/JavaScript" language="JavaScript">
var alertNoproxDistance = '<bean:message key="arcquery.alertNoproxDistance" />';
var alertNoinput = '<bean:message key="arcquery.alertNoinput" />';
</script>
</head>

<body onload="init()" onUnload="onUnload_handler()">

<table cellspacing="0" cellpadding="0" border="0" width="100%" 
  style="height: 100%; min-height: 400px;">
	<tr valign="top" style="height: 25px">
		<td class="header2" align="center" valign="middle">
			<bean:message key="arcquery.title" />
		</td>
		<td class="header2" align="center" valign="middle">
			<bean:message key="arcquery.termList" />
		</td>
	</tr>
		
	<tr valign="top">
   <td width="50%" style="border-left: 2px solid #89c0d7; border-right: 2px solid #89c0d7;">
		<table cellspacing="10" cellpadding="0" border="0" width="100%"
         style="margin: 0;">
			<tr>
				<td colspan="2">
					<bean:message key="arcquery.head1" />
					<bean:message key="arcquery.head2" />
				</td>
			</tr>
    </table>

<div id="searchFormContainer" class="yui-navset">
	<ul class="yui-nav">
		<li id="fieldQueryTabButton" style="background-color: #fff;"><a href="#tab1" onclick="toggleTab('fieldQueryTab')"><bean:message key="arcquery.fieldSearch" /></a></li>
		<li id="proximityQueryTabButton"><a href="#tab2" onclick="toggleTab('proximityQueryTab')"><bean:message key="arcquery.proximity" /></a></li>
	</ul>
	<div class="yui-content">

<div id="fieldQueryTab">
<form action="arcanumFieldQuery.do" name="field_searchform" onsubmit="return submitQuery(this);">
<input type="hidden" name="queryString" />
<table cellspacing="1" cellpadding="0" border="0" width="100%" style="margin: 0; padding: 0;">
	<tr>
		<td class="fieldName" width="30%"><bean:message key="arcquery.fieldname" /></td>
		<td style="padding-left: 10px;"><bean:message key="arcquery.searchCriteria" /></td>
	</tr>
	<tr>
		<td class="fieldName"><bean:message key="arcquery.fieldContent" /></td>
		<td><input type="text" name="content" value="<bean:write name="arcanumFieldQueryForm" property="content" />" class="header2" />
			<a href="#" onclick="showTermList('content')" 
			title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		</td>
	</tr>
<!-- 
	<tr>
		<td class="fieldName"><bean:message key="arcquery.fieldCreator" /></td>
		<td><input type="text" name="creator" value="<bean:write name="arcanumFieldQueryForm" property="creator" />" class="header2" />
			<a href="#" onclick="showTermList('creator')" title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		</td>
	</tr>
 -->
 	<tr>
		<td class="fieldName"><bean:message key="arcquery.fieldTitle" /></td>
		<td><input type="text" name="title" value="<bean:write name="arcanumFieldQueryForm" property="title" />" class="header2" />
			<a href="#" onclick="showTermList('title')" title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		</td>
	</tr>
<!-- 
	<tr>
		<td class="fieldName"><bean:message key="arcquery.fieldPicture" /></td>
		<td><input type="text" name="picture" value="<bean:write name="arcanumFieldQueryForm" property="picture" />" class="header2" />
			<a href="#" onclick="showTermList('picture')" title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		</td>
	</tr>
 	<tr>
		<td class="fieldName"><bean:message key="arcquery.fieldPagenumber" /></td>
		<td><input type="text" name="pageNr" value="<bean:write name="arcanumFieldQueryForm" property="pagenumber" />" class="header2" />
			<a href="#" onclick="showTermList('pageNr')" title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		</td>
	</tr>
 -->
	<tr>
		<td class="fieldName"><bean:message key="arcquery.innerOperator" /></td>
		<td>
			<input type="radio" name="innerOperator" value="AND" />
			<a href="javascript:void(0)" onClick="selectRadio( 'innerOperator', 0 ); return false;">
			<bean:message key="arcquery.AND" /></a>
				
			<input type="radio" name="innerOperator" value="OR" checked />
			<a href="javascript:void(0)" onClick="selectRadio( 'innerOperator', 1 ); return false;">
			<bean:message key="arcquery.OR" /></a>
	
			<input type="radio" name="innerOperator" value="NOT" />
			<a href="javascript:void(0)" onClick="selectRadio( 'innerOperator', 2 ); return false;">
			<bean:message key="arcquery.NOT" /></a>
	
			<input type="radio" name="innerOperator" value="EX" />
			<a href="javascript:void(0)" onClick="selectRadio( 'innerOperator', 3 ); return false;">
			<bean:message key="arcquery.exact" /></a>
		</td>
	</tr>
	<tr>
		<td class="fieldName"><bean:message key="arcquery.interOperator" /></td>
		<td>
			<input type="radio" name="interOperator" value="AND" checked />
			<a href="javascript:void(0)" onClick="selectRadio( 'interOperator', 0 ); return false;">
			<bean:message key="arcquery.AND" /></a>

			<input type="radio" name="interOperator" value="OR" />
			<a href="javascript:void(0)" onClick="selectRadio( 'interOperator', 1 ); return false;">
			<bean:message key="arcquery.OR" /></a>
		</td>
	</tr>
	<tr>
		<td class="fieldName"><bean:message key="arcquery.acceptSimil" /></td>
		<td><input type="checkbox" name="similarities" value="<bean:write name="arcanumFieldQueryForm" property="similarities" />" class="header2" />
			<select id="similaritiesPercent" name="similaritiesPercent">
				<option value="0.5">50%</option>
				<option value="0.55">55%</option>
				<option value="0.6">60%</option>
				<option value="0.65">65%</option>
				<option value="0.7">70%</option>
				<option value="0.75" selected>75%</option>
				<option value="0.8">80%</option>
				<option value="0.85">85%</option>
				<option value="0.9">90%</option>
				<option value="0.95">95%</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="fieldName"></td>
		<td><input type="submit" value="<bean:message key="arcquery.startSearch"/>" onclick="setFormType('general');"></td>
	</tr>
</table>
</form>
</div><!--* /fieldQueryTab *-->

<div id="proximityQueryTab">
<form action="arcanumFieldQuery.do" name="proximity_searchform" id="proximity_searchform" onsubmit="return submitQuery(this);">
<input type="hidden" name="queryString" />
<table width="100%">
	<tr>
		<td class="fieldName" width="30%"><bean:message key="arcquery.proximity" /></td>
		<td><input type="text" name="proximity" value="<bean:write name="arcanumFieldQueryForm" property="proximity" />" class="header2" />
		 <a href="#" onclick="showTermList('content')" title='<bean:message key="arcquery.showIndex" />'>
			[index]</a>
		  </td>
	</tr>
	<tr>
		<td class="fieldName"><bean:message key="arcquery.proxDistance" /></td>
		<td><input type="text" name="proxDistance" value="<bean:write name="arcanumFieldQueryForm" property="proxDistance" />" class="header2" /></td>
	</tr>
	<tr>
		<td class="fieldName"></td>
		<td><input type="submit" value="<bean:message key="arcquery.startSearch"/>" onclick="setFormType('proxy');"></td>
	</tr>
</table>
</form>
</div><!--* /proximityQueryTab *-->
</div><!--* /yui-content *-->
</div><!--* /searchFormContainer *-->
</td><!--* /left side *-->

<!--* right side *-->
<td width="50%" valign="top">
<form name="indexListForm" onsubmit="return false;">
	<input type="hidden" name="selectedField" value="content" />
	
	<div style="padding-left: 20px">
		<bean:message key="arcquery.firstletters" />:
		<input type="text" name="firstLetters" class="header2" onkeyup="onType();" />
		
		<bean:message key="arcquery.field" />: <span id="selectedFieldNameContainer" class="container">content</span>
	</div>
</form>
	<iframe name="dynLoadFrame" 
					id="dynLoadFrame" 
					src="termListFragment.do?pattern=a&amp;selectedField=content" 
					title="dynLoadTitle" 
					frameborder="1" 
					width="99%" 
					align="center" 
					height="90%" 
					scrolling="auto">
			<bean:message key="termquery.browsererr" />
	</iframe>
</td><!--* /right side *-->

		</tr>
	</table>
</body>
</html>
