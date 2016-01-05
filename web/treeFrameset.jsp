<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>tree frameset</title>
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
</head>
<% 
String name    = request.getParameter("name");
String query   = request.getParameter("query");
String params = "";
if( name != null ){ 
  params +=  "name=" + name;
}
if( query != null ){ 
  if( params != "" ) params += "&";
  params +=  "query=" + query;
}
params = ( params != "" ) ? "?" + params : "";
%> 

<frameset rows="25,*" framespacing="0" border="0" frameborder="no">
  <frame src="treeHead.jsp" name="treeHead" noresize id="treeHead" scrolling="no"   frameborder="0" marginwidth="0" marginheight="0">
  <frame src="treeView.do<%= params %>"  name="tree"     noresize id="tree"     scrolling="auto" frameborder="0" marginwidth="0" marginheight="0">
</frameset>

<body bgcolor="#e5e5e5">

</body>
</html>
