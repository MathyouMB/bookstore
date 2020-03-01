require 'faker'

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