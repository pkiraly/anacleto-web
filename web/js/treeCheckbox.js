var checkBoxState;
// var checkBoxVisibility;

function showCheckbox( b_flag )
{
  var i, elem;
  this.checkBoxVisibility = b_flag;
  
  if( b_flag == true )
  {
    var aLinks = document.getElementsByTagName( 'a' );
    for( i = 0; i < aLinks.length; i++ )
    {
      var cLink = aLinks[i];
      if( cLink.id.indexOf( 'a_' ) == 0 )
      {
        var id = cLink.id.substr( 2 ); // tested
        var checkbox = document.getElementById( 'c_' + id );
        if( ! checkbox ) // filtering duplum
        {
          elem = document.createElement("input");
          elem.setAttribute( 'type', 'checkbox' );
          elem.setAttribute( 'name', 'domain' );
          elem.setAttribute( 'value', id );
          elem.setAttribute( 'id', 'c_' + id );
          // replacing elem.setAttribute( 'onClick', 'function()' );
          var method = 'checkChildren(\'' + id + '\', true );';
          eventAdder( elem, 'onclick', method );
          var parent = cLink.parentNode;
          parent.insertBefore( elem, cLink );
        }
      }
    }
  } else {
    var aInput = document.getElementsByTagName( 'input' );
    var max = aInput.length;
    for( i = max-1; i >= 0; i-- )
    {
      var currInput = aInput[i];
      if( currInput.id.indexOf( 'c_' ) == 0 )
      {
        currInput.parentNode.removeChild( currInput );
      }
    }
  }
}

function checkChildren( id, b_isFirts )
{
  if( id && this.normalizedTree[ id ] )
  {
    var treeFrg = this.normalizedTree[ id ];
    var oCheckbox = document.getElementById( 'c_' + id );
    if( oCheckbox )
    {
      if( b_isFirts )
      {
        this.checkBoxState = oCheckbox.checked;
      } else {
        oCheckbox.checked = this.checkBoxState;
      }

      if( treeFrg.isParent )
      {
        var children = treeFrg.children.split( ',' );
        for( var i = 0; i<children.length; i++ )
        {
          checkChildren( children[i], false );
        }
      }
    }
  } else {
    // debug( '[checkChildren] nincs ilyen id?', id );
  }
}

/* workaround by Gordon Craig and Adam Hardy
 | http://www.faqts.com/knowledge_base/view.phtml/aid/9592
 | usage:
 | eventAdder( objHTML, "onclick", "dunebuggy()" )
 o ----------------------------------------------------*/
function eventAdder(objAttrib,handler,addFunction){
     
   if ((!document.all)&&(document.getElementById)){
       objAttrib.setAttribute(handler,addFunction);
   }    
   //workaround for IE 5.x
   if ((document.all)&&(document.getElementById)){
       objAttrib[handler]=new Function(addFunction);
   }
}
