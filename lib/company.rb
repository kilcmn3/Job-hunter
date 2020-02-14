class Company < ActiveRecord::Base
    has_many :User_Company
    has_many :User , through: :User_Company

    @@storage = []

    def create(name:, email:, program_language: )
        company = Company.new(name, email, program_language)
        company.save
    end

    def self.find_company(email = nil)
        if email == nil
            company_profile = Company.all.select do |companies|
            companies.program_language == @@storage[0]
            end
        else
            company_profile = Company.all.select do |companies|
            companies.email == email
            end
        end
          company_profile
    end

    def self.until_no_blank(input = "")
        result = nil
        edit_profile = nil
        while input = gets.chomp
            case blank = User.blank_string?(input)
            when blank == true
                 @@storage << input.downcase
                 edit_profile = input.downcase
                break
            else
                puts "please re-enter again"
            end
        end
        edit_profile
    end
    
    def self.match_company
        puts "Hello! Please enter your company email."
        company_email = Company.until_no_blank
        result = self.find_company(company_email)
        if  result.length == 0
            puts "Company is not registered yet."
            User_view.user_or_company
        else
            @@storage = nil
            @@storage = result
            puts "Welcome back!"
            User_view.company_menu(result)
        end
    end

    def self.display_companies_list(input)
        @@storage = []
        @@storage << input.downcase
        list = self.find_company
        User_view.display_companies(list)
    end
end

   