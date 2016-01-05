<%@ page pageEncoding="UTF-8" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"   prefix="bean"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <script type="text/javascript" language="JavaScript" src="js/x_core.js"></script>
  <script type="text/javascript" language="JavaScript" src="js/x_core_n4.js"></script>
<style type="text/css">
td {
  font-size:5px;
  margin:0px;
  padding:0px;
  cursor:default;
  text-align: center;
  border:1px solid black;
}

.tab {
  background-color: white;
}

.pressed {
  background-color: default;
  border-top:1px solid #e5e5e5;
  /*border-color-top: ;*/
}
</style>

<script type="text/javascript" language="JavaScript">
var selectedID = '';
var color = '#2d598a';
var sColor = 'white';
var bgColor = '';
var sBgColor = 'black';
var LN = "\n";

function showPanel ( panelName ) {
  var url;
  
  if( this.selectedID == panelName )
    return;
  
  var iframes = parent.navigationContent.document.body.getElementsByTagName("IFRAME");
  for (var i=0; i<iframes.length; i++) {     
    if ( iframes[i].id != panelName ){
      iframes[i].className = "hidden";
      iframes[i].style.visibility="hidden";
    } else {
      iframes[i].className = "visible";
      iframes[i].style.visibility="visible";
    }
  }
  
  selectSwitch( panelName );
}

function selectSwitch( sID ) {
  if( this.selectedID != sID) {
    deSelectSwitch();
    var td = xGetElementById( sID );
    td.className = 'pressed';
    this.selectedID = sID;
  }
}

function deSelectSwitch() {
  if( this.selectedID !== '' ) {
    var td = xGetElementById( this.selectedID );
    td.className = 'tab';
  }
  this.selectedID = '';
}
</script>
</head>
<body>

<table width="100%">
 <tr>
   <td width="33%" id="treeFrameset"     class="tab" onClick="showPanel('treeFrameset');return false;"><a href="#" onClick="return false;"><img 
                alt="<bean:message key="navigationSelector.contents" />" 
                title="<bean:message key="navigationSelector.contents" />" 
                src="icons/e_contents_view.gif"
                id="imgtoc"
                height="16"
                border="0"
           ></a></td>
   <td width="33%" id="bookmarkFrameset"  class="tab" onClick="showPanel('bookmarkFrameset');return false;"><a href="#" onClick="return false;"><img 
                alt="<bean:message key="navigationSelector.bookmark" />" 
                title="<bean:message key="navigationSelector.bookmark" />" 
                src="icons/e_bookmarks_view.gif"
                id="imgbookmarks"
                height="16"
                border="0"
           ></a></td>
   <td width="33%" id="treeFilterFrameset" class="tab" onClick="showPanel('treeFilterFrameset');return false;"><a href="#" onClick="return false;"><img 
                alt="<bean:message key="navigationSelector.filteredTree" />" 
                title="<bean:message key="navigationSelector.filteredTree" />" 
                src="icons/e_search.gif"
                id="imgsearch"
                height="16"
                border="0"
           ></a></td>
 </tr>
</table>

<script type="text/javascript" language="JavaScript">
selectSwitch( 'treeFrameset' );
</script>

</body>
</html>
