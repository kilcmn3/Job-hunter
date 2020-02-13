puts "Welcome  to my User_create Test world!"
class User_view < ActiveRecord::Base
    @@prompt = TTY::Prompt.new
    @@storage = nil

    def self.user_or_company 
        input = @@prompt.select("who are you user? or company?", %w(User Company))
        if input == "User"
            User.user_email
        elsif input == "Company"
            Company.match_company
        end
    end

    def self.main_screen 
        input = @@prompt.select("Choose your program lanaguage") do |menu|
              menu.choice 'Ruby'
              menu.choice 'Java'
              menu.choice 'Python'
              menu.choice 'JavaScript'
              menu.choice 'C'
              menu.choice '**exit program!'
          end
          if input == '**exit program!'
            puts "See you again!"
          else
            p input
            puts "what??"
          Company.display_companies_list(input)
          end
    end

    def self.display_companies(list)
        @@storage = list
        companies = list.map {|choice| "Name: #{choice.name}, Language: #{choice.program_language}"}
        input = @@prompt.select("List of companies", companies , per_page: 4) 
        
        delimiters = [', ', ': ']
        split_input = input.split(Regexp.union(delimiters))[1]
   
        result = list.select do |company|
            company.name== split_input
       end
       self.menu_with_chosen_company(result)
    end
      
    def self.menu_with_chosen_company(result)
        puts "Company name: #{result[0].name} || Company email: #{result[0].email} || Program language: #{result[0].program_language}"
        input = @@prompt.select("What would you like to do?") do |menu|
            menu.enum '.'

            menu.choice 'Apply', 1
            menu.choice 'previous page', 2
            menu.choice 'Go back to Main menu', 3
        end

        case input
        when 1
            puts "Apply done!"
            self.display_companies(@@storage)
        when 2
            self.display_companies(@@storage)
        when 3
            self.main_screen
        end
    end
        
end