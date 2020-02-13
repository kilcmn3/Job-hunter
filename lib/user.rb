class User < ActiveRecord::Base
    has_many :User_Company
    has_many :Company , through: :User_Company

    @@storage = []

    def self.create(name: ,email: ,contact: )
        user = User.new(name: @@storage[1], email: @@storage[0], contact: @@storage[2])
        user.save
    end

    def self.user_find_email   
        User.all.find{|user| user.email == @@storage[0]}
    end

    def self.until_no_blank(input = "")
        result = nil
        while input = gets.chomp
            case blank = self.blank_string?(input)
            when blank == true
                 @@storage << input.downcase
                break
            else
                puts "please re-enter again"
            end
        end
    end

    def self.user_email
        puts "Enter your email"  
        self.until_no_blank
        result = self.user_find_email
        if result == nil
            user_name
        else 
            puts "Welcome back #{result.name}"
            User_view.main_screen
        end
    end

    def self.user_name
        puts "Enter your name"
        self.until_no_blank
        user_contact
    end

    def self.user_contact
        puts "Enter your contact number"
        self.until_no_blank
        self.create(name: @@storage[1], email: @@storage[0], contact: @@storage[2])
    end
     
    def self.blank_string?(input)
        blank = /\A[[:space:]]*\z/
        blank.match?(input) ? nil : true
    end
end
