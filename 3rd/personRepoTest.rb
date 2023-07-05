require "test/unit"
require "./2nd/person"
require "./2nd/personRepository"

class PersonRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = PersonRepository.new
    @person1 = Person.new("John", "Doe", "AZ0123456789", "1990-01-01")
    @person2 = Person.new("Jane", "Smith", "BY9876543210", "1985-05-05")
    @person_unexist = Person.new("Unexist", "Person", "AB0123456789", "2003-01-18")
    @repository.add_person(@person1)
    @repository.add_person(@person2)
  end

  def test_add_person
    person3 = Person.new("Alex", "Johnson", "AQ9876543210", "1995-07-10")
    @repository.add_person(person3)
    assert_equal(3, @repository.people.length)
    assert_includes(@repository.people, person3)
  end

  def test_add_existing_person
    duplicate_person = Person.new("John", "Doe", "AZ0123456789", "1990-01-01")
    assert_raise(PersonAlreadyExist) { @repository.add_person(duplicate_person) }
  end

  def test_add_invalid_person
    invalid_person = "Invalid Person"
    assert_raise(ArgumentError) { @repository.add_person(invalid_person) }
  end

  def test_edit_person_by_inn
    new_first_name = "Updated"
    new_last_name = "Name"
    new_birth_date = "2000-12-31"
    edited_inn = "AZ0123456789"
    new_person = Person.new(new_first_name, new_last_name, edited_inn, new_birth_date)
    @repository.edit_person_by_inn("AZ0123456789", new_person)
    updated_person = @repository.get_byINN("AZ0123456789")
    assert_equal(new_first_name, updated_person.first_name)
    assert_equal(new_last_name, updated_person.last_name)
    assert_equal(Date.parse(new_birth_date), updated_person.birth_date)
  end

  def test_edit_nonexistent_person
    assert_raise(PersonNotFoundError) do
      @repository.edit_person_by_inn("nonexistent_inn", @person_unexist)
    end
  end

  def test_delete_person_by_inn
    @repository.delete_person_by_inn("AZ0123456789")
    assert_equal(1, @repository.people.length)
    assert_not_includes(@repository.people, @person1)
  end

  def test_delete_nonexistent_person
    assert_raise(PersonNotFoundError) { @repository.delete_person_by_inn("nonexistent_inn") }
  end

  def test_get_all
    all_people = @repository.get_all
    assert_equal(2, all_people.length)
    assert_includes(all_people, @person1)
    assert_includes(all_people, @person2)
  end

  def test_get_by_inn
    person = @repository.get_byINN("AZ0123456789")
    assert_equal(@person1, person)
  end

  def test_get_by_inn_nonexistent
    person = @repository.get_byINN("nonexistent_inn")
    assert_nil(person)
  end

  def test_get_by_part_name
    matching_people = @repository.get_by_part_name("jo")
    assert_equal(1, matching_people.length)
    assert_includes(matching_people, @person1)
    assert_not_includes(matching_people, @person2)

    non_matching_people = @repository.get_by_part_name("xyz")
    assert_empty(non_matching_people)
  end

  def test_get_by_date_range
    date_from = "1980-01-01"
    date_to = "1995-12-31"
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal(2, people_in_range.length)
    assert_includes(people_in_range, @person1)
    assert_includes(people_in_range, @person2)

    date_from = "1990-01-01"
    date_to = "2000-12-31"
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal(1, people_in_range.length)
    assert_includes(people_in_range, @person1)
    assert_not_includes(people_in_range, @person2)

    date_from = nil
    date_to = "1989-12-31"
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal(1, people_in_range.length)
    assert_includes(people_in_range, @person2)

    date_from = "1990-01-01"
    date_to = nil
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal(1, people_in_range.length)
    assert_includes(people_in_range, @person1)

    date_from = nil
    date_to = nil
    all_people = @repository.get_by_date_range(date_from, date_to)
    assert_equal(2, all_people.length)
    assert_includes(all_people, @person1)
    assert_includes(all_people, @person2)
  end
end
