#Create module Validation with methods
# valid_name?(string ) (valid name example Maria-Anna, max length is 40),
# valid_inn?(string) (valid inn example: AZ1234543456),
# after_date?(date) (is date may be date of birth)

require "date"

module Validation
  MAX_NAME_LENGTH = 40
  # NAME_REGEX = /^[A-ZА-ЩЬЮЯҐЄІЇ]{1}[a-zа-щьюяґєії]*$/
  NAME_REGEX = /^(?=.{1,30}$)(\p{Lu}\p{Ll}*(-\p{Lu}\p{Ll}*)*)$/
  INN_REGEX = /\A[A-Z]{2}\d{10}\z/

  def valid_name?(str)
    str.match?(NAME_REGEX)
  end

  def valid_inn?(str)
    str.match?(INN_REGEX)
  end

  def after_date?(date)
    date <= Date.today
  end
end

# text = "Legalize-Nuclear-Bombsssssssssssssssssss"
# puts text.length

# puts Object.extend(Validation).valid_name?("Anna-Maria-Ірина")
# puts Object.extend(Validation).valid_inn?("AZ0123456789")
# puts Object.extend(Validation).after_date?(Date.today.prev_day)
