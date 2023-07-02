require_relative "person"

class PersonRepository
  def initialize
    @people = []
  end

  def add_person(person)
    if person.is_a?(Person)
      @people << person
    else
      raise ArgumentError, "Person must be a member of Person.Class"
    end
  end

  def edit_person_by_inn(inn, new_first_name, new_last_name, new_birth_date)
    person = get_byINN(inn)
    if person
      person.first_name = new_first_name
      person.last_name = new_last_name
      person.birth_date = new_birth_date
    else
      puts "Person not found for INN: #{inn}"
    end
  end

  def delete_person_by_inn(inn)
    person = get_byINN(inn)
    if person
      @people.delete(person)
      puts "Person with INN #{inn} deleted."
    else
      puts "Person not found for INN: #{inn}"
    end
  end

  def show_people
    @people.each do |person|
      puts "First Name: #{person.first_name}, Last Name: #{person.last_name}, INN: #{person.inn}, Date Of Birth: #{person.birth_date}"
    end
  end

  def get_all
    @people
  end

  def get_byINN(inn)
    @people.find { |person| person.inn == inn }
  end

  def get_by_part_name(name_part)
    @people.select { |person| person.first_name.include?(name_part) || person.last_name.include?(name_part) }
  end

  def get_by_date_range(date_from, date_to)
    if date_from.nil? && date_to.nil?
      @people
    elsif date_from.nil?
      @people.select { |person| person.birth_date <= date_to }
    elsif date_to.nil?
      @people.select { |person| person.birth_date >= date_from }
    else
      @people.select { |person| person.birth_date >= date_from && person.birth_date <= date_to }
    end
  end
end

pr = PersonRepository.new
pr.add_person(Person.new("John", "Luke", "AZ0123456789", "1999-12-12"))
pr.add_person(Person.new("Michael", "Buh", "AU9875642310", "1920-12-12"))
pr.add_person(Person.new("Liza", "Dovgan", "OI0654789321", "2003-12-12"))
pr.add_person(Person.new("Kulka", "Mica", "AS4563210789", "1999-12-12"))
pr.add_person(Person.new("Oleg", "Olegius", "AZ0123456789", "2005-12-12"))

pr.show_people
puts "\n"
p pr.get_byINN("OI0654789321")
puts "\n"
p pr.get_by_part_name("u")
puts "\n"
p pr.get_by_date_range(Date.parse("1970-01-01"), Date.parse("2000-01-01"))
