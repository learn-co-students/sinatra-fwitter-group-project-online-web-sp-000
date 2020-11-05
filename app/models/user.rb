class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug
    @slug = slugify(self.username)
 end

 def slugify(name)
     split_on_apostrophes = name.split(/[']/)
     name_without_apost = split_on_apostrophes.join
     name_array = name_without_apost.downcase.split(/[\W]/)
     name_array.delete_if{|x|x==""}
     new_name = name_array.join("-")
 end

 def self.find_by_slug(slug)
   self.all.detect{|x|x.slug == slug}
 end
end
