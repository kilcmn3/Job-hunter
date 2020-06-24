class Company < ActiveRecord::Base
    has_many :userCompanies
    has_many :users , through: :userCompanies

    def self.until_no_blank(input = "")
        while input = gets.chomp
            case input == ""
            when false
                 return input.downcase
            else
                puts "please re-enter again"
            end
        end
    end
    
    def self.match_company
        puts "Hello! Please enter your company email."
        company_email = gets.chomp
        result = Company.find_by(email: company_email)
        if  result == nil
            puts "Company is not registered yet."
            UserView.user_or_company
        else
            puts "Welcome back!"
            UserView.company_menu(result)
        end
    end

    # def self.find_match_companies(input)
    #     result = Company.all.select{|display| display.program_language == input.downcase}
    #     UserView.display_companies(result, nil)
    # end
end

   