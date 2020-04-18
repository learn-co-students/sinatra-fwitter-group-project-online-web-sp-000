class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug 
    self.username.parameterize unless self.username == nil
  end 

  def self.find_by_slug(slug)
    self.all.find {|name| name.slug == slug}
  end 

  # it 'can slug the username' do
  #   expect(@user.slug).to eq("test-123")
  # end

  # it 'can find a user based on the slug' do
  #   slug = @user.slug
  #   expect(User.find_by_slug(slug).username).to eq("test 123")
  # end

  # it 'has a secure password' do

  #   expect(@user.authenticate("dog")).to eq(false)

  #   expect(@user.authenticate("test")).to eq(@user)
  # end
end
