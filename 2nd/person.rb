require_relative "consoleInput"

class Person
  include ConsoleInput
  include Validation

  attr_reader :first_name, :last_name, :inn, :birth_date

  def initialize(first_name, last_name, inn, birth_date)
    set_first_name(first_name)
    set_last_name(last_name)
    set_inn(inn)
    set_birth_date(birth_date)
  end

  def first_name=(new_first_name)
    set_first_name(new_first_name)
  end

  def last_name=(new_last_name)
    set_last_name(new_last_name)
  end

  def inn=(new_inn)
    set_inn(new_inn)
  end

  def birth_date=(new_birth_date)
    set_birth_date(new_birth_date)
  end

  private

  def set_first_name(value)
    if valid_name?(value)
      @first_name = value
    else
      puts "Invalid first name"
      @first_name = get_name_input()
    end
  end

  def set_last_name(value)
    if valid_name?(value)
      @last_name = value
    else
      puts "Invalid last name"
      @last_name = get_string_input()
    end
  end

  def set_inn(value)
    if valid_inn?(value)
      @inn = value
    else
      puts "Invalid inn"
      @inn = get_inn_input()
    end
  end

  def set_birth_date(value)
    if valid_date_format?(value)
      value = Date.parse(value)
      if after_date?(value)
        @birth_date = value
      else
        puts "Wrong birth date"
        @birth_date = get_date_input()
      end
    else
      puts "Wrong date format"
      @birth_date = get_date_input()
    end
  end
end

# person = Person.new("Ilusha-Aleksev", "Popovich", "AZ0123456789", "2024-11-12")
# puts = person.birth_date
# puts person.first_name
# puts person.last_name
# puts person.inn
# person.first_name = "automat"
# puts person.first_name
