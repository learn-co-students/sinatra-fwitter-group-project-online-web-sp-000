class ViewsGenerator

  # Generates ERB!!!!

  attr_accessor :class

  def index_page

    <<~ERB
    <h2>#{@class.table_name.titleize}</h2>

    <ol>
      <% @#{@class.table_name}.each do |#{@class.singular_name}| %>
      <li><a href="#{@class.table_name}/"><%= #{@class.singular_name}.id %></a></li>
      <% end %>
    </ol>
    ERB
    
  end
  
end