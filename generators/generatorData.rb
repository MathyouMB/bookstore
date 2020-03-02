require 'faker'
=begin
book_names = File.new("./data/bookNames.txt", "w")

50.times do
    book_names.puts(Faker::Book.title)
end

book_names.close

book_publishers = File.new("./data/bookPublishers.txt", "w")

50.times do
    book_publishers.puts(Faker::Book.publisher)
end

book_publishers.close


book_genres = File.new("./data/bookGenres.txt", "w")

50.times do
    book_genres.puts(Faker::Book.genre)
end

book_genres.close

first_names = File.new("./data/firstNames.txt", "w")

20.times do
    first_names.puts(Faker::Name.first_name)
end

first_names.close

last_names = File.new("./data/lastNames.txt", "w")

20.times do
    last_names.puts(Faker::Name.last_name)
end

last_names.close


artist_names = File.new("./data/artistNames.txt", "w")

20.times do
    artist_names.puts(Faker::Artist.name)
end

artist_names.close
=end

usernames = File.new("./data/usernames.txt", "w")

20.times do
    usernames.puts(Faker::Internet.username(specifier: 5..8))
end

usernames.close

address = File.new("./data/addresses.txt", "w")

20.times do
    address.puts(Faker::Address.full_address)
end

address.close


passwords = File.new("./data/passwords.txt", "w")

20.times do
    passwords.puts(Faker::Internet.password(min_length: 10, max_length: 20))
end

passwords.close

prices = File.new("./data/prices.txt", "w")

50.times do
    prices.puts(Faker::Commerce.price(range: 0..10.0, as_string: true))
end

prices.close