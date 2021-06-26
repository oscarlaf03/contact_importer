
# My credit card contact importer
Simple app allows signed in users to import contacts from a correcly formatted CSV file

## How to run?
From the file folder:
  *  `rails db:create`
  *  `rails db:seed`

## Test user (after running seed)

email: test@test.com
password: 123123

## Run all the Contacts specs

```
bundle exec rspec spec/models/contact_spec.rb
```


## Test data
commited on this repo as `test_import_card_data.csv`

## Features

  *  [X] Users can registrate with an email and password
  *  [X] Users can bulk import contacts from a CSV file
  *  [ ] Users can map CSV colums to contact model attributes, at the moment the CSV must have column names matching the Model attributes
  *  [X] Validates presence of all contact fields: credit_card, name, Date Of Birth, phone, address, credit_card, franchise, email
  * [X] Validates that name cannot have any special character except for "-"
  * [ ] Validates format of Date of Birth
  * [X] Ignores phone numbersn that are not in the format of either "(+00) 000 000 00 00 00" or "(+00) 000-000-00-00" whenever a phone misses that format it is saved as nil instead
  * [X] Validates address is present
  * [X] Validates credit card is a numeric input complian to the Luhn algorythm
  * [X] Infers the card brand from a valid credit_card number and stores it as "franchise"
  * [X] Stores only the last 4 digits of the credit card
  * [X] One-way encryption of the credit card number, new encryption key generated each time, we never store the key so we lost that information
  * [X] User can see imported contacts
  * [ ] Missed contacts imports are stored  as errors
  * [ ] A Status is kept for the importinng porcessing

  Bonus:
  * [ ] Upload processed files to S3
  * [ ] Process imports on the background
