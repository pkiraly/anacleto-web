
function divteszt( caller )
{
  var divs = document.getElementsByTagName( 'div' );
  var i, attr;
  var text = '';
  var retVal = 0;
  for( i = 0; i<divs.length; i++ )
  {
    var id = divs[i].getAttribute( 'id' );
    if( divs[i].getAttribute( 'id' ) == "" 
     && divs[i].className != "kwic" )
    {
      retVal++;
      alert( caller + ':: we have a div without attributes! div[' + i + ']' );
    }
  }
  return retVal;
}

function getDOM()
{
  var text = '';
  var el = document.getElementById( 'root' );
  text += walker( el, 0 );
  var oDiv = document.getElementById( 'debug' );
  if( oDiv )
  {
    oDiv.innerHTML = text;
  } else {
    alert( text );
  }
}

function walker ( el, counter )
{
  var text = '';
  var i;
  var prefix = '';
  var nVal;
/*
  for( i=0; i<counter; i++ )
  {
    prefix += '&nbsp;';
  }
*/
  if( el.nodeType == 1 )
  {
    text += prefix + '&lt;' + el.nodeName;
    var attr = el.attributes;
    if( attr.length )
    {
      for( i = 0; i<attr.length; i++ )
      {
        if( attr[i].specified )
        {
          /*
          nVal = attr[i].nodeValue;
          if( nVal != 'window.top.redrawContentHead = false' )
          {
            if( nVal!=null && nVal.indexOf( 'http:') > -1 ) {
              nVal = nVal.replace( /http:\/\/localhost:8080\/arcanum\//g, '' );
            }
            
          }
          */
          text += ' ' + attr[i].nodeName + '="' + attr[i].nodeValue + '"'; 
        }
      }
    }
    text += '&gt;<br/>' + "\n";

    if( el.hasChildNodes() )
    {
      var children = el.childNodes;
      for( i = 0; i<children.length; i++ )
      {
        text += walker( children[i], counter++ );
      }
    }
    text += prefix + '&lt;/' + el.nodeName + '&gt;';
    if( el.nodeName == 'DIV' )
    {
      text += '&lt;!-- ' + el.getAttribute( 'id' ) + '--&gt;';
    }
    text += "<br/>\n";

  } else {
    text += prefix + el.nodeValue + "<br/>\n";
  }
  
  return text;
}