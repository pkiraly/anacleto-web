<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>tree</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <script type="text/javascript" language="JavaScript" src="js/x_core.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/tree.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/treeCheckbox.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/commonTreeHandler.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/getDom.js"></script>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <link rel="stylesheet" type="text/css" href="css/tree.css">

<script type="text/javascript" language="JavaScript">
var frameName = 'tree';
var allowDebugConsole = true;
var titleFormatable = false;
var checkBoxVisibility;
var wt;
var forwardMsg  = '<bean:message key="tree.forward" />';
var loadingMsg = '<bean:message key="tree.loading" />';
/* OFFSET set the max number of subelement of a parent element in the tree 
 * the rest of the subelement can be retrieved by prev/next ikons */
var OFFSET = parseInt('<bean:write name="treeViewForm" property="maxTocEntryNumber" filter="false" />');
var syncElementName = '<bean:write name="treeViewForm" property="name" filter="false" />';
var TREE_ITEMS = [ <bean:write name="treeViewForm" property="treeDesc" filter="false" /> ];
var oTreeStr   =  "<bean:write name="treeViewForm" property="treeDesc" filter="false" />";
var oTreeContainer = null;
</script>
</head>

<body style="margin: 0px;" onload="init(TREE_ITEMS); syncElement(syncElementName);">

<div style="display: none">
<form name="controlls">
<input type="checkbox" name="expand3level" value="0" />
<label for="expand3level"> kibontás 3 szint mélyen</label> 

<input type="checkbox" name="deep_expand" value="0" />
<label for="deep_expand"> teljes kibontás</label> 
</form>
</div>

<form name="nodes" action="index.jsp">
<table cellpadding="5" cellspacing="0" border="0" width="100%">
  <tr>
    <td nowrap="nowrap">
<div id="tree_container"></div>
    </td>
  </tr>
</table>
</form>

<!-- p>
<a href="javascript:void(0)" onClick="getDOM()">getDOM()</a> 
<a href="javascript:void(0)" onClick="debug( 'writeLinearTree', writeLinearTree() )">writeLinearTree()</a>
<a href="javascript:void(0)" onClick="debug( 'getLastQA', getLastQA() )">getLastQA()</a>
<a href="javascript:void(0)" onClick="debug( 'wt', wt )">wt()</a>
</p -->

<div id="debug" style="font-size: 8pt;"></div>

<iframe name="dynLoadFrame" title="dynLoadTitle" frameborder="0" width="0" height="0" scrolling="no" >
</iframe>

<form id="updateForm" action="treeFragment.do" method="post" target="dynLoadFrame">
 <input type="hidden" name="offset"    value="" />
 <input type="hidden" name="direction" value="" />
 <input type="hidden" name="parentStr" value="" />
 <input type="hidden" name="query"     value="" />
 <input type="hidden" name="title"     value="" />
 <input type="hidden" name="isSyncronized" value="" />
</form>


</body>
</html>

