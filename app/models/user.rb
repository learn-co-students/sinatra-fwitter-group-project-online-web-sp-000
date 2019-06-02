class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  def slug 
    array_of_name_words = self.username.split(" ")
    array_of_name_words.collect {|word| word.downcase}.join("-")
  end
  
  def self.find_by_slug(slug)
    array_of_name_words = slug.split("-")
    downcase_username = array_of_name_words.join(" ")
    self.all.find do |object|
      object.username.downcase == downcase_username
    end
  end
end