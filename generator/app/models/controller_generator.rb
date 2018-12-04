class ControllerGenerator
  attr_accessor :class
  
  def initialize(cl)
    @class = cl
  end

  # CODE HELPER METHODS
  def all_self
    "@#{@class.table_name} = #{@class.name}.all"
  end

  def all_properties
    @class.relationship_names.collect do |prop_name|
      "@#{prop_name.underscore.pluralize} = #{prop_name}.all" 
    end
  end  

  def create_self
    "#{@class.singular_name} = #{@class.name}.create(params['#{@class.singular_name}'])"    
  end

  def update_self
    "#{@class.singular_name}.update(params['#{@class.singular_name}'])"   
  end
  
  def find_self
    "#{@class.singular_name} = #{@class.name}.find(params[:id])"   
  end

  def create_new_belongs_to
    @class.belongs_to.map do |prop|
      "#{@class.singular_name}.#{prop.underscore} = #{prop}.create(name: params['#{prop.underscore}_name']) unless params['#{prop.underscore}_name'].empty?"
    end
  end
  
  def create_new_has_many
    props = @class.has_many + @class.many_through_join.map{|p| p[:many]}
    props.map do |prop|
      "#{@class.singular_name}.#{prop.underscore.pluralize} << #{prop}.create(name: params['#{prop.underscore}_name']) unless params['#{prop.underscore}_name'].empty?"
      end
  end

  def redirect_show
    "redirect \"#{@class.table_name}/\#{#{@class.singular_name}.id}\""
  end

  def erb_call(path)
    "erb :'/#{@class.table_name}/#{path}'"
  end

  
  def clear_unchecked_params
    props = @class.has_many + @class.many_through_join.map{|p| p[:many]}
    props.map do |prop|
    %(params[:song_info]['#{prop.underscore}_ids'].clear if !params[:#{@class.singular_name}].keys.include?('#{prop.underscore}_ids'))
    end
  end
end

class ControllerGenerator

  def indent(code_array)
    code_array.flatten.map do |line|
      line.prepend('  ') 
      line.prepend('  ') if line != code_array.first && line != code_array.last
    end
    code_array.join("\n")
  end

  # ROUTE GENERATORS
  def index_action
    indent([%(get '/#{@class.table_name}' do),
    %(@#{@class.table_name} = #{@class.name}.all),
    %(erb :'/#{@class.table_name}/index'),
    %(end),])
  end

  def new_action
    indent([%(get '/#{@class.table_name}/new' do),
    %(#{all_properties.join("\n    ")}),
    %(#{erb_call("new")}),
    %(end),])
  end

  def create_action
    indent([%(post '/#{@class.table_name}' do),
    %(#{create_self}),
    create_new_belongs_to.map {|line| line},
    create_new_has_many.map {|line| line},
    # %(#{create_new_belongs_to.join("\n    ")}),
    # %(#{create_new_has_many.join("\n    ")}),
    %(#{@class.singular_name}.save),
    %(#{redirect_show}),
    %(end),])
  end

  def show_action
    indent([%(get '/#{@class.table_name}/:id' do),
    %(@#{find_self}),
    %(#{erb_call('show')}),
    %(end),])
  end

  def edit_action
    indent([%(get '/#{@class.table_name}/:id/edit' do),
    %(@#{find_self}),
    all_properties.map {|line| line},
    # %(#{  all_properties.join("\n")}),
    %(#{erb_call("edit")}),
    %(end),])
  end  

  def patch_action
    indent([%(patch '/#{@class.table_name}/:id' do),
    # %(#{clear_unchecked_params.join("\n")}),
    clear_unchecked_params.map {|line| line},
    %(#{find_self}),
    %(#{update_self}),
    create_new_belongs_to.map {|line| line},
    create_new_has_many.map {|line| line},
    # %(#{create_new_belongs_to.join("\n")}),
    # %(#{create_new_has_many.join("\n")}),
    %(#{@class.singular_name}.save),
    %(#{redirect_show}),
    %(end),])
  end

  def delete_action
    indent([%(delete '/#{@class.table_name}/:id' do),
    %(#{find_self}),
    %(#{@class.singular_name}.delete),
    %(end),])
  end
  
  def controller_filename
    @class.table_name + "_controller.rb"
  end

  def create_code
    @actions = [
      method(:index_action),
      method(:new_action),
      method(:create_action),
      method(:show_action),
      method(:edit_action),
      method(:patch_action),
      method(:delete_action),
    ]
    template_str = File.read("generator/app/templates/controller_generator_generate.erb")
    template = ERB.new(template_str)
    template.result(binding)
  end

  def generate_files
    require 'fileutils'
    FileUtils.mkdir_p 'app/controllers/'
    # if no ApplicationController, create ApplicationController
    File.write("app/controllers/#{controller_filename}", create_code)
  end
end