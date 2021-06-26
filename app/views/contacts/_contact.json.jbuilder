json.extract! contact, :id, :name, :dob, :phone, :address, :credit_card, :franchise, :email, :reference, :created_at, :updated_at
json.url contact_url(contact, format: :json)
