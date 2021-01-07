class Helper
    def self.logged_in?(session)
        !!session[:id]
    end
end