require_relative '../../../config/environment'

class String
  def valid_class_name?
    true
  end
end

class GeneratorCLI
  attr_accessor :generator, :class_name

  def get_class_info
    @class_name = get_class_name
  end

  def get_class_name
    puts "Enter the name for your class. Enter 'done' to return to the main prompt."
    input = gets.chomp
    if input.downcase == "done"
      run
    elsif input.valid_class_name?
      class_name = input.titleize
    else
      puts "Invalid class name."
      get_class_name
    end
    class_name
  end

  def view_class_info(class_num)
    # stub
    # display classes
    # choose a class to view
  end

  def display_classes
    puts "Current classes:"
    # get and list the current classes that exist
  end

  def run
    display_classes
    puts "Enter 'class' to create a new class. Enter 'view [class number]' to view/edit a class's model."
    # display other input options
    input = gets.chomp
    if input == 'class'
      get_class_info
    elsif num = input.split("view ")[1]
      if (n = num.to_i) > 0
        view_class_info(n)
      else 
        puts "Invalid input after 'view '."
        run # should this go /after/ the input is checked, so that unless we exit (don't know how to do that!) we will run again?
      end
    end
  end
end