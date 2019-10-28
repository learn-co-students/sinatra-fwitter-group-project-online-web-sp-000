require 'pry'

class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets



  def slug 
    @username = username 
    @username.split.join("-") 
  end 

  def self.find_by_slug(slug) 
    User.all.find do |person|
      person.slug == slug
    end 
  end 


end
