<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>bookmark  frameset</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<%
String action = request.getParameter("action");
String url    = request.getParameter("name");
String name   = request.getParameter("path");
action = "";
if( url != null ){
  if( name != null ){
    action = "addBookmark";
  }
}
%>
<script type="text/javascript" language="JavaScript">
var action = '<%= action %>';
</script>
</head>

<frameset rows="25,*" framespacing="0" border="0" frameborder="no">
  <frame src="bookmarksHead.jsp"    name="bookmarksHead"    id="bookmarksHead"    marginwidth="0" marginheight="0" scrolling="no"   noresize frameborder="0" >
  <frame src="bookmarksContent.jsp" name="bookmarksContent" id="bookmarksContent" marginwidth="0" marginheight="0" scrolling="auto" noresize frameborder="0" >
</frameset>

<body bgcolor="#e5e5e5">

</body>
</html>

