class NameValidator < ActiveModel::EachValidator
  def validate_each(record,attribute, value)
    if value =~ /[!@#$%&*()\[\]{}=+¨^~\/Çç><,;:?¡¿\\"']+/
      record.errors.add attribute, (options[:message] || 'Name cannot have any special characters')
    end

  end

end
