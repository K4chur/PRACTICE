class PersonNotFoundError < StandardError
  def initialize(inn)
    super("Person not found for INN: #{inn}")
  end
end

class PersonAlreadyExist < StandardError
    def initialize(inn)
      super("Person with INN #{inn} already exists.")
    end
  end