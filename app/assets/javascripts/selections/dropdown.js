function selectOnClick(){
  var selected = document.getElementById("dropdownid").value;
  window.location = "/representatives/" + selected
}

function selectFromSearch(){
  var selectedSearch = document.getElementById("search_by_name").value;
  window.location = "/representatives/" + selectedSearch
}

$(function(){

  $(".dropdown-menu").on('click', 'li', function(){
    $(".topic:first-child").text($(this).text());
    $(".topic:first-child").val($(this).text());
 });

});

function sendParam(){
  var selec = document.querySelector('.search-value').value;
  var rep = document.querySelector('input[name="inlineDefaultRadiosExample"]:checked');
  if (Number.isInteger(parseInt(selec)) === true && rep != null ){
    var rep = document.querySelector('input[name="inlineDefaultRadiosExample"]:checked').value;
    window.location = "/comparisons/?bill=" + rep + selec;
  } else if (rep === null){
    document.querySelector('.error-message').innerHTML = "Please choose House or Senate";
  } else
  document.querySelector('.error-message').innerHTML = "Search must be numbers only"
}

// function sendMultiParams(){
//   var topic = document.querySelector('.topic').value;
//   var numOfBills= document.querySelector('.num-bills').value;
//   window.location = "/comparisons/?topic=" + topic + "&num=" + numOfBills;
// }
function sendMultiParams(){
  var topic = document.querySelector('.topic').value;
  window.location = "/comparisons/?topic=" + topic;
}

function switchSpan(){
  var rep = document.querySelector('input[name="inlineDefaultRadiosExample"]:checked').value;
  document.querySelector('#spanned-text').innerHTML = rep
}
