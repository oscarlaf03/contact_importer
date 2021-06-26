class Contact < ApplicationRecord
  belongs_to :user
  validates :email, presence: true, email: true
  validates :address , presence: true
  validates :phone, presence: true
  validates :credit_card, presence: true
  validates :dob, presence: true
  before_save :ignore_phone, if: :invalid_phone_format?

  private
  def invalid_phone_format?
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

end
