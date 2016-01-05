var oForm = document.forms[0];

function checkBoxClicked( oCheck ) {
  if(parent.hasCheckBoxClickedMethod) {
    if(oCheck.checked === true) {
      parent.addElement(oCheck.value);
    } else {
      parent.removeElement(oCheck.value);
    }
  }
}

function getLastTerm() {
  var el = document.forms[0].elements;
  var offset;
  var len = el.length-1;
  for (i = len; i >= 0; i--) {
    if (el[i].name == 'selectedTerms'){
      offset = el[i].value;
      break;
    }
  }
  var oContainer = parent.document.getElementById('firstLettersContainer');
  if(oContainer && offset) {
    oContainer.innerHTML = offset;
  }
  document.forms[0].elements['offset'].value = offset;	
}

function getFirstTerm(){
  var el = document.forms[0].elements;
  var value, offset;
  for (i = 0; i < el.length; i++) {
    if (el[i].name == 'selectedTerms'){
      offset = el[i].value;
      break;
	}
  }
  var oContainer = parent.document.getElementById('firstLettersContainer');
  if(oContainer && offset) {
    oContainer.innerHTML = offset;
  }
  document.forms[0].elements['offset'].value = offset;
}

function highlight() {
  var sPattern = document.forms[0].elements['pattern'].value;
  if(!sPattern.match(/[\*\?]/)) {
    var el = document.forms[0].elements;
    var rPattern = new RegExp( '^' + sPattern );
    for (i = 0; i < el.length; i++) {
      if (el[i].name == 'selectedTerms' && rPattern.exec(el[i].value)){
        el[i].parentNode.parentNode.style.backgroundColor = '#ccc';
        break;
      }
    }
  }
}
