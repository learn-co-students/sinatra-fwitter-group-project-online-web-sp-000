class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug 
    self.username.parameterize
  end 

  def find_by_slug(slug)
    self.all.detect {|name| name.username == slug}
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
