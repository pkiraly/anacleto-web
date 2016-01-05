<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"   prefix="bean"  %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>bookmark project</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type='text/css'>
body {
  /* font-family: sans-serif;
  font-size: 10pt;
  margin: 0;
  padding: 0; */
}
</style>
<script language="JavaScript" type="text/javascript" >
<!--
function addBookmark( name, url ) { parent.bookmarksContent.addBookmark( name, url ); }
function deleteBookmark()         { parent.bookmarksContent.deleteBookmark();         }
function refreshList()            { parent.bookmarksContent.refreshList();            }
function promptRenameBookmark()   { parent.bookmarksContent.promptRenameBookmark();   }
function syncronizeBookmark()     { parent.bookmarksContent.syncronizeBookmark();     }
// -->
</script>
</head>
<body>
<table cellspacing="0" cellpadding="5" border="0" width="100%">
  <tr valign="top">
    <td class="header2" valign="top"><bean:message key="bookmark.bookmarks" />:</td>
    <td class="header2" align="right" valign="top">
      <a href="#" onclick="deleteBookmark();refreshList();return false;"
        ><img src="icons/e_bookmark_rem.gif" 
              alt="<bean:message key="bookmark.sync" />" 
              title="<bean:message key="bookmark.sync" />" 
              id="e_bookmark_rem" border="0" align="baseline" /></a>
      <a href="#" onclick="promptRenameBookmark();refreshList();return false;"
        ><img src="icons/e_bookmarks_view.gif" 
              alt="<bean:message key="bookmark.sync" />" 
              title="<bean:message key="bookmark.sync" />" 
              id="e_bookmarks_view" border="0" align="baseline" /></a>
      <a href="#" onclick="syncronizeBookmark();refreshList();return false;"
        ><img src="icons/e_synch_nav.gif" 
              alt="<bean:message key="bookmark.sync" />" 
              title="<bean:message key="bookmark.sync" />" 
              id="e_synch_nav" border="0" align="baseline" /></a>
    </td>
  </tr>
</table>
      
</body>
</html>