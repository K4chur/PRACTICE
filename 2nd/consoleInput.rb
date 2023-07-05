FIRST_TASK_PATH = "./1st/validation"
# 'C:\Users\vvojc\OneDrive\Desktop\IFTKN\RUBY\SummerPractice_Ruby_SoftServe\1st\validation'

require FIRST_TASK_PATH

module ConsoleInput
  def get_string_input()
    input = nil
    until input && input.is_a?(String)
      print "Input string value: "
      input = gets.chomp
    end
    input
  end

  def get_name_input()
    input = nil
    until input && valid_name?(input)
      print "Input name-typed value (ex. Anna-Maria): "
      input = gets.chomp
    end
    input
  end

  def get_integer_input()
    input = nil
    until input && input.match?(/\A[0-9]+\z/)
      print "Input integer value: "
      input = gets.chomp
    end
    input.to_i
  end

  def get_inn_input()
    input = nil
    until input && valid_inn?(input)
      print "Input inn-typed value (ex. AZ0123456789): "
      input = gets.chomp
    end
    input
  end

  def valid_date_format?(input)
    /^\d{4}-\d{2}-\d{2}$/.match?(input) && Date.parse(input)
  rescue ArgumentError
    false
  end

  def get_date_input()
    input = nil
    until input && valid_date_format?(input)
      print "Input valid date value in yyyy-mm-dd format: "
      input = gets.chomp
    end
    Date.parse(input)
  end

  private :valid_date_format?
end