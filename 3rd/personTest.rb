require "test/unit"
require "./2nd/person"

class PersonTest < Test::Unit::TestCase

  def setup
    @person = Person.new("Baron", "Toy", "AZ0123456789", Date.today.prev_day)
  end

  ['Anna-A', 'An', 'Anna', 'Anna-Maria', 'Каріна-Ірина'].each do |name|
    define_method("test_valid_first_name_#{name}") do
      expected = name
      @person.first_name = expected
      actual = @person.first_name
      assert_equal(expected, actual, "Name #{expected} is valid name")
    end
  end

  ['An-','-','aN','AnnA','-An','A-a','a-A','a-a', '', '123'].each do |name|
    define_method("test_invalid_first_name_#{name}") do
      assert_raise { @person.first_name = name }
    end
  end

  ['Anna-A', 'An', 'Anna', 'Anna-Maria', 'Каріна-Ірина'].each do |name|
    define_method("test_valid_last_name_#{name}") do
      expected = name
      @person.last_name = expected
      actual = @person.last_name
      assert_equal(expected, actual, "Name #{expected} is valid name")
    end
  end

  ['An-','-','aN','AnnA','-An','A-a','a-A','a-a', '', '123'].each do |name|
    define_method("test_invalid_last_name_#{name}") do
      assert_raise { @person.last_name = name }
    end
  end

  ['AZ0123456789', 'BY9876543210', 'CC6549873210', 'EF9874056321'].each do |inn|
    define_method("test_valid_inn_#{inn}") do
      expected = inn
      @person.inn = expected
      actual = @person.inn
      assert_equal(expected,actual, "INN #{inn} is valid INN")
    end
  end

  ['AZ1', 'AC12', 'AB123', 'HS123456','AZ123456879', 'HZ', '',
   'Hz1234567890', 'nM7894561230', '1H7894561230', 'H21234567890'].each do |inn|
    define_method("test_invalid_inn_#{inn}") do
      assert_raise {@person.inn = inn}
    end
  end

  ['1999-01-01', '2003-01-18', '2018-12-03', '1920-02-03'].each do |date|
    define_method("test_valid_date_#{date}") do
      expected = date
      @person.birth_date = expected
      expected = Date.parse(expected)
      actual = @person.birth_date
      assert_equal(expected, actual, "Date #{date} is valid date")
    end
  end

  ['2100-01-01', '2200-01-01', '2300-01-01', '',
   'a', '123', '01/12/2003', '01-01-2001'].each do |date|
    define_method("test_invalid_date_#{date}") do
      assert_raise(ArgumentError, "Invalid birth date: #{date}") do
        @person.birth_date = date
      end
    end
  end

end
