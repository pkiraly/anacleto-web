// var top = window.top;

function dummy( arg )
{
  alert( "I'm the dummy function! (" + arg + ")" );
  return false;
}

function showContentHead()
{
  if( redrawContentHead && isContentHeadVisible == false )
  {
    var contentFrameset = top.document.getElementById( 'contentFrameset' );
    if( contentFrameset ){
      contentFrameset.rows = '22,*';
    } else {
      var oFrameset = top.document.getElementById( 'contentHead' ).parentNode;
      oFrameset.rows = '20,20,*';
    }
    isContentHeadVisible = true;
  }
}

function hideContentHead()
{
  if( top.redrawContentHead && top.isContentHeadVisible == true )
  {
    var contentFrameset = document.getElementById( 'contentFrameset' );
    if( contentFrameset ) {
      contentFrameset.rows = '0,*';
    } else {
      var oFrameset = top.document.getElementById( 'contentHead' ).parentNode;
      oFrameset.rows = '20,0,*';
    }
    isContentHeadVisible = false;
  }
}


