// var top = window.top;

function init( TREE_ITEMS )
{
  oTreeContainer = get_element("tree_container");
  var text = '', t1,t2,i;
  if( this.titleFormatable == true )
  {
    text += 'betöltés: ' + ( getTime() - top.time ) + LN;
  }

  t1 = getTime();
  makeTree( TREE_ITEMS, '_root:null', true );
  
  text += 'makeTree: ' + ( getTime() - t1 ) + LN;
  TREE_ITEMS = undefined;

  t1 = getTime();
  if( this.titleFormatable == true )
  {
    makeKwic( parent.document.title );
  }
  text += 'makeKwic: ' + ( getTime() - t1 ) + LN;
  this.wt = writeLinearTree();

  t1 = getTime();
  var treeString = writeTree( 0, '' );
  oTreeContainer.innerHTML = treeString;
  text += 'writeTree: ' + ( getTime() - t1 ) + LN;
}

function syncElement( name )
{
  if( name == '' )
    return false;
  
  var iDivId = -1;
  for(var i=0, len=this.normalizedTree.length; i<len; i++) {
		if(this.normalizedTree[i].id == name) {
			iDivId = i;
			break;
		}
  }
  if( iDivId == -1 ) {
  	return false;
  }
  this.parentOfSyncronizedElement = this.normalizedTree[iDivId].parent;
  
  if( this.currentSelectedID )
  {
    deSync( this.currentSelectedID );
  }
  this.currentSelectedID = 'l_' + iDivId;
  
  var oDiv = get_element( 'div' + iDivId );
  while( oDiv && oDiv.parentNode 
      && oDiv.id 
      && oDiv.nodeName == 'DIV' 
      && oDiv.id.indexOf( ' ' ) == -1 
      && oDiv.id != '_root' )
  {
    var arrayId = (oDiv.id.indexOf(iDivId) != -1) ? iDivId : oDiv.id.substr(3);
    if( oDiv.oid != name )
      tocX( arrayId, 'force' );
    oDiv = oDiv.parentNode;
  }
  
  var oLink = get_element( 'a_' + iDivId );
  if( oLink )
    oLink.className = "toc_selected";
  self.location.hash = 'a_' + iDivId;

  return false;
}

function deSync( id )
{
  var oBold = get_element( id ).nextSibling;
  var newElem = document.createTextNode( oBold.innerHTML );
  oBold.parentNode.replaceChild( newElem, oBold );
}

function buildPath( arrayId )
{
  var aPath = new Array();
  while( arrayId != 0 )
  {
    var treeFrg = this.normalizedTree[ arrayId ];
    if( treeFrg.id != 'root' )
    {
      aPath.unshift( treeFrg.id )
      arrayId = this.normalizedTreeIndex[ treeFrg.parent ];
    } else {
      break;
    }
  }
  return ( aPath.length >= 1 ) 
         ? 'path:/' + aPath.join( '/' ) + '/*' 
         : '';
}

/**
* removeRedundantChildren
* removes all the children, if they are all selected - used in Arcanum Query
* removes the parent, if at least one of its children is unselected
* input array
* return array
*/
function removeRedundantChildren( aCheckedNodes )
{
  var aTrusted = new Array();
  var aUntrusted = new Array();
  var ltTrusted = new Array();   // lookup tables for speed up
  var ltUntrusted = new Array();
  var ltNodes = new Array();

  for( var i=0; i<aCheckedNodes.length; i++ )
  {
    ltNodes[ aCheckedNodes[i] ] = i;
  }

  for( i=0; i<aCheckedNodes.length; i++ )
  {
    var id = aCheckedNodes[i];
    if( ! ltUntrusted[ id ] && ! ltTrusted[ id ] ) //&& id.indexOf( 'f_' ) != 0
    {
      var treeFrg = this.normalizedTree[ id ];
      if( treeFrg.isParent == false )
      {
        aTrusted.push( id );
      } else {
        var isTrusted = true;
        if( treeFrg.children != '' )
        {
          var children = treeFrg.children.split( ',' );
          for( var c=0; c<children.length; c++ ) {
            var childFrg = this.normalizedTree[ children[c] ];
            if( childFrg.id != 999 && ! ltNodes[ children[c] ] ) {
              isTrusted = false; break;
            }
          }
        }

        if( isTrusted == true )
        {
          aTrusted.push( id );
          ltTrusted[ id ] = 1;
          if( treeFrg.children != '' )
          {
            for( c=0; c<children.length; c++ ) {
              treeFrg = this.normalizedTree[ children[c] ];
              aUntrusted.push( children[c] );
              ltUntrusted[ children[c] ] = 1;
            }
          }
        }
      }
    }
  }
  return aTrusted;
}

function getCurrentIndex ( aArray, sElement )
{
  var i;
  for( i = 0; i<aArray.length; i++ )
  {
    if( aArray[i] == sElement )
    {
      return i-1;
    } 
  }
  return i;
}

