var LN = "\n";
var BR = '<br>' + LN;
top.redrawContentHead = false;

var imageMode = 'text'; // alternative: image
var IMG_PRE = '<img src="icons/';
var IMG_POST = '.gif" border="0" align="absbottom">';
var IMG_MIDDLE_ID = '.gif" id="pic_';
var IMG_POST_ID = '" border="0" align="absbottom">';

var normalizedTree = new Array();
var normalizedTreeIndex = new Array();
var currentSelectedID;
var currentUploadID = "";
var currentUploadTitle;
var parentOfSyncronizedElement = "";
var k = -1;
var from;
var titleFormatable;
var contextArray;
var AutoOpenQueue = new Array();
var completedNodes = new Array();
var datatransferCompleted = true;

/* main methods */
// parentStr=name:title
function makeTree( subTree, parentStr, isLast )
{
  if( typeof subTree == "object" )
  {
    if( subTree.length == 1 )
    {
      makeTree( subTree[0], parentStr, isLast );
    } else {
      this.k++;
      dataProcess( subTree, parentStr, isLast );
    }
  }
}

function dataProcess( oTree, parentStr, isLast )
{
	var i;
  this.normalizedTree[ this.k ] = new Array();
  this.normalizedTree[ this.k ]["id"] = oTree[0];
  sTitle = (oTree[1].length > 0) ? oTree[1] : oTree[0]+':'+oTree[0];
  // alert(sTitle);
  this.normalizedTree[ this.k ]["title"] = sTitle;
  this.normalizedTree[ this.k ]["isParent"] = ( oTree[2].length ) ? true : false;
  this.normalizedTree[ this.k ]["childOffset"] = oTree[3];
  this.normalizedTree[ this.k ]["hasMoreChildren"] = oTree[4];
  this.normalizedTree[ this.k ]["parent"] = parentStr;
  this.normalizedTree[ this.k ]["children"] = '';
  this.normalizedTree[ this.k ]["isLast"] = isLast;
  if( typeof oTree[5] != "undefined" )
  {
    this.normalizedTree[ this.k ]["nodeCounter"] = oTree[5];
  }
  if( typeof oTree[6] != "undefined" && oTree[6] != "highlight" )
  {
    this.normalizedTree[ this.k ]["highlight"] = oTree[6];
  }
  this.normalizedTreeIndex[ oTree[0]+':'+oTree[1] ] = this.k;
  
  if( parentStr.indexOf('_root:') !== 0 )
  {
    var parentID = this.normalizedTreeIndex[ parentStr ];
    this.normalizedTree[parentID]["children"] += 
      ( this.normalizedTree[parentID]["children"].length > 0 ) 
      ? ',' : '';
    this.normalizedTree[parentID]["children"] += this.k;
  }

  // this.normalizedTree[ this.k ]["isLast"] = is_last;

  if( oTree[2].length && oTree[2][0] != 'UL' )
  {
    for( i = 0; i<oTree[2].length; i++ )
    {
      isLast = ( i == oTree[2].length - 1 ) ? true : false;
      makeTree( oTree[2][i], oTree[0]+':'+oTree[1], isLast );
    }
  }
}

function writeTree( arrayId, prefixIcons )
{
  var text = '';
  var treeFrg = this.normalizedTree[ arrayId ];

  // text += '<!-- ' + treeFrg.id + ' ' + treeFrg.parent + ' -->' + LN;
  // text += '<div id="' + treeFrg.id + '" style="display: ';
  text += '<div id="div' + arrayId + '" oid="' + treeFrg.id + '" style="display: ';
  if( ! treeFrg.parent || treeFrg.parent == '_root:null' )
  {
    text += 'block';
    treeFrg.open = false;
  } else {
    text += 'none';
    treeFrg.open = false;
  }
  text += '"';
  text += ( treeFrg.isParent ) ?  ' class="parent"' : ' class="child"';
  text += '>';

  text += prefixIcons;
  text += getJunctionImg( treeFrg.isLast );
  text += ( treeFrg.isParent ) 
       ? '<a id="l_' + arrayId + '" oid="l_' + treeFrg.id + '"'
         + ' href="treeView.do?parentStr=treeFrg.id"'
         // + ' onclick="tocX(' + arrayId + ');return false;">' 
         + ' onclick="tocX(' + arrayId + ');return false;" class="tocx">' 
       : '<span id="l_div' + arrayId + '" oid="l_' + treeFrg.id + '">';
  text += getDoctypeImg( treeFrg.isParent, treeFrg.isLast, treeFrg.id );
  text += ( treeFrg.isParent ) ? '</a>' : '</span>';
	text += ' ';
  text += ( this.titleFormatable == true ) 
       ? formatTitle( treeFrg.title, treeFrg.id ) 
       : linker( treeFrg.title, treeFrg.id );
  text += ( this.titleFormatable == true && treeFrg.highlight ) 
       ? LN + '<div class="kwic">' + treeFrg.highlight + '</div>' + LN 
       : '';
  text = text.replace( /<\/tt><tt>/g, '' );
  
  prefixIcons += getSpImg( treeFrg.isLast );
  
  if( treeFrg.isParent && treeFrg.children )
  {
    var children = treeFrg.children.split( ',' );
    var min = ( this.displayFrom && this.displayFrom > 0 ) ? this.displayFrom : 0;
    var max = ( this.uploadMethod && this.uploadMethod == "getprev" )
            ? getCurrentIndex( children, this.firstChild )
            : ( ( children.length - min ) > this.OFFSET ) 
            ? min + this.OFFSET 
            : children.length;

    /* link for the previous elements */
    if( treeFrg.childOffset > 0 )
    {
      text += '<div id="prevtemp_' + arrayId + '" oid="prevtemp_' + treeFrg.id + '">' 
           + prefixIcons 
           + '<a href="javascript:void(0)"'
           + ' onclick="getprev( \'' 
           + this.normalizedTreeIndex[ treeFrg.id+':'+treeFrg.title ] 
           + '\', ' + treeFrg.childOffset + ' );return false;">'
           + '[' + forwardMsg + ']</a></div>'
           + LN;
    }

    /* recursive calls for the children */
    for( var i = min; i<max; i++ )
    {
      if( this.normalizedTree[ children[i] ]["id"] == 999 )
      {
        text += '<div id="tmp_' + arrayId + '" oid="tmp_' + treeFrg.id + '" class="temp"></div>' + LN;
      } else {
        /** insert the tmp_xxx div before the first child */
        if( i == min )
        {
          text += '<div id="tmp_' + arrayId + '" oid="tmp_' + treeFrg.id + '" style="display:none"></div>' + LN;
        }
        text += writeTree( children[i], prefixIcons );
      }
    }
    
    /* link to the next elements */
    if( max < children.length 
     || treeFrg.hasMoreChildren == 1 )
    {
      text += '<div id="nexttemp_' + arrayId + '" oid="nexttemp_' + treeFrg.id + '">' 
           + prefixIcons 
           + '<a href="javascript:void(0)"'
           + ' onclick="getnext( \'' 
           + this.normalizedTreeIndex[ treeFrg.id+':'+treeFrg.title ] 
           + '\' );return false;">'
           + '[' + forwardMsg + ']</a></div>'
           + LN;
    }
  /* temporary container for the children to download */
  } else if ( treeFrg.isParent && treeFrg.children == '' ) {
    text += '<div id="tmp_' + arrayId + '" oid="tmp_' + treeFrg.id + '" class="temp"></div>' + LN;
  }
  
  text += '</div>' + LN;
  
  return text;
}

/**
 * tocX - trigger branches
 */
function tocX( arrayId, type )
{
	if(arrayId == null) {
		return;
	}
	// console.info("tocX(" + arrayId + ")");
  var oDiv;
  var treeFrg = this.normalizedTree[ arrayId ];
  if(treeFrg == null) {
  	return;
  }

  if( treeFrg.isParent && treeFrg.children == '' )
  {
		this.datatransferCompleted = false;
		this.uploadMethod = 'upload_complete';
		getUpdateData( treeFrg, 0, 1 );
		return false;
	}
  
  var text = '';

  if( type && type == 'force' )
  {
    treeFrg.open = true;
  } else {
    treeFrg.open = ( treeFrg.open ) ? false : true;
  }

  /* open/close and change opener/closer icon if this is a parent */
  if( treeFrg.isParent ) {
    // change opener/closer icon if any
    var oPic = get_element( 'pic_' + arrayId ); // treeFrg.id
    if( oPic != null ) {
      if( type && type == 'force' ) {
        oPic.src = 'icons/minus.gif';
      }
      else {
        oPic.src = ( treeFrg.open ) ? 'icons/minus.gif' : 'icons/plus.gif';
      }
    }

    // change opener/closer icon in text format if any
    // var oLink = get_element( 'l_' + treeFrg.id );
    var oLink = get_element( 'l_' + arrayId );
    var text = oLink.getElementsByTagName( 'TT' )[0];
    if( text ) {
      // text.innerHTML = ( text.innerHTML == '+' ) ? '&lt;' : '+';
      text.innerHTML = ( text.innerHTML == '+' ) ? '*' : '+';
    }

    var children = treeFrg.children.split( ',' );
    var min = 0;
    var max = children.length;
    
    for( var i = min; i<max; i++ )
    {
       var childTreeFrg = this.normalizedTree[ children[i] ];
       if( childTreeFrg.id != 999 )
       {
         oDiv = get_element( 'div' + children[i] ); // childTreeFrg.id 
         if( oDiv )
         {
           completedNodes['c' + children[i]] = 1;
           if( type && type == 'force' )
           {
              oDiv.style.display = 'block';
           } else {
              oDiv.style.display = ( treeFrg.open ) ? 'block' : 'none';
           }
         }
       }
    }
    
    oDiv = get_element( 'prevtemp_' + arrayId );
    if( oDiv )
    {
      oDiv.style.display = ( treeFrg.open ) ? 'block' : 'none';
    }

    oDiv = get_element( 'nexttemp_' + arrayId );
    if( oDiv )
    {
      oDiv.style.display = ( treeFrg.open ) ? 'block' : 'none';
    }
  }
  
  if( !type || type != 'force' )
  {
    document.location.hash = 'l_' + treeFrg.id;
  }
  
  if( this.checkBoxVisibility && this.checkBoxVisibility == true )
  {
    showCheckbox( true );
  }
  
  completedNodes['c' + arrayId] = 1;
  if(frameName == 'treeFilter') {
	  onTocFinished(treeFrg, type);
	}
  return false;
}

function onTocFinished(treeFrg, counter) {
	if( typeof(counter) == "undefined" ) {
		counter = 1;
	}
	if( treeFrg.isParent && treeFrg.open ) {
		var children = treeFrg.children.split( ',' );
		var isComplete = true;
		var oDiv = null;
		for( var i = 0, len=children.length; i<len; i++ )
		{
			oDiv = get_element('div' + children[i]);
			if(oDiv == null){
				isComplete = false;
			}
		}
		if(isComplete == false) {
			setTimeout(onTocFinished(treeFrg, counter+1), 500);
		} else {
			for(var i = 0, len=children.length; i<len; i++ ) {
				AutoOpenQueue.push(children[i]);
			}
			setTimeout(onTocXComplete, 500);
		}
	}
}

function onTocXComplete() {
	if(AutoOpenQueue.length == -1) {
		return;
	}
	// console.info("this.currentUploadID: '" + this.currentUploadID + "', this.datatransferCompleted: " + this.datatransferCompleted + " (" + AutoOpenQueue.join(', ') + ")");
	var List = new Array();
	var found = false; 
	var first = null;
	for(var i=0; i<AutoOpenQueue.length; i++) {
		if(frameName == 'treeFilter' &&
			this.datatransferCompleted == true && 
			found == false &&
			completedNodes['c' + AutoOpenQueue[i]] && 
			completedNodes['c' + AutoOpenQueue[i]] == 1) 
		{
			first = AutoOpenQueue[i];
			found = true;
		}
		else {
			List.push(AutoOpenQueue[i]);
		}
	}
	if(first != null) {
		AutoOpenQueue = List;
		// console.info("onTocXComplete->tocX(" + first + ")");
		tocX(first);
	}
	if(AutoOpenQueue.length > 0) {
		setTimeout(onTocXComplete, 1000);
	}
}

function getprev( arrayId, from )
{
  this.displayFrom = from;
  
  var treeFrg = this.normalizedTree[ arrayId ];
  var children = treeFrg.children.split( ',' );
  if( ! this.load )
  {
    this.uploadMethod = 'getprev';
    this.firstChild = children[ 0 ];
    getUpdateData( treeFrg, from, 0 );
  }
  else
  {
    this.load = 0;
    this.displayFrom = 0;
    
    var subTree = writeTree( arrayId, getPrefixString( arrayId ) )
    var origSubTree = subTree;
    subTree = subTree.replace( /\n/g, '' );
    subTree = subTree.replace( /^.*?<br>/, '' );
    subTree = subTree.replace( /^.*? id="a_[^<>]+>[^<>]+<\/a>/, '' );
    subTree = subTree.replace( /<\/div>$/, '' );
    var match = subTree.match( /joinbottom\.gif/ );
    if( match )
    {
      var i = RegExp.index; 
      var orig = subTree.substr( 0, i );
      var newText = orig;
      newText = newText.replace( /join\.gif/, 'joinbottom.gif' );
      if( orig != newText )
      {
        subTree = newText + subTree.substr( i );
      }
    }
    
    var pattern = new RegExp( "<div [^<>]*=\"nexttemp_" + arrayId + "\"[^<>]*>(.|\n)*?<\/div>", "i" );
    subTree = subTree.replace( pattern, "" ); 
    
    var oDiv = get_element( 'div' + arrayId ); // treeFrg.id
    var currentHTML = oDiv.innerHTML;
    pattern = new RegExp( "<div [^<>]*=\"?prevtemp_" 
                         + arrayId 
                         + "\"?[^<>]*>(?:.|\n)*?<\/div>"
                         , "i" );
    currentHTML = currentHTML.replace( pattern, subTree ); 
    oDiv.innerHTML = currentHTML;
    
    var oChildren = oDiv.getElementsByTagName( 'div' );
    var lastChild = oChildren[ oChildren.length - 1 ];
  
    tocX( arrayId );
    document.location.hash = 'l_' + lastChild.id;
  }
  return false;
}

function getnext( arrayId )
{
  var treeFrg = this.normalizedTree[ arrayId ];
  var children = treeFrg.children.split( ',' );

  if( ! this.load )
  {
    this.displayFrom = children.length - 1;
    from = parseInt( treeFrg.childOffset ) + children.length;
    this.uploadMethod = 'getnext';
    getUpdateData( treeFrg, from, 1 );
  }
  else
  {
    this.load = 0;
    var subTree = writeTree( arrayId, getPrefixString( arrayId ) );
    
    var origSubTree = subTree;
    
    // remove the parent div from top and bottom
    subTree = subTree.replace( /\n/g, '' );
    subTree = subTree.replace( /^.*?<br>/, '' );
    subTree = subTree.replace( /^.*?id="a_[^<>]+>[^<>]+<\/a>/, '' );
    subTree = subTree.replace( /<\/div>$/, '' );
    
    // get the first a_... id
    var firstA = subTree.match( /id="?(a_[^" ]+)[" ]/ );
    
    var match = subTree.match( /joinbottom\.gif/ );
    if( match ) {
      var i = RegExp.index; 
      var orig = subTree.substr( 0, i );
      var newText = orig;
      newText = newText.replace( /join\.gif/, 'joinbottom.gif' );
      if( orig != newText ) {
        subTree = newText + subTree.substr( i );
      }
    }
  
    var oDiv = get_element( 'div' + arrayId ); // treeFrg.id
    var oNextTemp = get_element( 'nexttemp_' + arrayId ); // treeFrg.id
    if(oDiv != null) {
    	if(oNextTemp != null) {
    		oDiv.removeChild(oNextTemp);
    	} else {
    		alert("[getnext] missing div: " + 'nexttemp_' + arrayId);
    	}
    } else {
    	alert("[getnext] missing div: " + 'div' + arrayId);
    }
    var childDivs = oDiv.getElementsByTagName( 'div' );
    var lastChild = childDivs[ childDivs.length - 1 ];
    
    // remove the div with id form subTree
    if( firstA[1] == 'a_' + lastChild.getAttribute("id") ) {
      var pattern = new RegExp( "<div [^<>]*id=\"?" 
                          + lastChild.getAttribute("id") 
                          + "\"?[^<>]*>.*?<\/div>" );
      subTree = subTree.replace( pattern, '' );
    }    
    var text = lastChild.getElementsByTagName( 'TT' )[0].innerHTML;
    // text = text.replace( /--$/i, '|-' );
    text = text.replace( /&nbsp;&nbsp;$/i, '|&nbsp;' );
    lastChild.getElementsByTagName( 'TT' )[0].innerHTML = text;
    
    var oChildren = oDiv.getElementsByTagName( 'div' );
    var lastChild = oDiv.id;
    var pattern = new RegExp( "tmp_" );
    for (var j = oChildren.length-1; j>-1; j-- ) {
      var id = oChildren[j].id;
      if (!id.match(pattern)) {
        lastChild = id;
        break;
      } 
    }
    // escape the "/"s in the regex
    // var id2pattern = arrayId.replace( /\//g, "\\\/" );
    pattern = new RegExp( "^.*?tmp_" + arrayId + "(.*?)</div>" );
    subTree = subTree.replace( pattern, '' );
    
    // var lastChild = oChildren[ oChildren.length - 1 ];
    subTree = oDiv.innerHTML + subTree;
    oDiv.innerHTML = subTree;

    tocX( arrayId );
    document.location.hash = 'l_' + lastChild;
  }
  return false;
}

function getUpdateData ( treeFrg, from, direction )
{
	// console.info("getUpdateData(" + treeFrg.id + ")");

  if( this.uploadMethod == 'upload_complete' )
  {
    var arrayId = this.normalizedTreeIndex[treeFrg.id+':'+treeFrg.title];
    var oDiv = get_element( 'tmp_' + arrayId );
    if( oDiv != null )
    {
      oDiv.innerHTML = loadingMsg;
      oDiv.style.display = 'block';
    } else {
      alert( "[getUpdateData] missing div: " + 'tmp_' + arrayId );
    }
  }
  changeURL ( treeFrg, from, direction );
  return false;
}

function changeURL ( treeFrg, from, direction )
{
	// console.info("changeURL(" + treeFrg.id + ")");
  this.currentUploadID = treeFrg.id;
  this.currentUploadTitle = treeFrg.title;
  var oForm = document.forms['updateForm'];
  var oldLoc = ( this.newLoc ) ? this.newLoc : '';
  var isSyncronized 
  	= (this.parentOfSyncronizedElement.indexOf(treeFrg.id + ':') != -1 &&
  	this.uploadMethod != "upload_complete") 
  	? 1 : 0;

  var newLoc = '';
  newLoc += ( typeof treeFrg.nodeCounter != "undefined" )
         ? 'treeFilterFragment.do'
         : 'treeFragment.do';
  newLoc += '?parentStr=' + this.currentUploadID
         +  '&offset='    + from
         +  '&direction=' + direction
         +  '&title='     + treeFrg.title
         +  '&isSyncronized=' + isSyncronized;

  oForm.elements['parentStr'].value = this.currentUploadID;
  oForm.elements['offset'].value    = from;
  oForm.elements['direction'].value = direction;
  oForm.elements['title'].value    = treeFrg.title;
  oForm.elements['isSyncronized'].value = isSyncronized;
  if( typeof treeFrg.nodeCounter != "undefined" )
  {
    newLoc += '&query=' + top.query;
    oForm.elements['query'].value = top.query;
  }

  if( oldLoc != newLoc ){
    oForm.submit();
  }
  
  this.newLoc = newLoc;
}

function upload_complete( oTree )
{
	this.datatransferCompleted = true;
	// console.info("upload_complete(" + oTree[0][0] + ")");
	if(this.currentUploadID != oTree[0][0]) {
		// console.error(this.currentUploadID + "!=" + oTree[0][0]);
	}
	if(this.currentUploadTitle != oTree[0][1]) {
		// console.error(this.currentUploadTitle + "!=" + oTree[0][1]);
	}
	var oldK = this.k;
  var i;
  var arrayId = this.normalizedTreeIndex[ oTree[0][0]+':'+oTree[0][1] ];

  // first childs' id
  var firstID = oTree[0][2][0][0];
  var firstTitle = oTree[0][2][0][1];
  for( i in oTree[0][2] )
  {
    if( this.uploadMethod != 'getprev' )
    {
      var isLast = ( i == oTree[0][2].length - 1 ) ? true : false;
      makeTree( oTree[0][2][i], oTree[0][0]+':'+oTree[0][1], isLast );
    } else {
      makeTree( oTree[0][2][i], oTree[0][0]+':'+oTree[0][1], false );
    }
  }
  if( this.uploadMethod == 'getprev' )
  {
    var lookupID = this.normalizedTreeIndex[ firstID+':'+firstTitle ];
    
    var children = this.normalizedTree[ arrayId ].children;
    this.lengthOfUploadedArray = oTree[0][2].length;
    if( this.lengthOfUploadedArray > 1 )
    {
      var index = children.indexOf( ',' + lookupID + ',' );
      this.normalizedTree[ arrayId ].children 
        = children.substr( index + 1 ) + ',' + children.substr( 0, index );
    } else if( this.lengthOfUploadedArray == 1 ) {
      this.normalizedTree[ arrayId ].children 
        = lookupID + ',' 
        + children.substr(0, children.length-(lookupID.length+1));
    }
  }
  
  if( this.uploadMethod == 'getprev' )
  {
    this.normalizedTree[ arrayId ]["childOffset"] = oTree[0][3];
  } else {
    this.normalizedTree[ arrayId ]["hasMoreChildren"] = oTree[0][4];
  }

  if( this.uploadMethod == 'getnext' )
  {
    this.load = 1;
    getnext( arrayId );
    this.currentUploadID = "";
  }
  else if( this.uploadMethod == 'getprev' )
  {
    this.load = 1;
    getprev( arrayId, this.displayFrom );
    this.currentUploadID = "";
  }
  else
  {
    this.displayFrom = 0;
    var subTree = writeTree( arrayId, getPrefixString( arrayId ) );

    subTree = subTree.replace( /^<div[^<>]+>/, '' );
    /*  a temp div törlése
     |_ <div id="tmp_egyet_tort43" class="temp"></div> __*/
    var regex = ' id="tmp_' + arrayId + '" class="temp"'; // this.currentUploadID -> oTree[0][0] -> arrayId
    subTree = subTree.replace( regex, '' );
    regex = '<div></div>';
    subTree = subTree.replace( regex, '' );
    subTree = subTree.replace( /\n$/, '' );
    subTree = subTree.replace( /<\/div>$/, '' );

    // var oDiv = get_element( this.currentUploadID );
    var oDiv = get_element( 'div' + arrayId );

    oDiv.innerHTML = subTree;
    // bug (? or misundertand): a new empty div inserted after subTree
    var oLast = oDiv.lastChild;
    // var atts = oLast.attributes;
    if( oLast.attributes == null ||        // for FF
        ( oLast.getAttribute( 'id' ) == "" // for IE [attributes contains all the 
         && oLast.className != 'kwic' )    // specified==false attibutes]
    )
    {
      oDiv.removeChild( oDiv.lastChild );
    }
    this.currentUploadID = "";
    tocX(arrayId);
  }
  this.uploadMethod = "";
	// console.info("/upload_complete(" + oTree[0][0] + ")");
}


/* end of main methods */

function debug( title, text )
{
  if (this.allowDebugConsole == false)
    return false;

  var oDebug = document.getElementById( 'debug' );
  if( ! oDebug )
    return false;

  if( title == 'reset()' )
  {
    oDebug.innerHTML = '';
  } else { 
    oDebug.innerHTML += BR + '=== ' + title + ' ===' + BR;
    if( text.length > 0 )
      oDebug.innerHTML += text.replace( /</g, '&lt;' ).replace( />/g, '&gt;' ).replace( /\n/g, BR );
  }
  return true;  
}

function writeLinearTree()
{
  var text = "";
  for( var i in this.normalizedTree )
  {
    if( this.normalizedTree[i] )
    {
      text += i + ")";
      for( var j in this.normalizedTree[i] )
      {
        text += ' ' + j + '="' + this.normalizedTree[i][j] + '"';
      }
      text += LN;
    }
  }
  return text;
}

function getPrefixString( arrayId )
{
  var prefixStr = '', text = '', prefixArray = new Array();
 
  while( arrayId != undefined )
  {
    var treeFrg = this.normalizedTree[ arrayId ];
    text += treeFrg.id + ': ' + getSpImg( treeFrg.isLast ) + LN;
    prefixArray.unshift( getSpImg( treeFrg.isLast )  );
    prefixStr = getSpImg( treeFrg.isLast ) + prefixStr;
    arrayId = ( treeFrg.parent.indexOf('_root:') != 0 ) 
            ? this.normalizedTreeIndex[ treeFrg.parent ] 
            : undefined;
  }
  prefixArray.pop();
  return prefixArray.join('');
}

function getDoctypeImg( b_parent, b_last, id )
{
  var text;
  if( this.imageMode == 'text' ) {
    // text = ( b_parent ) ? '<tt>+</tt>&nbsp;' : '&nbsp;';
    text = ( b_parent ) ? '<tt>+</tt>' : ''; // &nbsp;';
    return text;
  }
  else {
    text = ( b_parent ) ? 'plus' : 'page';
    return IMG_PRE + text + IMG_MIDDLE_ID + id + IMG_POST_ID;
  }
}

function getJunctionImg( b_last )
{
  var text;
  if( this.imageMode == 'text' ) {
    // text = ( b_last ) ? '--' : '|-';
    text = ( b_last ) ? '&nbsp;&nbsp;' : '&nbsp;&nbsp;';
    return '<tt>' + text + '</tt>';
  }
  else {
    text = 'join';
    text += ( b_last ) ? '' : 'bottom';
    return IMG_PRE + text + IMG_POST;
  }
}

function getSpImg( b_last )
{
  var text;
  if( this.imageMode == 'text' ) {
    // text = ( b_last ) ? '&nbsp;&nbsp;' : '|&nbsp;';
    text = ( b_last ) ? '&nbsp;&nbsp;' : '&nbsp;&nbsp;';
    return '<tt>' + text + '</tt>';
  }
  else {
    text = ( b_last ) ? 'empty' : 'line';
    return IMG_PRE + text + IMG_POST;
  }
  // return getImg( text );
}

function formatTitle( title, id )
{
  text = linker( title, id, -1 );
  var treeFrg = this.normalizedTree[ this.normalizedTreeIndex[ id+':'+title ] ];
  var num = ( treeFrg.highlight && treeFrg.highlight != 'highlight' ) 
      ? '<em>(' + treeFrg.nodeCounter + ')</em>' 
      : '<em class="noem">(' + treeFrg.nodeCounter + ')</em>';
  return num + '&nbsp;' + text;
}

function getTime()
{
  var now = new Date();
  var time = ( now.getMinutes() * 60 )
           + ( now.getSeconds() )
           + ( now.getMilliseconds() * 0.001 );
  return time;
}

function getInfo( Node )
{
  return text = 'type: ' + getNodeType( Node.nodeType )
         + LN + 'name: ' + Node.nodeName
         + LN + 'value: ' + Node.nodeValue
         + ( ( Node.nodeType != 3 ) ? LN + 'id: ' + Node.id : '' ) 
         // + LN + 'parent: ' + Node.parentNode.nodeName
         // + LN + 'parent.id: ' + Node.parentNode.id
         + ( ( Node.childNodes ) ? LN + 'child: ' + Node.childNodes.length : '' )
         + ( ( Node.nodeType != 3 ) ? LN + 'innerHTML: ' + Node.innerHTML : '' )
         + LN + Node
         + LN
         ;
}

function getNodeType( num )
{
  var text;
  switch( num )
  {
    case 1:  text = 'ELEMENT_NODE'; break;
    case 2:  text = 'ATTRIBUTE_NODE'; break;
    case 3:  text = 'TEXT_NODE'; break;
    case 4:  text = 'CDATA_SECTION_NODE'; break;
    case 5:  text = 'ENTITY_REFERENCE_NODE'; break;
    case 6:  text = 'ENTITY_NODE'; break;
    case 7:  text = 'PROCESSING_INSTRUCTION_NODE'; break;
    case 8:  text = 'COMMENT_NODE'; break;
    case 9:  text = 'DOCUMENT_NODE'; break;
    case 10: text = 'DOCUMENT_TYPE_NODE'; break;
    case 11: text = 'DOCUMENT_FRAGMENT_NODE'; break;
    case 12: text = 'NOTATION_NODE'; break;
    case 13: text = 'ELEMENT_NODE'; break;
  }
  return text;
}

function deSync( id )
{
  var oBold = get_element( id ).nextSibling;
  var newElem = document.createTextNode( oBold.innerHTML );
  oBold.parentNode.replaceChild( newElem, oBold );
}

function get_element( s_id )
{
  if( document.getElementById )
  { 
    return document.getElementById(s_id);
  } else { 
    return document.all[s_id];
  }
}

function linker( title, id, num )
{
  var arrayId = this.normalizedTreeIndex[ id+':'+title ];
  var oForm = document.forms['updateForm'];
  var URL = 'showDocumentMeta.do?name=' + id;
  if ( num && num > -1 ) 
    URL += '&amp;hitNo=' + num + '#hit1';
  if ( oForm != null && frameName == 'treeFilter' ) 
    URL += '&amp;query=' + top.query;
  
  var titleAsAttribute = title.replace(/"/g, "'");
  var link = '<a id="a_' + arrayId + '" oid="a_' + id + '"'
           + ' href="' + URL + '"'
           + ' title="' + titleAsAttribute + '"' 
           + ' onclick="window.top.redrawContentHead = false"'
           + ' target="contentHead">' + title + '</a>';
  
  return link;
}

function getLastQA() {
  return ( 'lastQA', 'Q: ' + this.newLoc + LN + 'A: ' + this.oTreeStr );
}

function getTimestamp() {
  var now = new Date();
  return now.getHours() + ':' + now.getMinutes() 
  	+ ':' + now.getSeconds() 
  	+ ',' + now.getMilliseconds();
}
