module Helpers
    module ClassMethods
        def current_user(session)
            @user = User.find(session[:user_id])
        end

        def is_logged_in?(session)
            !!session[:user_id]
        end

        def find_by_slug(slug)
            @slug = slug
            self.all.find{|user| user.slug == slug}
        end
    end
    module InstanceMethods
        def slug
          self.username.downcase.gsub(" ", "-")
        end
    end
end