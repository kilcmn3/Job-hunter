class User < ActiveRecord::Base
    has_many :User_Company
    has_many :Company , through: :User_Company

    def self.user_find_email(email)
        result = User.all.find{|user| user.email == email}
    end

    def create(name: ,email: ,contact: )
        user = User.new(name, email, contact ,id=nil)
        @id = DB[:conn].exectue("SELECT last_insert_rowid()FROM users ")[0][0]
        user.save
    end
end