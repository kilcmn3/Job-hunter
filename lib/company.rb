class Company < ActiveRecord::Base
    has_many :User_Company
    has_many :User , through: :User_Company

    @@result = []

    def create(name:, email:, program_language: )
        company = Company.new(name, email, program_language)
        company.save
    end

    def self.find_company
        Company.all.select do |companies|
            companies.program_language == @@result[0]
        end
    end

    def self.until_no_blank(input = "")
        result = nil
        while input = gets.chomp
            case blank = User.blank_string?(input)
            when blank == true
                 @@result << input.downcase
                break
            else
                puts "please re-enter again"
            end
        end
    end
    
    def self.match_company
        puts "Hello! Please enter your company email."
        self.until_no_blank
        if self.find_company == nil
            puts "Sorry, but you've not register company."
        else
            puts "Welcome back!"
            puts "Please select your option"
        end
    end

    def self.display_companies_list(input)
        @@result << input.downcase
        list = self.find_company

        User_view.display_companies(list)
    end
end

   