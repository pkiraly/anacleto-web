/***************
 * filename:     document.js
 * description:  showDocument.do-hoz tartozó JavaScript funkciók
 * date:         2005.04.20
 ***************
 * developer:  
 **************/
var anchors = new Array();

function init( callerDocumentName )
{
	contentName = callerDocumentName;
	var oDocument  = window.parent.frames["content"];

	anchors = new Array();
	currentHit = 0;

	var pattern = new RegExp( "^" + hitPrefix + '\\d+$' );

	var i, len = oDocument.document.anchors.length;
	for( i=0; i < len; i++ ) {
		if( oDocument.document.anchors[i].name.match( pattern ) ) {
			anchors[ anchors.length ] = oDocument.document.anchors[i].name;
		}
	}

	if( anchors.length > 0 ) {
		if( oDocument.location.hash )
		{
			var hash = oDocument.location.hash;
			pattern = new RegExp( '^#' + hitPrefix + '(\\d+)$' );
			var matches = hash.match( pattern );
			if( matches )
			{
				currentHit = parseInt(matches[1]);
			}
		}
		if( currentHit === 0 )
		{
			currentHit = 1;
		}
		if( anchors.length == 1 )
		{
			// oNextNavImg = xGetElementById( 'next_nav' );
			oNextDocImg = document.getElementById( 'next_nav' );
			oNextDocImg.src = '../icons/next_nav_disabled.gif';
		}
		
		if( oDocument.location.hash != '#' + hitPrefix + '1' )
		{
			oDocument.location.hash = hitPrefix + '1';
		}
	} else {
		if( ! noalert )
			alert( "no anchors" );
	}
	// var timeoutID = setTimeout("setImages()", 500);
	setImages();
	return false;
}

function isLastHit()
{
	var isLast = ( currentHit == anchors.length ) ? true : false;
	return isLast;
}

function move(){
	if( currentHit != '' ) {
		//alert( oDocument.location.hash + "\n" + oDocument.location );
		// window.location.hash = hitPrefix + currentHit;
		return true;
	}
	return false;
}
  
function PrevMatch( a )
{
	if( currentHit != '' && currentHit > 1 )
	{
		currentHit--;
		a.href = '#' + hitPrefix + currentHit;
		if( noalert == false ) 
			alert( a.href.substr( a.href.length - 10, a.href.length ) );
	} else if( currentHit != '' && anchors.length == 1 && currentHit == 1 ){
		a.href = '#' + hitPrefix + currentHit;
		if( noalert == false ) 
			alert( a.href.substr( a.href.length - 10, a.href.length ) );
	}
	setImages();
	oDocument.location.hash = hitPrefix + currentHit;
}
  
function NextMatch( a )
{
	if( typeof(currentHit) == 'number' && currentHit <= anchors.length )
	{
		currentHit++;
		a.href = '#' + hitPrefix + currentHit;
		if( noalert == false ) 
			alert( a.href.substr( a.href.length - 10, a.href.length ) );
	}
	setImages();
	oDocument.location.hash = hitPrefix + currentHit;
}

function setImages()
{
	oPrevDocImg = document.getElementById( 'prev_nav' );
	oNextDocImg = document.getElementById( 'next_nav' );

	if( typeof(currentHit) != 'number' || currentHit < 1 )
	{
		oPrevDocImg.src = 'icons/prev_nav_disabled.gif';
	} else {
		oPrevDocImg.src = 'icons/prev_nav.gif';
	}

	if( typeof(currentHit) != 'number' || currentHit >= anchors.length )
	{
		oNextDocImg.src = 'icons/next_nav_disabled.gif';
	} else {
		oNextDocImg.src = 'icons/next_nav.gif';
	}

	var oPrevResultImg = document.getElementsByName( 'prevRes' )[0];
	var oNextResultImg = document.getElementsByName( 'nextRes' )[0];

	if( getHitNo() == 0 )
	{
		oPrevResultImg.src = "icons/prev_search_d.gif";
		oPrevResultImg.disabled = true;
	} else {
		oPrevResultImg.src = "icons/prev_search.gif";
		oPrevResultImg.disabled = false;
	}

	if( getAtLast() == true )
	{
		oNextResultImg.src = "icons/next_search_d.gif";
		oNextResultImg.disabled = true;
	} else {
		oNextResultImg.src = "icons/next_search.gif";
		oNextResultImg.disabled = false;
	}

	return false;
}

/* Opera alatt a teljes framet nyomtatja */
function printCurrentDocument()
{
	try {
		top.frames['content'].focus();
		top.frames['content'].print();
	} catch(e) {
		alert( e.name + LN + e.message );
	}
}

function synchronizeMenu( docName )
{
	top.name = docName;
	oSelector.showPanel('treeFrameset');
}

function addBookmark() //name, url 
{
	oSelector.showPanel('bookmarkFrameset');
}

function xGetElementById(e) {
	var oDocument  = parent.frames["content"].document;
	if(typeof(e)!='string') return e;
	if( oDocument.getElementById ) e=oDocument.getElementById(e);
	else if(oDocument.all) e=oDocument.all[e];
	else if(oDocument.layers) e=xLayer(e);
	else e=null;
	return e;
}
