class User < ActiveRecord::Base
    def create(name: ,email: ,contact: )
        user = User.new(name, email, contact)
        user.save
    end
end