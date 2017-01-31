# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times { Artist.create(name: Faker::Name.name)}
100.times {Album.create(name: Faker::Name.name)}
500.times {Song.create(name: Faker::Name.name)}

artists = Artist.all

@tot_albums=100
@tot_songs=500

artists.each_with_index{|artist, index| 
  
  @tot_albums > num_of_albums ? 

}

def num_of_albums
  num = rand(10)
  @tot_albums > num ? return num : return @tot_albums
end