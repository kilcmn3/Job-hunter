class Company < ActiveRecord::Base
    has_many :userCompanies
    has_many :users , through: :userCompanies

    def self.find_company(email = nil)
        # if email == nil
        #     company_profile = Company.all.select do |companies|
        #     companies.program_language == @@storage[0]
        #     end
        # else
        #     company_profile = Company.all.select do |companies|
        #     companies.email == email
        #     end
        # end
        #   company_profile
    end

    # def self.until_no_blank(input = "")
    #     result = nil
    #     edit_profile = nil
    #     while input = gets.chomp
    #         case blank = User.blank_string?(input)
    #         when blank == true
    #              @@storage << input.downcase
    #              edit_profile = input.downcase
    #             break
    #         else
    #             puts "please re-enter again"
    #         end
    #     end
    #     edit_profile
    # end
    
    def self.match_company
        puts "Hello! Please enter your company email."
        company_email = gets.chomp
        result = Company.find_by(email: company_email)
        if  result == nil
            puts "Company is not registered yet."
            User_view.user_or_company
        else
            puts "Welcome back!"
            User_view.company_menu(result)
        end
    end

    # def self.find_match_companies(input)
    #     result = Company.all.select{|display| display.program_language == input.downcase}
    #     User_view.display_companies(result, nil)
    # end
end

   