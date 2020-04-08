require_relative '../models/concerns/slugifiable.rb'
class Tweet < ActiveRecord::Base
	extend Slugifiable::ClassMethods
	include Slugifiable::InstanceMethods
	
	belongs_to :user
	validates_presence_of :content
end
