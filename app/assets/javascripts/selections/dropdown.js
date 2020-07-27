function selectOnClick(){
  var selected = document.getElementById("dropdownid").value;
  window.location = "/representatives/" + selected
}

function selectFromSearch(){
  var selectedSearch = document.getElementById("search_by_name").value;
  window.location = "/representatives/" + selectedSearch
}
