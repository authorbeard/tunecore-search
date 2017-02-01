
10.times{ Artist.create(name: "The " + Faker::Commerce.product_name.pluralize) }
100.times{ Album.create(name: Faker::Commerce.product_name) }
500.times{ Song.create(name: Faker::Commerce.product_name) }

Artist.all.each{|artist|
  unclaimed_albums = Album.where(artist_id: nil)
byebug
  num_artist_albums = [rand(5..15), unclaimed_albums.count].min
  artist.albums << unclaimed_albums.take(num_artist_albums)
  artist.albums.each{|alb|
    unclaimed_songs = Song.where(album_id: nil)
    num_album_songs = [rand(1..10), unclaimed_songs.count].min
    alb.songs << unclaimed_songs.take(num_album_songs)
  }
  artist.save

}
  
