<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Bookmark Project :: contents</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type='text/css'>
.listElement {
  font-family: verdana, sans-serif;
  color: black;
  font-size: x-small;
}

#selectionFormLayer {
  width: 250px; height:15px;
  margin: 0; padding: 0;
  visibility: hidden;
  position: absolute;
}

#selection {
  margin: 0; padding: 0;
}

#textInput, #submitButton {
  border:1px solid #330;
  margin: 0; padding: 0;
  font-size: 8pt;
  height: 15px;
}
</style>
<script type="text/javascript" language="JavaScript" src="js/x_core.js"></script>
<script type="text/javascript" language="JavaScript" src="js/x_core_n4.js"></script>
<script type="text/javascript" language="JavaScript" src="js/x_cook.js"></script>
<script type="text/javascript" language="JavaScript" src="js/bookmark.util.js"></script>
</head>

<body>
<div id="selectionList"></div>

<div id="selectionFormLayer">
  <form id="selection" name="selection" style="display:inline" onSubmit="renameBookmark();clearTextInput();return false;">
    <input type="hidden" id="selectedID" />
    <input type="text" id="textInput" name="textInput" onSubmit="renameBookmark();clearTextInput();return false;"/>
    <input type="button" id="submitButton" name="submitButton" value="ok" onclick="renameBookmark();clearTextInput();return false;" /> 
  </form>
</div>

<script language="JavaScript" type="text/javascript" >
<!--
   if( parent.action != '' && parent.action == 'addBookmark' )
   {
     var oFrom = top.frames['contentHead'].document.forms['bookmarkForm'];
     var url = 'showDocument.do?name=' + oFrom.elements['name'].value;
     var name = oFrom.elements['path'].value;
     name = name.replace( /&gt;/g, '>' );
     addBookmark( name, url );
   }
   refreshList();
// -->
</script>

</body>
</html>