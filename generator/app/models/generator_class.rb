class GeneratorClass

  attr_accessor :name, :properties, :belongs_to, :has_many, :many_through_join, :has_many_through

  def table_name
    @name.underscore.pluralize
  end  

  def singular_name
    @name.underscore
  end

  def relationship_names
    @belongs_to + @many_through_join.map{|p| p[:many]} + @has_many
  end
  
end