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

  <link rel="stylesheet" type="text/css" href="css/mainstyle.css">
  <script language="JavaScript" src="js/common.js" type="text/javascript"><!--* not empty *--></script>
  <script language="JavaScript" src="js/showDocumentMeta.js" type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
var name        = '<bean:write name="showDocumentMetaForm" property="name" />';
var linkedPath  = '';
var query       = '<bean:write name="showDocumentMetaForm" property="query" />';
var contentType = '<bean:write name="showDocumentMetaForm" property="contentType" />';
var totalResult = parseInt( <bean:write name="showDocumentMetaForm" property="totalResult" /> );
var atLast      = <bean:write name="showDocumentMetaForm" property="atLast" />;
var isPrevNextDocNavigation = <bean:write name="showDocumentMetaForm" property="isPrevNextDocNavigation" />;
var hitNo       = -1;
hitNo           = parseInt( <bean:write name="showDocumentMetaForm" property="hitNo" /> );
var maxResult   = 10;
maxResult       = parseInt( <bean:write name="showDocumentMetaForm" property="maxResult" /> );

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
var oPrevDocImg, oNextDocImg;
var noalert = true;
var refreshContentCounter = 0;
var isRefreshed = false;

if( parent.location != document.location )
{
  oNavigationFrame = parent.frames['navigationFrame'];
  oSelector        = oNavigationFrame.frames['navigationSelector'];
}

function getQuery() { return (query) ? deHTML(query, 'query') : '';}
function getName() { return (name) ? deHTML(name, 'name') : '';}
function getHitNo() { return (hitNo && hitNo > -1) ? hitNo : ''; }
function getLinkedPath()  { return (linkedPath) ? deHTML(linkedPath, 'linkedPath') : '';}
function getAtLast(){ return (atLast) ? atLast : false;}
function getTotalResult(){ return (totalResult) ? totalResult : 0;}

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
  return true;
}

function hits()
{
  top.redrawContentHead = false;
  var oForm = document.forms['hitsForm'];
  oForm.elements['name'].value = getName();
  oForm.elements['hitNo'].value = getHitNo();
  oForm.elements['query'].value = getQuery();
  oForm.elements['totalResult'].value = getTotalResult();
  return true;
}

function goToSearchResult( oForm )
{
  // var oForm = document.forms[ formName ];
  oForm.elements['query'].value = getQuery();
  var hitNo = getHitNo();
  var mod = hitNo % oForm.maxResult.value;
  var firstItem = hitNo - mod;
  oForm.elements['offset'].value = firstItem; // getHitNo();
  // TODO:
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

function refreshContent() {
	if(isRefreshed == false) {
		refreshContentCounter = 0;
		isRefreshed = true;
	}
	refreshContentCounter++;

	// refresh content
	var oContent = window.top.frames['content'];
	if( oContent ) {
		var sURL = "showDocument.do?name=" + name;
		if(query != "" && isPrevNextDocNavigation == false) {
			if(contentType == "PDFPERPAGECONTENT") {
				var baseURL = document.location.href;
				baseURL = baseURL.substr(0, baseURL.indexOf("showDocumentMeta"));
				sURL += "%23xml=" + baseURL + "pdfHighlighter.do"
					+  '?name=' + name
					+  '%26query=' + query
					// +  '%26zoom=100'
					+  '%26view=FitVH,100'
					;
			} else {
				sURL += '&query=' + query
					 +  '#hit1';
			}
		} else if(contentType == "PDFPERPAGECONTENT") {
			sURL += '%23view=FitVH,100';  // Parlamenti Napló
		}

		if(contentType == "PDFPERPAGECONTENT") {
			oContent.location = "pdfHolder.do?url=" + sURL;
		} else {
			oContent.location = sURL;
		}
	}
}

function baseInit() {
	// refresh referenceBar
	var oDiv = document.getElementById("linkedPathContainer");
	if(oDiv != null) {
		linkedPath = oDiv.innerHTML;
		var oReferenceBar = window.top.frames['referenceBar'];
		if( oReferenceBar ) {
			oReferenceBar.document.getElementById('referenceBar').innerHTML = linkedPath;
		}
	}
	//alert("->refreshContent");
	refreshContent();

	if( this.query != "" ){
		// refresh counter
		resultCounter();
	}

	if(contentType != "PDFPERPAGECONTENT") {
		init();
	}

	// refresh images
	setImages();
}
</script>

<style type="text/css">
 form, input, span.admin { display: inline; }
</style>

</head>
<body onload="loaded = true; baseInit();">

<div id="linkedPathContainer" style="display: none;"><bean:write name="showDocumentMetaForm" property="linkedPath" filter="false"/></div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="left" valign="middle">

    <td class="admin" valign="middle">
      <!-- Menu synchronization  treeFrameset.jsp -->
      <form action="treeView.do" name="syncForm"
            target="tree"
            class="admin_inline"
            onsubmit="return sync();">
        <input type="hidden" name="parentStr" value="">
        <span class="admin">
        <html:image src="icons/e_synch_toc.gif" style="border: 0;"
                    titleKey="showdoc.menusync" altKey="showdoc.menusync"
                    property="menuSync" align="baseline" />
        </span>
      </form>

      <!-- print -->
      <span class="admin">
      <html:image src="icons/e_print_edit.gif"
                  property="print"  align="baseline" style="border: 0;"
                  titleKey="showdoc.print" altKey="showdoc.print"
                  onclick="print();" styleClass="admin_inline"/>
      </span>

      <!-- bookmark -->
      <form action="bookmarkFrameset.jsp"
            method="get"
            name="bookmarkForm"
            target="bookmarkFrameset"
            onsubmit="bookmark()"
            class="admin_inline">
        <span class="admin">
          <input type="hidden" name="name" value="">
          <input type="hidden" name="path" value="">
          <html:image src="icons/e_bookmark_add.gif"
                      property="addBkmr"
                      titleKey="showdoc.addBookMark" style="border: 0;"
                      altKey="showdoc.addBookMark"  styleClass="admin_inline" />
        </span>
      </form>

      <!--* prev doc / next doc *-->
      <form action="showDocumentMeta.do"
            name="showForm"
            method="get"
            onsubmit="return show();"
            class="admin_inline">
          <input type="hidden" name="name"  value=""/>
          <input type="hidden" name="query" value=""/>
          <input type="hidden" name="hitNo" value=""/>
          <input type="hidden" name="totalResult" value=""/>
          <html:hidden name="showDocumentMetaForm" property="maxResult" />
        <span class="admin">
          <html:image src="icons/prev_toc.gif"
                      property="prevPage"
                      titleKey="application.prevpage" style="border: 0;"
                      altKey="application.prevpage"   styleClass="admin_inline" />
          <bean:message key="showdoc.booknav" />
          <html:image src="icons/next_toc.gif"
                      property="nextPage"
                      titleKey="application.nextpage" style="border: 0;"
                      altKey="application.nextpage"   styleClass="admin_inline" />
        </span>
      </form>

      <!--* navigation bar for query *-->
      <div class="admin" id="queryNavigation" style="visibility: hidden;">

        <!--* prev result / next result *-->
        <form action="showDocumentMeta.do"
              name="hitsForm"
              method="get"
              onsubmit="return hits();"
              class="admin_inline">
          <input type="hidden" name="name"  value="" />
          <input type="hidden" name="query" value="" />
          <input type="hidden" name="hitNo" value="" />
          <input type="hidden" name="totalResult" value="" />
          <html:hidden name="showDocumentMetaForm" property="maxResult" />
          <span class="admin">
            <html:image src="icons/prev_search_d.gif"
                      disabled="true"
                      property="prevRes"
                      titleKey="application.prevres"
                      altKey="application.prevres"
                      style="border: 0;" />
            <bean:message key="showdoc.resnav" />
            <html:image src="icons/next_search_d.gif"
                      disabled="true"
                      property="nextRes"
                      titleKey="application.nextres"
                      altKey="application.nextres"
                      style="border: 0;" />
          </span>
        </form>

        <!--* prev hit / next hit *-->
        <span class="admin" <logic:equal name="showDocumentMetaForm" property="contentType" value="PDFPERPAGECONTENT">style="display: none;"</logic:equal>>
          <a href="#hit1" onclick="PrevMatch( this );"
            ><img id="prev_nav" src="icons/prev_nav.gif"
                 title="<bean:message key="application.prevhit" />"
                 alt="<bean:message key="application.prevhit" />"
                 style="border: 0;"
          ></a>
          <bean:message key="showdoc.docnav" />
          <a href="#hit2" onclick="NextMatch( this );"
            ><img id="next_nav" src="icons/next_nav.gif"
                 title="<bean:message key="application.nexthit" />"
                 alt="<bean:message key="application.nexthit" />"
                 style="border: 0;"
          ></a>
        </span>

        <!--* hitlist (search result list) *-->
        <html:form action="searchResult.do"
                   method="get"
                   target="content"
                   styleClass="admin_inline"
                   onsubmit="goToSearchResult(this)">
          <span class="admin">
            <input type="hidden" name="query" value="" />
            <input type="hidden" name="offset" value="" />
            <input type="hidden" name="oldSearch" value="1" />
            <html:hidden name="showDocumentMetaForm" property="maxResult" />
            <bean:message key="showdoc.backres" />
            <html:image src="icons/e_search.gif"
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
