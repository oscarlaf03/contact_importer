def email_name(full_name)
  random_separator = [ "-", "_",".",""]
  random_digits = Random.rand(99999).to_s
  full_name = full_name.gsub('.',"")
  full_name = full_name.gsub(" ",random_separator.sample)
  (full_name + random_separator.sample + random_digits).downcase
end

FactoryBot.define do
  factory :contact do
    name { Faker::Name.name    }
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { "MyString" }
    address { "MyString" }
    credit_card { "MyString" }
    franchise { "MyString" }
    email { Faker::Internet.safe_email(name: email_name(self.name)) }
    user
  end
end
