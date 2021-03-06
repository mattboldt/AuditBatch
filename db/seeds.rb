# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by(username: 'mattboldt', email: 'me@mattboldt.com')
Post.create(user: user, title: 'Post title', status: :pending)


5000.times do |i|
  Post.create(user: user, title: 'Post title' + i.to_s, status: :pending)
end
