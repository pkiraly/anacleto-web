<%@ page language="java" contentType="text/html; charset=UTF-8" 
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"  prefix="bean"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-html"  prefix="html"
%><%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><bean:write name="showDocumentForm" property="linkedPath" filter="false" /></title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="cache-control" content="no-cache">

  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <link rel="stylesheet" type="text/css" href="cssLink.do?name=main.css">
  <link rel="stylesheet" type="text/css" href="cssLink.do?name=arcanum.css">
<logic:present name="showDocumentForm" property="bookContentStyleSheet">
  <link rel="stylesheet" type="text/css" href="cssLink.do?name=<bean:write name="showDocumentForm" property="bookContentStyleSheet" filter="false" />">
</logic:present>

  <script language="JavaScript" src="js/common.js" type="text/javascript"><!--* not empty *--></script>
  <script language="JavaScript" src="js/links2popup.js" type="text/javascript"><!--* not empty *--></script>
<script language="JavaScript" type="text/javascript">
<!--
var linkedPath = document.title;
var oReferenceBar = window.top.frames['referenceBar'];
/*
if( oReferenceBar )
  oReferenceBar.document.getElementById('referenceBar').innerHTML = linkedPath;
*/

var oContentHead = parent.frames['contentHead'];
var oHeader = window.top.frames['header'];
var tries = 0;
var docName = '<bean:write name="showDocumentForm" property="name" />';
<%--var path = '<bean:write name="showDocumentForm" property="path" />';--%>
var query= '<bean:write name="showDocumentForm" property="query" />';
var totalResult = parseInt( <bean:write name="showDocumentForm" property="totalResult" /> );
var atLast= <bean:write name="showDocumentForm" property="atLast" />;
var hitNo = -1;
hitNo = parseInt( <bean:write name="showDocumentForm" property="hitNo" /> );

top.redrawContentHead = true;
top.showContentHead();

// var top = parent.parent;

function init()
{
  doLink();

  /*
  if( query != '' && hitNo >= 0 )
  {
    oContentHead.document.getElementById('queryNavigation').style.visibility = "visible";
    if( oContentHead.contentName != name )
    {
      // initHead( name );
    }
  } else {
    oContentHead.document.getElementById('queryNavigation').style.visibility = "hidden";
  }
  */
}

function initHead( name )
{
  if( oContentHead.loaded )
  {
    tries = 0;
    oContentHead.init( name );
  } else if( tries < 5 ) {
    tries++;
    setTimeout( "initHead( " + name + " )", 1000 );
  } else {
    tries = 0;
    alert("Sorry, we could not complete this task.");
  }
}

function exit()
{
  /*
  if( ! window.opera )
  {
    window.top.hideContentHead();
    if( oReferenceBar )
      oReferenceBar.document.getElementById('referenceBar').innerHTML = '';
  }
  */
}

//-->
</script>

<style type="text/css">
form { display: inline; }

div.admin_titlepath a,
div.admin_titlepath a:link,
div.admin_titlepath a:visited,
div.admin_titlepath a:active
{
  font-size: 100%;
  font-family: "Trebuchet MS",Verdana,Geneva,Tahoma,Arial,Helvetica,sans-serif;
  color: rgb(45, 89, 138);
}


#noteContainer {
  position: absolute;
  visibility: hidden;
  background-color: menu;
  font-family: arial, sans-serif;
  font-size: 10pt;
  width: 400;
  z-index: 100;
  padding: 5pt;
  border: 1px solid green;
}
</style>

</head>
<body onload="init();" onunload="exit();">

<script language="JavaScript" type="text/javascript">
<!--
/*
  'oContentHead.showResultIcons == false' means that there are no result icons
  'hitNo == 0'                            means that the prev hit need disabled
  'hitNo != 0'                            means that the prev hit need enabled
  'atLast == true'                        means that the next hit need disabled
  'atLast == false'                       means that the next hit need enabled
*/
/*
if( this.query != "" )
	&&
    ( this.oContentHead.showResultIcons == false ||
      ( this.hitNo == 0 && this.oContentHead.showPrev == true ) ||
      ( this.hitNo != 0 && this.oContentHead.showPrev == false ) ||
      ( this.atLast == true && this.oContentHead.showNext == true ) ||
      ( this.atLast == false && this.oContentHead.showNext == false ) ) )
{
  oContentHead.resultCounter();
  oContentHead.setImages();
}

if( query == "" && oContentHead.showResultIcons == true )
{
  oContentHead.location.reload();
}
*/
//-->
</script>

<div id="referenceBar" class="admin_titlepath"></div>

<div style="margin: 20px">
<bean:write name="showDocumentForm" property="pageBody" filter="false" locale="UTF-8" />
</div>

<script language="JavaScript" type="text/javascript">
<!--
if( oReferenceBar ) {
  document.getElementById('referenceBar').style.visibility = "hidden";
} else {
  document.getElementById('referenceBar').innerHTML = linkedPath;
}
//-->
</script>
<!-- this is the container of the actual note -->
<div id="noteContainer"></div>
</body>
</html>
