   var LN = "\n";
   var BR = '<br/>' + LN;
   var color = '#2d598a';
   var sColor = 'white';
   var bgColor = '';
   var sBgColor = 'black';
   var noSelectionAlert = 'Select an item first by simple click on the title!';
   var docFramesetName = 'content';
   
   var exp = new Date();
   var oneYearFromNow = exp.getTime() + (365 * 24 * 60 * 60 * 1000);
   exp.setTime(oneYearFromNow);
   var expString = exp.toGMTString();
   
   function init()
   {
     this.bookmarks = new Array();
     var serializedBookmark;
     if( ( serializedBookmark = xGetCookie( 'bookmarks' ) ) && serializedBookmark.length > 0 )
     {
       unSerializeBookmark( serializedBookmark );
     } else {
       xSetCookie( 'bookmarks', serializeBookmark(), exp );
     }
     //xSetCookie( 'expires', expString );
     this.selectedID = '';
   }
   
   
   function serializeBookmark()
   {
     var serializedBookmark = '';
     for( var i=0; i<this.bookmarks.length; i += 1 )
     {
       if( serializedBookmark.length > 0 ){ serializedBookmark += ';'; }
       serializedBookmark += this.bookmarks[i][0] + ';' + this.bookmarks[i][1];
     }
     return serializedBookmark;
   }

   function unSerializeBookmark( serializedBookmark )
   {
     serializedBookmark = unescape( serializedBookmark );
     var bookmarkArray = serializedBookmark.split( ';' );
     
     for( var i=0; i<bookmarkArray.length; i += 2 )
     {
       addBookmark( bookmarkArray[i], bookmarkArray[i+1], true );
     }
     refreshList();
   }

   function addBookmark( name, url, stopSignal )
   {
     this.bookmarks[ this.bookmarks.length ] = new Array( name, url );
     if( ! stopSignal )
     {
       xSetCookie( 'bookmarks', serializeBookmark(), exp );
       refreshList();
     }
   }

   function renameBookmark()
   {
     if( this.selectedID !== '' )
     {
       var id = parseInt( this.selectedID.substr( 1 ) );
       if( this.bookmarks[ id ] )
       {
         this.bookmarks[ id ][ 0 ] = document.forms[0].textInput.value;
         document.forms[0].textInput.blur();
       }
       deSelectBookmark();
       xSetCookie( 'bookmarks', serializeBookmark(), exp );
     }
   }

   function promptRenameBookmark()
   {
     if( this.selectedID !== '' )
     {
       var id = parseInt( this.selectedID.substr( 1 ) );
       if( this.bookmarks[ id ] )
       {
         var panel = xGetElementById('selectionFormLayer');
			if (panel)
			{
			    var x = xPageX( this.selectedID ); // + xWidth( this.selectedID ) + 20;
			    var y = xPageY( this.selectedID );
			    xMoveTo(panel, x, y);
			    xShow(panel);
			    document.forms[0].textInput.value = this.bookmarks[ id ][ 0 ];
			    document.forms[0].textInput.focus();
			}
       }
     } else {
       alert( noSelectionAlert );
     }
   }

   function deleteBookmark()
   {
     if( this.selectedID !== '' )
     {
       var id = parseInt( this.selectedID.substr( 1 ) );
       if( this.bookmarks[ id ] )
       {
         var prev = this.bookmarks.slice( 0, id );
         var post = this.bookmarks.slice( id+1 );
         this.bookmarks = prev.concat( post );
       }
       this.selectedID = '';
       xSetCookie( 'bookmarks', serializeBookmark(), exp );
     } else {
       alert( noSelectionAlert );
     }
   }
   
   function showBookmark()
   {
     var text = ''; //<form>
     for( var i=0; i<this.bookmarks.length; i+=1 )
     {
       // onclick="selectBookmark(\'s' + i + '\')"
       text += '<input type="radio" name="rs"'
             + ' value="sr' + i + '"'
             + ' onclick="selectBookmark(\'s' + i + '\')">'
             + '<a href="' + this.bookmarks[i][1] + '" target="' + docFramesetName + '" >' 
             + '<span id="s' + i + '" class="listElement">' 
             + this.bookmarks[i][0] 
             + '<\/span>' 
             + '<\/a>' 
             + BR;
     }
     //text += '</form>';
     return text;
   }

   function selectBookmark( sID )
   {
     if( this.selectedID == sID )
     {
       deSelectBookmark();
     } else {
       deSelectBookmark();
       xBackground( sID, sBgColor );
       xColor( sID, sColor );
       this.selectedID = sID;
     }
   }
   
   function syncronizeBookmark()
   {
     if( this.selectedID !== '' )
     {
       var id = parseInt( this.selectedID.substr( 1 ) );
       if( this.bookmarks[ id ] )
       {
         var url = this.bookmarks[ id ][ 1 ];
         top.frames[docFramesetName].location = url;
       }
     } else {
       alert( noSelectionAlert );
     }
   
   }

   function deSelectBookmark()
   {
     if( this.selectedID !== '' )
     {
       xBackground( this.selectedID, bgColor );
       xColor( this.selectedID, color );
     }
     this.selectedID = '';
   }
   
   function refreshList()
   {
     xInnerHtml( 'selectionList', showBookmark() );
   }
   
   function clearTextInput()
   {
     document.forms[0].textInput.value = "";
     xHide('selectionFormLayer');
     refreshList();
     return false;
   }
   
   function listBookmarks()
   {
     var text = "";
     for( var i = 0; i<this.bookmarks.length; i++ )
     {
       text += i + ') name=' + this.bookmarks[i][0] 
            + top.LN + ') url=' + this.bookmarks[i][1] + top.LN;
     }
     return text;
   }

   init();
