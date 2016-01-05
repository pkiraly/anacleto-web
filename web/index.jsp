<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title><bean:message key="index.title" /></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <script type="text/javascript" language="JavaScript" src="js/index.js"></script>
<script type="text/javascript" language="JavaScript">
<!--
var LN = "\n";
/* the searchResult.jsp sets the query */
var query = '';
/* the treeFrameset.jsp sets the query */
var name = '';

var lastDocumentName = '';
var treeWidthDomainSelector = 0;
var redrawContentHead = true;
var isContentHeadVisible = false;
/** the number of hits in a search result page */
var maxResult = 10;
//-->
</script>

</head>
<frameset rows="85,*,20" border="0">
  <frameset cols="280,*" border="0">
    <frame name="header" src="headerLogo.jsp" marginwidth="20" marginheight="0" scrolling="no" frameborder="0" noresize>
    <frameset rows="20,0,*" border="0">
      <frame name="headerFunctions" id="headerFunctions" src="headerFunctions.jsp"  marginwidth="20" marginheight="0" scrolling="no" frameborder="0" noresize>
      <frame name="contentHead"     id="contentHead"     src="form/contentHead.jsp" frameborder="0" marginwidth="0" marginheight="0" scrolling="no">
      <frame name="referenceBar"    id="referenceBar"    src="referenceBar.html"    frameborder="0" marginwidth="0" marginheight="0" scrolling="auto">
    </frameset>
  </frameset>
  <frameset cols="280,*" border="0">
    <frame src="nav.jsp" name="navigationFrame" id="navigationFrame" scrolling="No" frameborder="0" marginwidth="0" marginheight="0">
    <frame name="content" id="content" src="welcome.jsp" frameborder="0" marginwidth="0" marginheight="0" scrolling="Auto">
  </frameset>
  <frame name="footer" src="footer.jsp" marginwidth="20" marginheight="0" scrolling="no" frameborder="0" noresize>

</frameset>
</html>
