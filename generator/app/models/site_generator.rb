require 'date'
require 'erb'
require 'FileUtils'

class SiteGenerator

  attr_reader :classes 
 
  def generate_generator_classes
    paths = Dir["app/models/*.rb"]
    @classes = paths.map do |path|
      ModelReader.new(path).create_generator_class
    end
  end

  def generate_migrations
    @classes.each do |cl|
      TableGenerator.new(cl).generate_files
    end 
  end
  
  def generate_controllers
    @classes.each do |cl|
      ControllerGenerator.new(cl).generate_files
    end     
  end

  def call
    generate_generator_classes
    generate_migrations
    # generate_controllers
  end
end