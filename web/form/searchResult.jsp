<%@ page pageEncoding="UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"   prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"   prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"  prefix="logic"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <title><bean:message key="searchres.title" /></title>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type="text/css">
b { color: maroon }
</style>
<script language="JavaScript" type="text/javascript" >
var query = '<bean:write name="searchResultForm" property="query" />';
top.query = query;
var oForm;

function synchronizeMenu()
{
  var now = new Date();
  top.time = ( now.getMinutes() * 60 )
             + ( now.getSeconds() )
             + ( now.getMilliseconds() * 0.001 );

  var oNavigationFrame = parent.frames[ 'navigationFrame' ];
  var oSelector        = oNavigationFrame.frames[ 'navigationSelector' ];
  oSelector.showPanel( 'treeFilterFrameset' );
  var oTreeFilter = top.window.frames["navigationFrame"]
                              .frames["navigationContent"]
                              .frames["treeFilterFrameset"]
                              .frames["treeFilter"];
  oTreeFilter.oTreeContainer.innerHTML = "A találati lista töltődik...";
  return true;
}

function init()
{
  hideContentHead();
  this.oForm = window.document.forms['searchResultForm'];
  oForm.elements['query'].focus();
  document.getElementById('resultListNavigationLinks').innerHTML = getResultListNavigationLinks();
}

function hideContentHead()
{
  // preventing recursion
  if( window.top != window )
  {
    window.top.redrawContentHead = true;
    window.top.hideContentHead();
  }
}

function onLinkClickEvent(url) {
	var oFrm = top.frames['contentHead'];
	if(oFrm.window.location.href == url) {
		oFrm.refreshContent();
	} else {
		oFrm.location.href = url;
	}
	top.redrawContentHead = true;
	top.showContentHead();
	top.redrawContentHead = false;
}

function flink( offset )
{
  oForm.elements['offset'].value = offset;
  oForm.submit();
}

function searchResultSubmit()
{
  if( query != oForm.elements['query'].value )
    oForm.elements['offset'].value = 0;
  // trim the spaces from the end
  oForm.elements['query'].value = oForm.elements['query'].value.replace( /\s+$/, '' );
  return true;
}

function getResultListNavigationLinks()
{
  var max = parseInt( <bean:write name="searchResultForm" property="foundResult" /> );
  if( max == 0 )
    return '';
  var offset = parseInt( <bean:write name="searchResultForm" property="offset" /> );
  var limit = parseInt( <bean:write name="searchResultForm" property="maxResult" /> );
  offset = parseInt( offset / limit ) * limit;
  var steps = new Array( limit, 10*limit, 100*limit, 1000*limit );
  var negative = new Array();
  var positive = new Array();
  for( var j = 0; j<steps.length; j++ )
  {
    for( var i=1; i<=3; i++ )
    {
      var curr = steps[j] * i;
      if( offset - curr > 1 )
        negative.unshift( offset - curr );
      if( offset + curr < max-1 )
        positive.push( offset + curr );
    }
  }

  var linkNumbers = new Array();

  // first
  linkNumbers.push( 0 );

  // first < xxx < current
  for( i=0; i<negative.length; i++ )
    linkNumbers.push( negative[i] );

  // current
  if( offset > 0 && offset < max )
  {
    linkNumbers.push( offset );
  }

  // current < yyy < last
  for( i=0; i<positive.length; i++ )
  {
    linkNumbers.push( positive[i] );
  }

  // last
  var lastNum = parseInt(max/limit) * limit;
  if( lastNum == max ) {
    lastNum = lastNum - limit;
  }
  if( offset < max && lastNum != linkNumbers[ linkNumbers.length-1 ] )
    linkNumbers.push( lastNum );

  var text = '';
  var link = 'searchResult.do?query=' + query + '&offset=';
  for( i = 0; i<linkNumbers.length; i++ )
  {
    if( text != '' )
    {
      text += ' &middot; ';
    }
    if( offset == linkNumbers[i] )
    {
      text += '<b>' + ( linkNumbers[i] + 1 ) 
      if( linkNumbers[i] < (max-1) )
        text += '-';
      text += '<\/b>';
    } else {
      text += '<a href="#" onclick="flink(' + linkNumbers[i] + ')">' + ( linkNumbers[i] + 1 );
      if( linkNumbers[i] < (max-1) )
        text += '-';
      text += '<\/a>';
    }
  }
  return text;
}

</script>
</head>

<body style="margin: 0;" onload="init();">

<div style="height: 25px;">
  <div class="header2" style="padding: 4px 0 3px 10px;">
 <bean:message key="searchres.title" />
  </div>
</div>


<table align="center" width="100%">
  <tr valign="middle">
    <td width="20%">
      <!-- Filter TOC for the search results  treeFilterFrameset.jsp method="get" -->
      <html:form action="/treeFilter.jsp" target="treeFilter"
       onsubmit="return synchronizeMenu();">
      <!-- html:form action="/treeFilter" target="navigationContent" -->
        <nested:hidden property="query" name="searchResultForm"/>
        <html:hidden property="offset"    value="0"/>
        <html:hidden property="parentStr" value="root"/>
        <html:hidden property="direction" value="1"/>
        <html:image src="icons/e_synch_toc.gif" 
          altKey="searchres.menuSych" 
          titleKey="searchres.menuSych" 
          property="menuSych" />
      </html:form>
    </td>

    <td align="left" width="40%">
      <!-- summary of search -->
      <logic:present name="searchResultForm" property="foundResult">
        <b>
          <bean:write name="searchResultForm" property="startIndex" />–<bean:write name="searchResultForm" 
       property="endIndex" />. / 
          <bean:write name="searchResultForm" property="foundResult" />
        </b>
        <bean:message key="searchres.docsin" />
        <bean:write  name="searchResultForm" property="speed" />
        <bean:message key="searchres.secs" />  
      </logic:present>
    </td>
   
    <td align="right" width="15%"></td>
    <td width="25%"></td>
  </tr>
</table>

<html:form styleId="searchResultForm" 
           action="/searchResult" 
           method="get"
           onsubmit="return searchResultSubmit();">

<table align="center" width="100%">
  <tr valign="middle">
    <td width="20%"></td>
    <!-- comment on the query string -->
    <td width="40%"><bean:message key="searchres.crite" /></td>
    <!-- comment on hits per page    -->
    <td width="15%"><bean:message key="searchres.respp" /></td>
    <td width="25%"></td>
  </tr>

  <tr>

    <!-- previous page icon -->
    <td>
      <html:hidden property="offset" />
      <logic:lessEqual name="searchResultForm" property="startIndex" value="1">
        <html:image src="icons/e_back_disabled.gif" 
                    disabled="true"
                    altKey="searchres.prevPage"
                    titleKey="searchres.prevPage" 
                    property="prevRes" />
      </logic:lessEqual>
      
      <logic:greaterThan name="searchResultForm" property="startIndex" value="1">
        <html:image src="icons/e_back.gif" 
                    altKey="searchres.prevPage" 
                    titleKey="searchres.prevPage" 
                    property="prevRes" />
      </logic:greaterThan>
    </td>

    <!-- the query string -->
    <td><html:text property="query" size="44" styleClass="header2" /></td>
    
    <!-- hits per page -->
    <td><html:text property="maxResult" size="4" styleClass="header2" onchange="top.maxResult = this.value;"/></td>
    
    <!-- search buttom -->
    <td><html:image src="icons/e_search.gif" 
                    altKey="searchres.startSearch"
                    titleKey="searchres.startSearch"
                    property="search" /></td>
    
    <!-- next page icon -->
    <td>
      <logic:equal name="searchResultForm" property="atLast" value="true">
        <html:image src="icons/e_forward_disabled.gif" 
                    disabled="true" 
                    altKey="searchres.nextPage" 
                    titleKey="searchres.nextPage" 
                    property="nextRes" 
                    style="width: 16px; height: 16px;" />
      </logic:equal>
      
      <logic:equal name="searchResultForm" property="atLast" value="false">
        <html:image src="icons/e_forward.gif" 
                    altKey="searchres.nextPage" 
                    titleKey="searchres.nextPage" 
                    property="nextRes" 
                    style="width: 16px; height: 16px;" />
      </logic:equal>
    </td>
  </tr>
</table>


<logic:present property="foundResult" name="searchResultForm">
<div id="resultListNavigationLinks" style="text-align:center; font-size: 70%; color: black;">
</div>
</logic:present>

<table>
  <logic:present property="queryResult" name="searchResultForm">
    <logic:iterate id="resLine" property="queryResult" name="searchResultForm">
      <bean:define id="destPage" name="resLine" property="page" />
      <tr valign="top">
        <!-- hit Nr -->
        <td>
          <bean:write name="resLine" property="hitNo" />
        </td>

        <td>
          <!-- result's URL -->
          <a charset="utf-8" href="showDocumentMeta.do?name=<bean:write name="destPage" property="name"/>&amp;query=<bean:write name="searchResultForm" property="query"/>&amp;totalResult=<bean:write name="searchResultForm" property="foundResult"/>&amp;maxResult=<bean:write name="searchResultForm" property="maxResult" />#hit1" target="contentHead" onclick="onLinkClickEvent(this.href);">
          <!-- result's titlepath -->
          <bean:write name="destPage" property="pathFromDocRoot" />
          <!-- result's title -->
          <bean:write name="destPage" property="title" /> </a>
        </td>
      </tr>
      
      <!-- result's contextList -->
      <tr valign="top">
        <td></td>
        <td><bean:write name="resLine" property="contextList" filter="false" /></td>
      </tr>
      
      
    </logic:iterate>
  </logic:present>
</table>

<table width="100%">
  <tr>

    <!-- previous page icon -->
    <td width="50%">
      <logic:lessEqual name="searchResultForm" property="startIndex" value="1">
        <html:image src="icons/e_back_disabled.gif" 
                    disabled="true" 
                    altKey="searchres.prevPage"
                    titleKey="searchres.prevPage" 
                    property="prevRes" />
      </logic:lessEqual>
      
      <logic:greaterThan name="searchResultForm" property="startIndex" value="1">
        <html:image src="icons/e_back.gif" 
                    altKey="searchres.prevPage"
                    titleKey="searchres.prevPage" 
                    property="prevRes" />
      </logic:greaterThan>
    </td>

    <!-- next page icon -->
    <td align="right">
      <logic:equal name="searchResultForm" property="atLast" value="true">
        <html:image src="icons/e_forward_disabled.gif" disabled="true" altKey="searchres.nextPage" titleKey="searchres.nextPage" property="nextRes" />
      </logic:equal>
      
      <logic:equal name="searchResultForm" property="atLast" value="false">
        <html:image src="icons/e_forward.gif" altKey="searchres.nextPage" titleKey="searchres.nextPage" property="nextRes" />
      </logic:equal>
    </td>
  </tr>
</table>
</html:form>
</body>
</html>

