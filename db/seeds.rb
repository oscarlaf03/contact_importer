
first_user = User.create(email: 'test@test.com', password:'123123')
FactoryBot.create(:contact, email:'paco@gmail.com', user:first_user)
