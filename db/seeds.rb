# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times{ Artist.create(name: Faker::Commerce.product_name) }
100.times{ Album.create(name: Faker::Commerce.product_name) }
500.times{ Song.create(name: Faker::Commerce.product_name) }

artists = Artist.all

@all_songs = Song.all.to_a
@all_albums = Album.all.to_a


@all_albums.each{|alb|
  
  if @all_songs.length == 0
    rand(10).times{ Song.create(name: Faker::Name.name)}
    @all_songs = Song.all.to_a
  end

  num_of_songs = [rand(1..10), @all_songs.length].min
# byebug
  album_songs = @all_songs.pop(num_of_songs)

  alb.songs << album_songs
  # alb.save
}

artists.each{|artist|
  num_of_albums = [rand(1..10), @all_albums.length].min
  artist_albums = @all_albums.pop(num_of_albums)
  artist.albums << artist_albums
  artist.save
}

  

