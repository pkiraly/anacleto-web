<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"  prefix="bean"  %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"  prefix="html"  %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html>
<head>
  <title>content navigation bar</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">

  <link rel="stylesheet" type="text/css" href="../css/mainstyle.css">
  <script language="JavaScript" src="../js/common.js" type="text/javascript"><!--* not empty *--></script>
  <script language="JavaScript" src="../js/document.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
var loaded           = false;
var oNavigationFrame = top.frames['navigationFrame'];
var oSelector        = oNavigationFrame.frames['navigationSelector'];
var content          = window.parent.frames['content'];
var showResultIcons  = false;
var showPrev         = false;
var showNext         = false;
var contentName      = null;

var no_more_matches = "A dokumentumban nincs több találat.";
var currentHit = -1;
var hitPrefix  = 'hit';
var anchors    = new Array();
var oDocument  = window.parent.frames["content"];
var oPImg, oNImg;
var noalert = true;

if( parent.location != document.location )
{
  oNavigationFrame = parent.frames['navigationFrame'];
  oSelector        = oNavigationFrame.frames['navigationSelector'];
}

function getQuery() { return ( content.query  ) ? deHTML( content.query, 'query' ) : ''; }
function getName() {
	contentName = getParam('name', content.window.location.href);
	/*
	contentName = ( content.name )
				? deHTML( content.name, 'name' )
				: getParam('name', content.window.location.href);
	*/
	return contentName;
}
function getHitNo() { return ( content.hitNo && content.hitNo > -1 ) ? content.hitNo : ''; }
function getLinkedPath()  { return ( content.linkedPath   ) ? deHTML( content.linkedPath, 'linkedPath' )   : ''; }
function getAtLast(){ return ( content.atLast ) ? content.atLast : false; }
function getTotalResult(){ return ( content.totalResult ) ? content.totalResult : 0; }

function getParam(paramName, sURL) {
	sURL = unescape(sURL);

	var pattern = new RegExp( "[?&]" + paramName + '=([^&]+)' );
	var matches = sURL.match( pattern );
	var currentHit = '';
	if( matches ) {
		currentHit = matches[1];
	}
	return currentHit;
}

function deHTML( text, key )
{
  var from = /&quot;/g;
  var to   = '"';
  var result = text.replace( from, to );
  text = result;
  text = text.replace( /<a[^<>]+>/g, '' );
  text = text.replace( /<\/a>/g, '' );
  return text;
}

function varCheck()
{
    alert( '[oDocument]' + top.LN
      + 'hitNo: '  + oDocument.hitNo  + top.LN
      + 'name: '   + oDocument.name   + top.LN
      + 'path: '   + oDocument.path   + top.LN
      + 'query: '  + oDocument.query  + top.LN
      + 'atLast: ' + oDocument.atLast + top.LN
      + top.LN
      + '[content]' + top.LN
      + 'hitNo: '  + content.hitNo  + top.LN
      + 'name: '   + content.name   + top.LN
      + 'path: '   + content.path   + top.LN
      + 'query: '  + content.query  + top.LN
      + 'atLast: ' + content.atLast + top.LN
    );
}

function sync()
{
  var oForm = document.forms['syncForm'];
  oForm.elements['parentStr'].value = getName();
  synchronizeMenu( getName() );
  if( window.opera )
  {
    var oTargetFrame = window.top.frames['navigationFrame'].frames['navigationContent'].frames['treeFrameset'].frames['tree'];
    var url = oForm.action + '?parentStr=' + getName();
    oTargetFrame.location.href = url;
    return false;
  // } else {
  //   oForm.submit();
  }
  return true;
}

function print()
{
  printCurrentDocument();
  return( false );
}

function bookmark()
{
  var oForm = document.forms['bookmarkForm'];
  oForm.elements['name'].value = getName();
  oForm.elements['path'].value = getLinkedPath();
  addBookmark();
  oSelector.showPanel('bookmarkFrameset');
  return( false );
}

function show()
{
  top.redrawContentHead = false;
  var oForm = document.forms['showForm'];
  oForm.elements['name'].value = getName();
  oForm.elements['hitNo'].value = getHitNo();
  oForm.elements['query'].value = getQuery();
  oForm.elements['totalResult'].value = getTotalResult();
  oForm.submit();
  return( false );
}

function hits()
{
  top.redrawContentHead = false;
  var oForm = document.forms['hitsForm'];
  oForm.elements['name'].value = getName();
  oForm.elements['hitNo'].value = getHitNo();
  oForm.elements['query'].value = getQuery();
  oForm.elements['totalResult'].value = getTotalResult();
  return( false );
}

function result( formName )
{
  var oForm = document.forms[ formName ];
  oForm.elements['query'].value = getQuery();
  oForm.elements['offset'].value = getHitNo();
  // hideContentHead(); //this is onload method in the searchResult.jsp
}

function resultCounter()
{
  var oSpan = document.getElementById( "resultCounter" );
  oSpan.innerHTML = ( getHitNo() + 1 ) + "/" + getTotalResult();
  return false;
}

function hideContentHead()
{
  top.redrawContentHead = true;
  top.hideContentHead();
}
</script>

<style type="text/css">
 form, input, span.admin { display: inline; }

</style>

</head>
<body onload="loaded = true">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="left" valign="middle">

    <td class="admin" valign="middle">
      <!-- Menu synchronization  treeFrameset.jsp -->
      <form action="../treeView.do" name="syncForm"
            target="tree"
            class="admin_inline"
            onsubmit="return sync();">
        <input type="hidden" name="parentStr" value="">
        <span class="admin">
        <html:image src="../icons/e_synch_toc.gif" style="border: 0;"
                    titleKey="showdoc.menusync" altKey="showdoc.menusync"
                    property="menuSync" align="baseline" />
        </span>
      </form>

      <!-- print -->
      <span class="admin">
      <html:image src="../icons/e_print_edit.gif"
                  property="print"  align="baseline" style="border: 0;"
                  titleKey="showdoc.print" altKey="showdoc.print"
                  onclick="print();" styleClass="admin_inline"/>
      </span>

      <!-- bookmark -->
      <form action="../bookmarkFrameset.jsp"
            method="get"
            name="bookmarkForm"
            target="bookmarkFrameset"
            onsubmit="bookmark()"
            class="admin_inline">
        <span class="admin">
          <input type="hidden" name="name" value="">
          <input type="hidden" name="path" value="">
          <html:image src="../icons/e_bookmark_add.gif"
                      property="addBkmr"
                      titleKey="showdoc.addBookMark" style="border: 0;"
                      altKey="showdoc.addBookMark"  styleClass="admin_inline" />
        </span>
      </form>

      <!--* prev doc / next doc *-->
      <form action="../showDocument.do"
            name="showForm"
            target="content"
            method="get"
            onsubmit="show();"
            class="admin_inline">
          <input type="hidden" name="name"  value=""/>
          <input type="hidden" name="query" value=""/>
          <input type="hidden" name="hitNo" value=""/>
          <input type="hidden" name="totalResult" value=""/>

        <span class="admin">
          <html:image src="../icons/prev_toc.gif"
                      property="prevPage"
                      titleKey="application.prevpage" style="border: 0;"
                      altKey="application.prevpage"   styleClass="admin_inline" />
          <bean:message key="showdoc.booknav" />
          <html:image src="../icons/next_toc.gif"
                      property="nextPage"
                      titleKey="application.nextpage" style="border: 0;"
                      altKey="application.nextpage"   styleClass="admin_inline" />
        </span>
      </form>

      <!--* navigation bar for query *-->
      <div class="admin" id="queryNavigation" style="visibility: hidden;">

        <!--* prev result / next result *-->
        <form action="../showDocument.do"
              name="hitsForm"
              target="content"
              method="get"
              onsubmit="hits()"
              class="admin_inline">
          <input type="hidden" name="name"  value="" />
          <input type="hidden" name="query" value="" />
          <input type="hidden" name="hitNo" value="" />
          <input type="hidden" name="totalResult" value="" />
          <span class="admin">
            <html:image src="../icons/prev_search_d.gif"
                      disabled="true"
                      property="prevRes"
                      titleKey="application.prevres"
                      altKey="application.prevres"
                      style="border: 0;" />
            <bean:message key="showdoc.resnav" />
            <html:image src="../icons/next_search_d.gif"
                      disabled="true"
                      property="nextRes"
                      titleKey="application.nextres"
                      altKey="application.nextres"
                      style="border: 0;" />
          </span>
        </form>

        <!--* prev hit / next hit *-->
        <span class="admin">
          <a href="#hit1" onclick="PrevMatch( this );"
            ><img id="prev_nav" src="../icons/prev_nav.gif"
                 title="<bean:message key="application.prevhit" />"
                 alt="<bean:message key="application.prevhit" />"
                 style="border: 0;"
          ></a>
          <bean:message key="showdoc.docnav" />
          <a href="#hit2" onclick="NextMatch( this );"
            ><img id="next_nav" src="../icons/next_nav.gif"
                 title="<bean:message key="application.nexthit" />"
                 alt="<bean:message key="application.nexthit" />"
                 style="border: 0;"
          ></a>
        </span>

        <!--* hitlist (search result list) *-->
        <html:form action="/searchResult.do"
                   method="get"
                   target="content"
                   styleClass="admin_inline"
                   onsubmit="result(this.name)">
          <span class="admin">
            <input type="hidden" name="query" value="" />
            <input type="hidden" name="offset" value="" />
            <input type="hidden" name="oldSearch" value="1" />
            <bean:message key="showdoc.backres" />
            <html:image src="../icons/e_search.gif"
                   property="search"
                   titleKey="showdoc.backres"
                   altKey="showdoc.backres"
                   style="border: 0;" />
          </span>

          <span class="admin" id="resultCounter">
          </span>
        </html:form>
      </div>

      <script language="JavaScript" type="text/javascript">
        var query = getQuery();
        if( query != "" )
        {
          var queryNavigationDiv = document.getElementById( 'queryNavigation' );
          queryNavigationDiv.style.visibility = "visible";
          // this signs to the content frame, that this need
          // to be reloaded or not
          showResultIcons = true;
        }
      </script>
    </td>
  </tr>
</table>

</body>
</html:html>
