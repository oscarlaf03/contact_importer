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

      it "with an invalid credit_card" do
        contact = build(:contact, credit_card: '123 123 123 12 3123  123 123')
        contact.valid?
        assert contact.errors.details.keys.include?(:credit_card)
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

    context "Should only persist valid phone phone formats"do

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

    context "Should identify credit_card franchise information" do

      it "Should identify 371449635398431 as American Express" do
        contact = create(:contact, credit_card: '371449635398431')
        expect(contact.franchise).to eq('amex')
      end

      it "Should identify 30569309025904 as Diners Club" do
        contact = create(:contact, credit_card: '30569309025904')
        expect(contact.franchise).to eq('diners')
      end

      it "Should identify 6011111111111117 as Discover" do
        contact = create(:contact, credit_card: '6011111111111117')
        expect(contact.franchise).to eq('discover')
      end

      it "Should identify 3530111333300000 as JCB" do
        contact = create(:contact, credit_card: '3530111333300000')
        expect(contact.franchise).to eq('jcb')
      end

      it "Should identify 5555555555554444 as MasterCard" do
        contact = create(:contact, credit_card: '5555555555554444')
        expect(contact.franchise).to eq('mastercard')
      end

      it "Should identify 4111111111111111 as Visa" do
        contact = create(:contact, credit_card: '4111111111111111')
        expect(contact.franchise).to eq('visa')
      end

    end

    context "Should persist card last 4 digits" do

      it "Should save 8431 from card number 371449635398431 " do
        contact = create(:contact, credit_card: '371449635398431')
        expect(contact.card_digits).to eq('8431')
      end

      it "Should save 5904 from card number 30569309025904 " do
        contact = create(:contact, credit_card: '30569309025904')
        expect(contact.card_digits).to eq('5904')
      end

    end

    context "Should persist card length info" do

      it "Should save 14 from card length of 30569309025904 " do
        contact = create(:contact, credit_card: '30569309025904')
        expect(contact.card_length).to eq(14)
      end

      it "Should save 15 from card length of 371449635398431 " do
        contact = create(:contact, credit_card: '371449635398431')
        expect(contact.card_length).to eq(15)
      end

      it "Should save 16 from card length of 4111111111111111 " do
        contact = create(:contact, credit_card: '4111111111111111')
        expect(contact.card_length).to eq(16)
      end

    end

    context "Should save card as ecnrypted string" do

      it "Should encrypt 30569309025904 " do
        contact = create(:contact, credit_card: '30569309025904')
        expect(contact.credit_card).not_to eq('30569309025904')
      end

      it "Should encrypt 371449635398431 " do
        contact = create(:contact, credit_card: '371449635398431')
        expect(contact.credit_card).not_to eq('371449635398431')

      end

      it "Should encrypt 4111111111111111 " do
        contact = create(:contact, credit_card: '4111111111111111')
        expect(contact.credit_card).not_to eq('4111111111111111')
      end

    end

    context "Repeated contact emails per user" do
      let(:user_one){ create(:user)}
      let(:user_one_contact){ create(:contact,user: user_one )}
      let(:user_two){ create(:user)}
      let(:user_two_contact){ create(:contact,user: user_two )}

      it "Should not accept repeated email per same user" do
        new_contact = build(:contact, user: user_one, email:  user_one_contact.email)
        new_contact.valid?
        assert new_contact.errors.keys.include?(:email)
      end

      it "Should accept repeated email on another user" do
        new_contact = create(:contact, user: user_one, email:  user_two_contact.email)
        assert new_contact.persisted?
        assert Contact.where(email: user_two_contact.email).size == 2
      end

    end

  end
end
