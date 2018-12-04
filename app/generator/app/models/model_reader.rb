class ModelReader
  attr_accessor :filepath, :class, :file

  def class_name
    file.scan(/class (\S+)/).first.first
  end  

  def class_name_from_table_name(str)
    str.titleize.gsub(' ', '').singularize
  end

  def belongs_to
    array = file.scan(/belongs_to (.+)/)
    return [] if array.empty?
    array.first.first
    .scan(/\w+/)
    .map {|p| class_name_from_table_name(p)}
  end

  def all_has_many
    file.scan(/has_many :(.+)/).map {|p| p.first.strip}
  end
  
  def has_many
    throughs = many_through_join.map {|p| p[:through].underscore.pluralize}
    all_has_many.select {|p| !p.include?('through') && !throughs.include?(p)}
    .map {|p| class_name_from_table_name(p)}
  end

  def all_through
    strs = all_has_many.select {|p| p.include?('through')}
    hashes = strs.map do |str|
      matches = str.scan(/(\w+), through: :(\w+)/).first
      .map {|p| class_name_from_table_name(p)}
      { many: matches[0].strip, through: matches[1].strip }
    end    
  end

  def has_many_through
    all_through.select do |hash|
      !hash[:through].include?(hash[:many])
    end
  end
  
  def many_through_join
    all_through.select do |hash|
      hash[:through].include?(hash[:many])
    end
  end

  def properties # => list of property names only (no types)
    array = file.scan(/attr_accessor (.+)/)
    return [] if array.empty?
    array.first.first.scan(/\w+/)
  end

  def create_generator_class
      cl = GeneratorClass.new
      cl.name = class_name
      cl.belongs_to = belongs_to
      cl.has_many = has_many
      cl.has_many_through = has_many_through
      cl.many_through_join = many_through_join
      cl.properties = properties.map {|p| {name: p, type: 'string'}}
      cl
  end

  def initialize(filepath)
    @filepath = filepath  
    @file = File.read(filepath)
  end
  
end