puts "Welcome  to my User_create Test world!"
class User_view < ActiveRecord::Base
    @@prompt = TTY::Prompt.new

    def self.user_or_company 
        input = @@prompt.select("who are you user? or company?", %w(User Company))
        if input == "User"
            User.user_input
        elsif input == "Company"
            company_input
        end
    end

    def self.main_screen 
        input = @@prompt.select("Choose your program lanaguage") do |menu|
              menu.choice 'Ruby'
              menu.choice 'Java'
              menu.choice 'Python'
              menu.choice 'JavaScript'
              menu.choice 'C'
          end
          Company.find_list(input)
      end

      def self.display_companies(chosen_language)
        list = chosen_language.map {|choice| "Name: #{choice.name}, Language: #{choice.program_language}"}
        @@prompt.select("List of companies", list) 
      end
end