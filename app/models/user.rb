class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

    def slug

      user_name = self.username
      slug = user_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

    end

    def self.find_by_slug(slug)

    @slug = slug
    format_beginning_of_slug
    results = self.where("username LIKE ?", @short_slug)

    results.detect do |result|
      result.slug === @slug
    end

  end

  def self.format_beginning_of_slug

    slug_beginning = @slug.split("-")[0]
    slug_beginning.prepend("%")
    slug_beginning << "%"
    @short_slug = slug_beginning

  end

end
