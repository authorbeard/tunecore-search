function displaySearchOpts(){
  $('div.search-opts').each(function(i, el){
    $(this).show();
  })
}

function hideSearchOpts(){
  $('div.search-opts').each(function(i, el){
    $(this).hide();
  })
}


function clearInclusive(){
  $('div#inclusive-search input').each(function(i, el){
    $(this).prop("checked", false);
  })

}

function clearNarrowed(){
  $('div#narrowed-search input').each(function(i, el){
    $(this).prop("checked", false);
    $(this).val('');
  })
}


function tunecoreSearch(event){
debugger;
}