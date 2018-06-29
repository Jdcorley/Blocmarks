require 'faker'
require 'securerandom'

User.create!(email: 'jdcorley@gmail.com', 
            password: 'helloworld', 
            confirmed_at: Time.now 
            )
 5.times do 
  User.create!(email: Faker::Internet.email,
              password: SecureRandom.hex,
              confirmed_at: Time.now 
              )
end
users = User.all 

10.times do 
  topic = Topic.create!(title: Faker::ProgrammingLanguage.name,
                        user: users.sample 
                       )
end

topics = Topic.all 

20.times do 
  bookmark = Bookmark.create!(url: 'https://github.com/stympy/faker',
                              topic: topics.sample,
                              user: users.sample 
                              )
end

bookmarks = Bookmark.all 

puts "#{users.count} created"
puts "#{topics.count} created."
puts "#{bookmarks.count} created."