function init( TREE_ITEMS )
{
  oTreeContainer = get_element("tree_container");
	if( TREE_ITEMS.length == 0 )
  {
    oTreeContainer.innerHTML = noResultMsg;
    return false;
  }
  
  var text = '', t1,t2;
  if( this.titleFormatable == true && top.time )
  {
    text += 'betöltés: ' + ( getTime() - top.time ) + LN;
  }

  t1 = getTime();
  makeTree( TREE_ITEMS, '_root:null', true );
  // debug( 'writeLinearTree', writeLinearTree() );
  text += 'makeTree: ' + ( getTime() - t1 ) + LN;


  TREE_ITEMS = undefined;

  // writeTree
  t1 = getTime();
  var treeString = writeTree( 0, '' );
  // debug( 'treeString', treeString );
  oTreeContainer.innerHTML = treeString;
  text += 'writeTree: ' + ( getTime() - t1 ) + LN;

  // document.write( writeTree( 0, '' ) );
  return true;
}

function syncElement( name )
{
  if( name == '' )
    return false;
  
  if( this.currentSelectedID )
  {
    deSync( this.currentSelectedID );
  }

  this.currentSelectedID = 'l_' + name;
  var oLink = get_element( currentSelectedID );

  var oText = oLink.nextSibling;

  var newElem = document.createElement('b');
  newElem.innerHTML = oText.nodeValue;
  oText.parentNode.replaceChild( newElem, oText );

  var oDiv = get_element( name );

  while( oDiv.parentNode && oDiv.id && oDiv.nodeName == 'DIV' && oDiv.id.indexOf( ' ' ) == -1 && oDiv.id != '_root' )
  {
    var arrayId = this.normalizedTreeIndex[ oDiv.id ]
    tocX( arrayId, 'force' );
    oDiv = oDiv.parentNode;
  }
  
  self.location.hash = 'l_' + name;
  return false;
}

function needUpdateChildrenNames( arrayIdString )
{
   this.childrenNames = new Array();
   this.childrenIds = new Array();
   this.hasKwics = new Array();
   
   alert( 'needUpdateChildrenNames: ' + arrayIdString );
   var needUpdate = false;
   var children = arrayIdString.split( ',' );
   for( var i=0; i<children.length; i++ )
   {
     var treeFrg = this.normalizedTree[ children[i] ];
     alert( i + ' = ' + treeFrg.title );
     if( needUpdate == false 
        && ( treeFrg.title == '' 
          || treeFrg.title.substr( 0, 4 ) == ' :: ' ) 
          || treeFrg.title == 'UL' 
          )
     {
        needUpdate = true;
     }
     this.childrenNames[ this.childrenNames.length ] = treeFrg.title;
     this.childrenIds[ this.childrenIds.length ]     = treeFrg.id;
     this.hasKwics[ this.hasKwics.length ]           = treeFrg.hasKwic;
   }
   alert( 'needUpdate: ' + needUpdate );
   return needUpdate;
}