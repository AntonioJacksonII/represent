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
  var selected = document.querySelector('.search-value').value;
  window.location = "/comparisons/?bill=" + selected;
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
