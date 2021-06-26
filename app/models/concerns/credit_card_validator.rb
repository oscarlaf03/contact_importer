class CreditCardValidator < ActiveModel::EachValidator
  def validate_each(record,attribute, value)
    unless CreditCardValidations::Luhn.valid?(value)
      record.errors.add attribute, (options[:message] || "Must be a valid credit card number ")
    end

    unless value =~ /^\d+$/
      record.errors.add attribute, (options[:message] || "Must be a valid  numric credit card number ")
    end
  end
end
