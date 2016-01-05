<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>TreeFilter</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <script type="text/javascript" language="JavaScript" src="js/x_core.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/treeFilter.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/commonTreeHandler.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/getDom.js"></script>
<style type="text/css">
em { color: maroon; font-style: normal; }
em.noem { color: green; }

div {
  border: solid transparent 0.1px;
  border-collapse: collapse;
  /*visibility: collapse;*/
}

div.kwic { 
  /* display: block; */
  width: 250px;
  /* border: solid black 1px; */
  /* overflow: auto; */
  white-space: normal;
}

div.kwic b {
	color: maroon; 
}

div.kwic br {
  display: none;
}

div.temp { 
  /* border: solid 1px default; */
  padding: 0;
  margin: 0;
  clear: both;
  display: none;
}

a tt {
  text-decoration: underline;
}

a.tocx, a.tocx tt {
  text-decoration: none;
}
</style>

<script type="text/JavaScript" language="JavaScript">
var frameName = 'treeFilter';
var allowDebugConsole = true;
var titleFormatable = true;
var forwardMsg  = '<bean:message key="tree.forward" />';
var loadingMsg  = '<bean:message key="tree.loading" />';
var noResultMsg = '<bean:message key="tree.noResult" />';
/* OFFSET set the max number of subelement of a parent element in the tree 
 * the rest of the subelement can be retrieved by prev/next ikons */
var OFFSET = parseInt('<bean:write name="treeFilterForm" property="maxTocEntryNumber" filter="false" />');
var TREE_ITEMS = [ <bean:write name="treeFilterForm" property="menuDesc" filter="false" /> ];
var oTreeStr   =  "<bean:write name="treeFilterForm" property="menuDesc" filter="false" />";
var oTreeContainer = null;

</script>
</head>

<body onload="init( TREE_ITEMS ); tocX(0);">

<div style="display:none">
<form name="controlls">
<input type="checkbox" name="expand3level" value="0" />
<label for="expand3level"> kibontás 3 szint mélyen</label> 

<input type="checkbox" name="deep_expand" value="0" />
<label for="deep_expand"> teljes kibontás</label> 
</form>
</div>

<table cellpadding="5" cellspacing="0" border="0" width="1000">
  <tr>
    <td>
<div id="tree_container"></div>
    </td>
  </tr>
</table>

<!-- p>
<a href="javascript:void(0)" onClick="getDOM()">getDOM()</a> 
- <a href="javascript:void(0)" onClick="debug( 'writeLinearTree', writeLinearTree() )">writeLinearTree()</a>
- <a href="javascript:void(0)" onClick="debug( 'getLastQA', getLastQA() )">getLastQA()</a>
</p -->

<div id="debug" style="left: 10; z-index: 2; font-size: 8pt;"></div>

<iframe name="dynLoadFrame"
  title="dynLoadFrame"
  frameborder="0" width="0" height="0" scrolling="no" >
</iframe>

<form id="updateForm" 
      action="treeFilterFragment.do" 
      method="post" 
      target="dynLoadFrame">
  <input type="hidden" name="offset"    value="" />
  <input type="hidden" name="direction" value="" />
  <input type="hidden" name="parentStr" value="" />
  <input type="hidden" name="query"     value="" />
  <input type="hidden" name="title"     value="" />
  <input type="hidden" name="isSyncronized" value="" />
</form>

</body>
</html>