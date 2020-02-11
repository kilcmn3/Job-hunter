class User < ActiveRecord::Base
    def self.user_find_email(email)
        result = User.all.find{|user| user.email == email}
    end

    def create(name: ,email: ,contact: )
        user = User.new(name, email, contact)
        user.save
    end
end