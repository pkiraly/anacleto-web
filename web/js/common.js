  var LN = "\n";
  
  /* browser detection */
  var O = false;
  var IE = false;
  var F = false;
  var N = false;
  
  if( parseInt( navigator.appVersion ) >= 4 )
  {
    if ( navigator.appVersion.indexOf("MSIE") > 0 ) 
    {
      if( navigator.userAgent.indexOf("Opera") <= -1 )
      {
        IE = true;
      } else {
        O = true;
      }
    } else {
      if ( navigator.userAgent.indexOf("Opera") > -1 ) N = true;
      if ( window.opera ) O = true;
      if ( navigator.userAgent.indexOf("Netscape") > -1 ) N = true;
      if ( navigator.userAgent.indexOf("Firefox") > -1 ) F = true;
    }
  }
