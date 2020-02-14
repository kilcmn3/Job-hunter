class User < ActiveRecord::Base
    has_many :User_Company
    has_many :Company , through: :User_Company

    @@storage = []

    def self.create(name: ,email: ,contact: )
        user = User.new(name: @@storage[1], email: @@storage[0], contact: @@storage[2])
        user.save
    end

    def self.user_find_email(email= nil)
        find_profile = nil
        if @@storage.length > 0 && email == nil
        find_profile = User.all.find{|user| user.email == @@storage[0]}
        else
        find_profile = User.all.find{|user| user.email == email}
        end
        find_profile
    end

    def self.until_no_blank(input = "")
        result = nil
        edit_profile = nil
        while input = gets.chomp
            case blank = self.blank_string?(input)
            when blank == true
                 @@storage << input.downcase
                 edit_profile = input.downcase
                break
            else
                puts "please try it again"
            end
        end
        edit_profile
    end

    def self.user_email
        @@storage = []
        puts "What's your @email?"  
        self.until_no_blank
        result = self.user_find_email
        if result == nil
            self.user_name
        else
            profile = []
            profile << result
            puts "Welcome back #{result.name}"
            User_view.user_menu(profile)
        end
    end

    def self.user_name
        puts "and your name? ex)John Doe, Dwayne Johnson"
        self.until_no_blank
        user_contact
    end

    def self.user_contact
        puts "ok! last, your contact"
        self.until_no_blank
        self.create(name: @@storage[1], email: @@storage[0], contact: @@storage[2])
        user = User.all.select{|new_user| new_user.email = @@storage[0]}
        User_view.user_menu(user)
    end

    def self.blank_string?(input)
        blank = /\A[[:space:]]*\z/
        blank.match?(input) ? nil : true
    end
end
