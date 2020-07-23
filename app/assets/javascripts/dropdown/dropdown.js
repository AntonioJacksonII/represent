$("#search_by_name").easyAutocomplete(options);
  function selectOnClick(){
    var selected = document.getElementById("dropdownid").value;
    window.location = "/representatives/" + selected
  }
