class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{3,})\z/i
      record.errors.add attribute, (options[:message] || "Must be a valid email address")
    end
  end
end
