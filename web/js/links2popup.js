/**
* this script attach popup() function to every 'note' links of the page
* the popup() show a popup layer with the note's content
* a second click on the link will hide the popup
* a click on an other link will change the popup's content and move to new
* location
*/
var currentID;
var LN = "\n";

/** select the 'note' links and attach the popup function to the onclick event */
function doLink()
{
  var links,i;
  links = document.getElementsByTagName('a');
  for(i=0; i<links.length; i++)
  {
    if( links[i].target == "_new" ) {
      links[i].target = "_blank"
    }
    if( /note/.test( links[i].name ) ) {
      links[i].onclick = function(evt){ return popup( evt, this.href ); };
    }
  }
}

/** show, hide, move the popup and change its content */
function popup ( evt, href )
{
  var refID, links, i, text;
  var noteContainer = document.getElementById( 'noteContainer' );
  
  refID = href.substr( href.indexOf('#')+1 );
  
  /** hide the popup if this is the second click */
  if( currentID == refID )
  {
    noteContainer.style.visibility = 'hidden';
    currentID = '';
    return false;
  }
  
  /** get the note's content */
  links = document.getElementsByTagName('a');
  for(i=0; i<links.length; i++)
  {
    if( links[i].name && links[i].name == refID )
    {
      text = links[i].parentNode.innerHTML;
      break;
    }
  }
  text = '<div>' 
       + '<div style="'
       + ' margin: 0 0 3px 3px;'
       + ' float: right;'
       + '">'
       + '<a href="javascript:void(0)" onClick="hidePopup(); return false;"'
       + ' title="close">'
       + '<img src="icons/plus.gif" border="0"/></a>'
       + '</div>'
       + text 
       + '</div>';
  noteContainer.style.visibility = 'visible';
  noteContainer.innerHTML = text;

  /** move the popup to the current place */
  evt = ( evt ) ? evt : window.event;
  var coords = getPageEventCoords( evt );
  var space = 10;
  if( evt.clientY > ( noteContainer.offsetHeight + space ) ) // go up
  {
    noteContainer.style.top  = coords.top - ( noteContainer.offsetHeight + space );
  } else { // go down
    noteContainer.style.top  = coords.top + space;
  }

  if( ( getInsideWindowWidth() - evt.clientX ) > ( noteContainer.offsetWidth + space ) ) 
  {
    noteContainer.style.left = coords.left + space;
  } else {
    noteContainer.style.left = ( getInsideWindowWidth() - noteContainer.offsetWidth - 20 );
  }

  currentID = refID;
  return false;
}

function hidePopup()
{
  var noteContainer = document.getElementById( 'noteContainer' );
  noteContainer.style.visibility = 'hidden';
  currentID = '';
  return false;
}

/**
*  get window (frame) width
*/
function getInsideWindowWidth() {
    if (window.innerWidth) {
        return window.innerWidth;
    } else if ( document.body.parentElement.clientWidth ) {
        // measure the html element's clientWidth
        return document.body.parentElement.clientWidth;
    } else if ( document.body && document.body.clientWidth ) {
        return document.body.clientWidth;
    }
    return 0;
}

/**
*  get the coordinates of the mouse click
*/
function getPageEventCoords(evt) {
  var coords = {left:0, top:0};
  if (evt.pageX) {
    coords.left = evt.pageX;
    coords.top = evt.pageY;
  } else if (evt.clientX) {
    coords.left = evt.clientX + document.body.scrollLeft - document.body.clientLeft;
    coords.top  = evt.clientY + document.body.scrollTop - document.body.clientTop;
    // include html element space, if applicable
    if ( document.body.parentElement && document.body.parentElement.clientLeft )
    {
      var bodParent = document.body.parentElement;
      coords.left += bodParent.scrollLeft - bodParent.clientLeft;
      coords.top += bodParent.scrollTop - bodParent.clientTop;
    }
  }
  return coords;
}
