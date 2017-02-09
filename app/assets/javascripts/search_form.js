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
  event.preventDefault();
  params = $(this).serialize()
  var search = $.post('/search', params, function(data){
                  console.log(data)
                }, "json")
  search.done(function(response){
    debugger;
  })
}