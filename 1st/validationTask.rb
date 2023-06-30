#Create module Validation with methods
# valid_name?(string ) (valid name example Maria-Anna, max length is 40), 
# valid_inn?(string) (valid inn example: AZ1234543456), 
# after_date?(date) (is date may be date of birth)

require 'date'

module Validation

    MAX_NAME_LENGTH = 40;
    NAME_REGEX = /^[A-ZА-ЩЬЮЯҐЄІЇ]{1}[a-zа-щьюяґєії]*$/
    INN_REGEX = /\A[A-Z]{2}\d{10}\z/

    def valid_name?(str)
        return false if str.nil? || str.empty? || str.length > MAX_NAME_LENGTH

        words = str.split("-")
        return false unless words.all? { |word| word == word.capitalize && word.match?(NAME_REGEX)}
        return false if words.size <= 1 && str.include?("-")
        
        true
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

puts Object.extend(Validation).valid_name?("Anna-Maria-Ірина")
puts Object.extend(Validation).valid_inn?("AZ0123456789")
puts Object.extend(Validation).after_date?(Date.today.prev_day)
