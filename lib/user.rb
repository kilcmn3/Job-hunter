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
    
    def self.user_input
        puts "Enter your email"
        input_email = gets.chomp
        finder = User.user_find_email(input_email)
        if finder == nil
            puts "Enter your name"
            input_name = gets.chomp
            puts "Enter your contact number"
            input_contact = gets.chomp
        
            User.create(name: input_name.downcase, email: input_email.downcase, contact: input_contact)
        else
            puts "Welcome back #{finder.name}!"
        end
        User_view.main_screen
    end
     
end