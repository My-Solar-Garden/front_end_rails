# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserGarden.destroy_all
Garden.destroy_all
User.destroy_all

user1 = User.create(email: 'user@gmail.com', provider: 'google', token: '1234', refresh_token: '5678', uid: '111')
user2 = User.create(email: 'communitygarden@gmail.com', provider: 'google', token: '2345', refresh_token: '6789', uid: '222')

user1.gardens << Garden.create(latitude: '39.75', longitude: '-104.996577', name: 'The Grove', description: 'Corner garden', private: true)
user2.gardens << Garden.create(latitude: '39.45', longitude: '-104.58', name: 'Cole Community Garden', description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.', private: false)
