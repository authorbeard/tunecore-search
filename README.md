# README

This is a simple Rails app to return a list of songs matching a keyword search. 

##Installation
* This uses Rails 5 and Bootstrap 4 with standard-issue jQuery. 
* It also has a number of seeds set up, though these don't look much like music names because they use Faker::Commerce product names. Try searching for "Cotton" or "Copper". I found this amusing for some reason.
*Fork/clone then bundle install and you should be good to go.
*rake db:seed will set up the database for you if you want to test-drive it. 
*For proper testing, just type "rspec" and it'll fire off. It will probably take awhile.  

##Things you can do: 
*Search in every table (Song, Artist or Album) and get a list of songs where one of those properties matches. 
..-For example, a default search for "dream" could return a song called "Dream River", all of the songs on the album "Siamese Dream", and then, finally, all of the songs by a band called "The Dreamers", if all of that was in the database.
..-As you can see, the results are ordered to place songs with matching titles first, then songs with matching album titles, then songs where the artist name matches the query term. 
*You can search multiple terms. These are comma-separated.
*You can also include only a subset of the tables. Clicking on "Custom" reveals these options. It works much the same as above, only it only looks for matches in the "name" column of the selected categories/tables. 
*Finally, you can also narrow you search to specific albums or artists. Say you know Busta Rhymes had a lot to say about the rawness of things and his role in ensuring adequate levels thereof, but you can't remember exactly what he said about that. You'd start by entering "raw" in the search box. Then you'd click "Custom", select "Artist", type "Busta Rhymes"in the search box, and away you go. 


