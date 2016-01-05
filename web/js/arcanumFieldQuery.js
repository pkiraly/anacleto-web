var oTreeFrame = window.parent.frames['navigationFrame'].frames['navigationContent'].frames['treeFrameset'].frames['tree'];

var hasCheckBoxClickedMethod = true;
var terms = new Array();
var aForm = document.forms[0];
var isDebugNotInUse = true;
var allowDebugConsole = true;
var LN = "\n";
var BR = '<br/>' + LN;
var formType = 'general';
	
var currentSearchForm = 'field_searchform';

function onclickHandler(fieldStateAtTyping, patternStateAtTyping ){
	
	var field   = document.forms['indexListForm'].elements['selectedField'].value;
	var pattern = document.forms['indexListForm'].elements['firstLetters'].value;
	
	if(patternStateAtTyping == pattern) {
		document.forms['indexListForm'].elements['selectedField'].value = field;
		if(! pattern
			|| typeof(pattern) == 'undefined'
			|| pattern == null
			|| pattern == '' )
		{
			var firstLetters = document.forms['indexListForm'].elements['firstLetters'].value;
			if( firstLetters != '' ) {
				pattern = firstLetters;
			} else {
				pattern = 'a';
			}
		}
		document.getElementById('selectedFieldNameContainer').innerHTML = field;
		//document.getElementById('firstLettersContainer').innerHTML = pattern;
	
		var location = "termListFragment.do" 
						+ "?pattern=" + pattern + "&selectedField=" + field;
		var currentLocation = frames['dynLoadFrame'].location.href;
		currentLocation = currentLocation.substr(currentLocation.indexOf("termListFragment.do"));
		if(location != currentLocation) {
			frames['dynLoadFrame'].location.href = location;
		}
	}
}

function showTermList(field, defaultPattern) {
	document.forms['indexListForm'].elements['selectedField'].value = field;
	var pattern = document.forms['indexListForm'].elements['firstLetters'].value;
	if(pattern == "" && typeof defaultPattern != "undefined")
		pattern = defaultPattern;
	
	onclickHandler( field, pattern );
}

function onType() {
	var field   = document.forms['indexListForm'].elements['selectedField'].value;
	var pattern = document.forms['indexListForm'].elements['firstLetters'].value;
	
	// onclickHandler( field, pattern );
	setTimeout(function(){onclickHandler( field, pattern );}, 1000);
}

function addElement( text ) {
	// text-pattern: fieldname:value -> value
	text = text.substring( text.indexOf( ':' ) + 1, text.length );
	// don't insert twice
	removeElement( text, true );
	
	var sFieldName = document.forms['indexListForm'].elements['selectedField'].value;
	if( ! terms[sFieldName] ) {
		terms[sFieldName] = new Array();
		terms[sFieldName][0] = text;
	} else {
		terms[sFieldName][ terms[sFieldName].length ] = text;
	}
	
	if(currentSearchForm == 'proximity_searchform') {
		var oField = document.forms[currentSearchForm].elements['proximity'];
		oField.value = terms[sFieldName].join( ' ' );
	}
	else {
		var oField = document.forms[currentSearchForm].elements[sFieldName];
		oField.value = terms[sFieldName].join( ', ' );
	}
}

  function removeElement( text, signal )
  {
    // text-pattern: fieldname:value -> value
    if( typeof( signal ) == 'undefined' )
    {
      text = text.substring( text.indexOf( ':' ) + 1, text.length );
    }
    var sFieldName = document.forms['indexListForm'].elements['selectedField'].value;
    if( typeof( terms[sFieldName] ) != 'undefined' 
			&& terms[sFieldName].length > 0 )
    {
      var newTerms = new Array();
      for( var i = 0; i < terms[sFieldName].length; i++ )
      {
        if( terms[sFieldName][i] != text )
        {
          newTerms[ newTerms.length ] = terms[sFieldName][i];
        }
      }
      terms[sFieldName] = newTerms;
			if(currentSearchForm == 'proximity_searchform') {
				var oField = document.forms[currentSearchForm].elements['proximity'];
				oField.value = terms[sFieldName].join( ' ' );
			}
			else {
	      var oField = document.forms[currentSearchForm].elements[sFieldName];
  	    oField.value = terms[sFieldName].join( ', ' );
			}
    }
  }
  
  function setDomain( shelfName )
  {
    var aForm = document.forms[0];
    var aShelves = aForm.elements['selectedShelves'];
    for( var i=0; i<aShelves.length; i++ )
    {
      if( aShelves[i].value == shelfName )
      {
        if( aShelves[i].checked == true)
        {
          aShelves[i].checked = false;
        } else {
          aShelves[i].checked = true;
        }
      }
    }
    // setDomain();
    // launcher();
  }

  function submitQuery(aForm) {
    // var aForm = document.forms['field_serachform'];
    var sQuery;
    var i;
    debug( 'reset()', '' );

    if( formType == 'proxy' ) {
      if(  aForm.elements['proximity'] 
        && aForm.elements['proximity'].value.length > 0
        && aForm.elements['proximity'].value.match( /[\w\d]/i ) ){
        if( aForm.elements['proximity'].value.length == 0 ) {
          alert( alertNoproxDistance );
          return false;
        }
        sQuery = '"' + aForm.elements['proximity'].value + '"~' + aForm.elements['proxDistance'].value;
      }
    }
    // else: field query
    else {
      var checkCounter = 0;
      while ( !aForm.elements['innerOperator'][checkCounter].checked ) checkCounter++;

      var innerOperator = aForm.elements['innerOperator'][checkCounter].value;
      var interOperator = ( aForm.elements['interOperator'][0].checked ) ? ' AND ' : ' OR ';
      var similOperator = ( aForm.elements['similarities'].checked ) ? '~' : '';
      var similPercent  = aForm.elements['similaritiesPercent'].options[ aForm.elements['similaritiesPercent'].selectedIndex ].value;
      if( similOperator != '' )
        similOperator += similPercent;
      var multipleTerm;
      
      var fields = new Array( 'creator', 'title', 'picture', 
				'origPageNr', 'pagenumber', 'content' );
      var aQuery = new Array();
      for( i = 0; i < fields.length; i++ ) {
        var fieldName    = fields[i];
				if(aForm.elements[fieldName] == null) {
					continue;
				}
        var fieldContent = aForm.elements[fieldName].value;
        if( fieldContent != '' ) {
          fieldContent = fieldContent.replace( /(^\s+|\s+$)/g, '' );
          fieldContent = fieldContent.replace( /\s+/g, ' ' );
          // if( isExactMatch == true )
          // {
          //  fieldContent = '"' + fieldContent + '"';
          //} else {
            multipleTerm = ( fieldContent.match( /,? / ) ) ? true : false;
            fieldContent = fieldContent.replace( /(^\s+|\s+$)/g, '' );
            fieldContent = fieldContent.replace( /\s+/g, ' ' );
            if( innerOperator == 'AND' || innerOperator == 'OR' || innerOperator == 'NOT' ) {
              var replacementString = similOperator + ' ' + innerOperator + ' ';
              
              if( fieldContent.match( /, / ) ) {
                fieldContent = fieldContent.replace( /, +/g, replacementString );
              }
              else if( fieldContent.match( / / ) 
                   && ! fieldContent.match( / AND / )
                   && ! fieldContent.match( / OR / ) 
                   && ! fieldContent.match( / NOT / ) ) {
                fieldContent = fieldContent.replace( / +/g, replacementString );
              }
              fieldContent += similOperator;
            }
            else if( multipleTerm ) {
              fieldContent = '"' + fieldContent + '"';
            }
            
            if( fieldName != 'content' ) {
              fieldContent = fieldName + ':(' + fieldContent + ')';
            }
            aQuery[ aQuery.length ] = fieldContent;
        }
      }

      if( aQuery.length == 0 ) {
        alert( alertNoinput );
        return false;
      }
      else if( aQuery.length > 1 ) {
        for( i = 0; i<aQuery.length; i++ ) {
          fieldContent = aQuery[i];
          multipleTerm = ( fieldContent.match( / (AND|OR|NOT) / ) ) ? true : false;
          if( multipleTerm ) {
            aQuery[i] = ' ( ' + fieldContent + ' ) ';
          }
        }
      }
      
      sQuery = aQuery.join( interOperator );
    }
    var s_domains = getDomainFromTree();
    if( s_domains != '' )
    {
      if( aQuery.length > 1 )
      {
        sQuery = '( ' + sQuery + ' )';
      }
      sQuery = sQuery + ' AND ' + s_domains;
    }
    
    aForm.elements['queryString'].value = sQuery;
    return this.isDebugNotInUse;
  }

  function getDomainFromTree()
  {
    if( ! oTreeFrame.document.forms['nodes'] )
      return '';
      
    var oForm = oTreeFrame.document.forms['nodes'];
    var aCheckedNodes = new Array();
    var i;
    for( i=0; i<oForm.length; i++ )
    {
      if( oForm[i].checked == true )
      {
        // value = id of the node
        aCheckedNodes[ aCheckedNodes.length ] = oForm[i].value;
      }
    }
    if( aCheckedNodes.length )
    {
      aCheckedNodes = oTreeFrame.removeRedundantChildren( aCheckedNodes );

      var aPaths = new Array();
      for( i=0; i<aCheckedNodes.length; i++ )
      {
        aPaths.push( oTreeFrame.buildPath( aCheckedNodes[i] ) );
      }
      return '( ' + aPaths.join( ' OR ' ) + ' ) ';
      
    } else {
      return '';
    }
  }
  
  function showCheckbox( b_flag )
  {
    oTreeFrame.showCheckbox( b_flag );
  }
  
  function init()
  {
    top.treeWidthDomainSelector = 1;
    reLoadTree();
    showCheckbox( true );
  }

  function onUnload_handler()
  {
    top.treeWidthDomainSelector = 0;
    showCheckbox( false );
  }

  function reLoadTree()
  {
    var oSelector = parent.frames['navigationFrame'].frames['navigationSelector'];
    oSelector.showPanel('treeFrameset');
  }

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
    this.isDebugNotInUse = false;
    oDebug.innerHTML += BR + '=== ' + title + ' ===' + BR;
    if( typeof text != "undefined" )
      oDebug.innerHTML += text.replace( /</g, '&lt;' ).replace( />/g, '&gt;' ).replace( /\n/g, BR );
  }
  return true;  
}

function selectRadio( formName, formValue )
{
  eval("document.forms[0]."+formName+"['"+formValue+"'].click();");
  return false;
}

function setFormType( formType ) {
  this.formType = formType;
}