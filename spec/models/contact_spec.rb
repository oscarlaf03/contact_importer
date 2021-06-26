require 'rails_helper'

RSpec.describe Contact, type: :model do
  context "Validating attributes" do
    context "Should not be valid" do
      it "with invalid email address" do
        contact = build(:contact, email: 'invalid___email')
        contact.valid?
        assert contact.errors.details.keys.include?(:email)
      end

      it "with a nil email address" do
        contact = build(:contact, email: nil)
        contact.valid?
        assert contact.errors.details.keys.include?(:email)
      end
      it "with a blank email address" do
        contact = build(:contact, email: '')
        contact.valid?
        assert contact.errors.details.keys.include?(:email)
      end
      it "with a nil address" do
        contact = build(:contact, address: nil)
        contact.valid?
        assert contact.errors.details.keys.include?(:address)
      end
      it "with a blank address" do
        contact = build(:contact, address: "")
        contact.valid?
        assert contact.errors.details.keys.include?(:address)
      end
      it "with a nil phone" do
        contact = build(:contact, phone: nil)
        contact.valid?
        assert contact.errors.details.keys.include?(:phone)
      end
      it "with a blank phone" do
        contact = build(:contact, phone: "")
        contact.valid?
        assert contact.errors.details.keys.include?(:phone)
      end
      it "with a nil Date of Birth" do
        contact = build(:contact, dob: nil)
        contact.valid?
        assert contact.errors.details.keys.include?(:dob)
      end
      it "with a blank Date of Birth" do
        contact = build(:contact, dob: "")
        contact.valid?
        assert contact.errors.details.keys.include?(:dob)
      end

      it "with a nil credit_card" do
        contact = build(:contact, credit_card: nil)
        contact.valid?
        assert contact.errors.details.keys.include?(:credit_card)
      end
      it "with a blank credit_card" do
        contact = build(:contact, credit_card: "")
        contact.valid?
        assert contact.errors.details.keys.include?(:credit_card)
      end
    end

    context "Should ignore invalid phone formats" do
      it "Ignores invalid phone format  \"123 123\"" do
        contact = create(:contact, phone:'123 123')
        assert contact.persisted?
        assert contact.phone.nil?
      end

      it "Ignores invalid phone format \"(+00) 000 000 00 00 00 000\" " do
        contact = create(:contact, phone:'(+00) 000 000 00 00 00 000')
        assert contact.persisted?
        assert contact.phone.nil?
      end

      it "Ignores invalid phone format \"(+00) 000-000-00\" " do
        contact = create(:contact, phone:'(+00) 0000-000-00')
        assert contact.persisted?
        assert contact.phone.nil?
      end

      it "Ignores invalid phone format \"(++42) 123-321-21-12\" " do
        contact = create(:contact, phone:'(++42) 123-321-21-12')
        assert contact.persisted?
        assert contact.phone.nil?
      end

      it "Ignores invalid phone format \"(-42) 123-321-21-12\" " do
        contact = create(:contact, phone:'(-42) 123-321-21-12')
        assert contact.persisted?
        assert contact.phone.nil?
      end

    end

    context "Should persist valid phone phone formats"do

      it "Persists valid phone format \"(+55) 119 236 42 16 75\"" do
        contact = create(:contact, phone:'(+55) 119 236 42 16 75')
        assert contact.persisted?
        assert contact.phone.present?
      end

      it "Persists valid phone format \"(+42) 123-321-21-12\"" do
        contact = create(:contact, phone:'(+42) 123-321-21-12')
        assert contact.persisted?
        assert contact.phone.present?
      end

    end
  end
end
