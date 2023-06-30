#Create module Validation with methods
# valid_name?(string ) (valid name example Maria-Anna, max length is 40), 
# valid_inn?(string) (valid inn example: AZ1234543456), 
# after_date?(date) (is date may be date of birth)

require 'date'

module Validation
    def self.valid_name?(str)
        return false if str.nil? || str.empty? || str.length > 40

        words = str.split("-")
        return false unless words.all? { |word| word == word.capitalize && word.match?(/^[A-ZА-ЩЬЮЯҐЄІЇ]{1}[a-zа-щьюяґєії]*$/)}
        return false if words.size <= 1 && str.include?("-")
        
        true
    end

    def self.valid_inn?(str)
        str.match?(/[A-Z]{2}\d{10}$/)
    end

    def self.after_date?(date)
        date <= Date.today ? true : false
    end
end

text = "Legalize-Nuclear-Bombsssssssssssssssssss"
puts text.length
puts Validation.valid_name?("AnnA")
puts Validation.valid_inn?("AZ0123456789")
puts Validation.after_date?(Date.today.prev_day)
