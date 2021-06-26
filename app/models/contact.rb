class Contact < ApplicationRecord
  belongs_to :user
  validates :email, presence: true, email: true, uniqueness: { scope: :user_id }
  validates :name, presence: true, name: true
  validates :address , presence: true
  validates :phone, presence: true
  validates :credit_card, presence: true, credit_card: true, on: [:create, :update]
  validates :dob, presence: true
  after_validation :set_card_info,  if: :card_valid?
  before_save :ignore_phone, if: :invalid_phone_format?
  before_save :encrypt_credit_card_forever, if: :card_valid?

  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  def self.my_import(file,user_id)
    contacts = []

    CSV.foreach(file.path, headers: true) do  |row|
      data = {**row.to_h.deep_symbolize_keys, user_id: user_id}
      new_contact = Contact.new(data)
      contacts << new_contact if new_contact.valid?
    end
    contacts.each do |contact|
      contact.run_callbacks(:save) { false }
      contact.run_callbacks(:create) { false }
    end
    Contact.import contacts, recursive: true, validate: false

  end

  def display_card
    s = "*" * (self.card_length - 4)
    s + self.card_digits
  end



  private
  
  def invalid_phone_format?
    return true if not self.phone.kind_of?(String)
    return true if not [22,19].include?(self.phone.length)
    return true if /^\(\+\d{2}\)\s{1}/.match(self.phone).nil?
    digits = self.phone[6, self.phone.length]
    format_1_valid = /^\d{3}\s{1}\d{3}\s{1}\d{2}\s{1}\d{2}\s{1}\d{2}$/.match(digits).present?
    format_2_valid = /^\d{3}\-{1}\d{3}\-{1}\d{2}\-{1}\d{2}$/.match(digits).present?
    not ( format_1_valid or format_2_valid)
  end

  def ignore_phone
    self.phone = nil
  end

  def set_franchise
    detector = CreditCardValidations::Detector.new(self.credit_card)
    self.franchise = detector.brand.to_s
  end

  def set_digits
    self.card_digits  = self.credit_card[-4,self.credit_card.length]
  end

  def set_card_length
    self.card_length = self.credit_card.length
  end

  def set_card_info
    set_franchise
    set_digits
    set_card_length
  end

  def encrypt_credit_card_forever
    aes = OpenSSL::Cipher.new("AES-256-CBC" )
    aes.encrypt
    aes.key = aes.random_key
    encrypted_card = Base64.encode64(aes.update(self.credit_card) + aes.final).gsub("\n", "")
    self.credit_card = encrypted_card
  end


  def card_valid?
    not self.errors.keys.include?(:credit_card)
  end

  # def card_present?
  #   credit_card.kind_of?(String)
  # end

end
