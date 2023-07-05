require "test/unit"
require "./TestUnitsPractice/personTest"
require "date"
require "./2nd/person"
class PersonTest < Test::Unit::TestCase

  def setup 
    @person = Person.new("Baron", "Toy", "AZ0123456789", Date.today.prev_day)
  end

  def test_valid_first_name
    expected = "John-Bick"
    @person.first_name = expected
    actual = @person.first_name
    assert_equal(expected, actual, "Name #{expected} is valid name")
  end

  def test_invalid_first_name
    expected = "John-"
    assert_raise { @person.first_name = expected }
  end

end
