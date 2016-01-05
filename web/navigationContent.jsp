<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html locale="true">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>navigationContent.jsp</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
<style type="text/css">
/* need this one for Mozilla */
HTML { 
  width:100%;
  height:100%;
  margin:0px;
  padding:0px;
  border:0px;
}

BODY {
  margin:0px;
  padding:0px;
  /* Mozilla does not like width:100%, so we set height only */
  height:100%;
}

IFRAME {
  width:100%;
  height:100%;
}

.hidden {
  visibility:hidden;
  width:0;
  height:0;
}

.visible {
  visibility:visible;
  width:100%;
  height:100%;
}
</style>
</head>
  
<body>

  <iframe frameborder="0" 
        class="visible"  
        name="treeFrameset"
        title="treeFrameset"
        id="treeFrameset" 
        src='treeFrameset.jsp'>
  </iframe> 

  <iframe frameborder="0" 
        class="hidden"  
        name="bookmarkFrameset"
        title="bookmarkFrameset"
        id="bookmarkFrameset" 
        src='bookmarkFrameset.jsp'>
  </iframe> 

  <iframe frameborder="0" 
        class="hidden"  
        name="treeFilterFrameset"
        title="treeFilterFrameset"
        id="treeFilterFrameset" 
        src='treeFilterFrameset.jsp'>
  </iframe> 

</body>
</html:html>
