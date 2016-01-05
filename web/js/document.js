/***************
 * filename:     document.js
 * description:  showDocument.do-hoz tartoz� JavaScript funkci�k
 * date:         2005.04.20
 ***************
 * developer:  
 **************/

  function init( callerDocumentName )
  {
    contentName = callerDocumentName;
    var oDocument  = window.parent.frames["content"];
    
    anchors = new Array();
    currentHit = -1;

    var pattern = new RegExp( "^" + hitPrefix + '\\d+$' );

    var i;
    for( i=0; i < oDocument.document.anchors.length; i++ ) {
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
      if( currentHit == -1 )
      {
        currentHit = 1;
      }
      if( anchors.length == 1 )
      {
        // oNImg = xGetElementById( 'next_nav' );
        oNImg = document.getElementById( 'next_nav' );
        oNImg.src = '../icons/next_nav_disabled.gif';
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
    if( currentHit == anchors.length )
    {
      return true;
    } else {
      return false;
    }
  }
  
  function move(){
    if( currentHit != '' ) {
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
    
    if( typeof(currentHit) == 'number' && currentHit < anchors.length )
    { 
      currentHit++; 
      a.href = '#' + hitPrefix + currentHit;
      if( noalert == false ) alert( a.href.substr( a.href.length - 10, a.href.length ) );
    }
    setImages();
    oDocument.location.hash = hitPrefix + currentHit;
  }

  function setImages()
  {
    oPImg = document.getElementById( 'prev_nav' );
    oNImg = document.getElementById( 'next_nav' );
    
    /*
    if( oPImg == null && oNImg == null )
      return false;
      */
    
    if( typeof(currentHit) != 'number' || currentHit < 1 )
    {
      oPImg.src = '../icons/prev_nav_disabled.gif';
    } else {
      oPImg.src = '../icons/prev_nav.gif';
    }

    if( typeof(currentHit) != 'number' || currentHit >= anchors.length )
    {
      oNImg.src = '../icons/next_nav_disabled.gif';
    } else {
      oNImg.src = '../icons/next_nav.gif';
    }

    var oPRImg = document.getElementsByName( 'prevRes' )[0];
    var oNRImg = document.getElementsByName( 'nextRes' )[0];
    
    if( getHitNo() == 0 )
    {
      oPRImg.src = "../icons/prev_search_d.gif";
      oPRImg.disabled = true;
    } else {
      oPRImg.src = "../icons/prev_search.gif";
      oPRImg.disabled = false;
    }

    if( getAtLast() == true )
    {
      oNRImg.src = "../icons/next_search_d.gif";
      oNRImg.disabled = true;
    } else {
      oNRImg.src = "../icons/next_search.gif";
      oNRImg.disabled = false;
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

  function synchronizeMenu( frm )
  {
    top.name = frm;
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
