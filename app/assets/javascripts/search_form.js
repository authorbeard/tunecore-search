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
    processResponse(data)
  }, "json");

}


function processResponse(resp){
  $('#results-display div.result').each(function(){
    $(this).html("");
  });

  $('#search-results').show();

  
  if ($.isEmptyObject(resp)){
    return $('#search-results').html('<h1>Sorry, couldn\'t find anything.</h1>');
  }
  resp.forEach(function(el){
    $('#song-title div').append('<p>' + el.name + '</p>');
    $('#album-title div').append('<p>' + el.album['name'] + '</p>');
    $('#artist-name div').append('<p>' + el.artist['name'] + '</p>');
    // debugger;


  })
}