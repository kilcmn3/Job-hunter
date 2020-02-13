puts "Welcome  to my User_create Test world!"
class User_view < ActiveRecord::Base
    @@prompt = TTY::Prompt.new
    @@companies = nil
    @@company = nil
    @@user = nil

    def self.user_or_company 
        input = @@prompt.select("who are you user? or company?") do |menu|
            menu.enum '.'

            menu.choice 'User', 1
            menu.choice 'Company', 2
            menu.choice 'oops..wrong homepage!', 3
        end

        case input
        when 1
            User.user_email
        when 2
            Company.match_company
        when 3
            puts "Bye Bye!"
        end
    end

    def self.user_menu(profile)
        @@user = nil
        @@user = profile

        input = @@prompt.select("What would you like to do?") do |menu|
            menu.choice 'View added List'
            menu.choice 'Edit profile'
            menu.choice 'Job Search'
            menu.choice 'previous page'
        end
        case input
        when 'View added List'
            User_Company.user_added_list(profile)
        when 'Edit profile'
            self.userview_edit_profile(profile)
        when 'Job Search'
            self.main_screen
        when 'previous page'
            self.user_or_company
        end
    end

    def self.userview_edit_profile(profile)
        input = @@prompt.select("Perosal Information") do |menu|
            menu.enum '.'
            menu.choice '@email', 1
            menu.choice 'Contact', 2
            menu.choice 'previouse page', 3
         end

         case input
         when 1
            self.userview_edit_profile_email(profile)
         when 2
            self.userview_edit_profile_contact(profile)
         when 3
            self.user_menu(profile)
         end
    end

    def self.userview_edit_profile_email(profile)
        puts "your current @email is #{profile[0].email}"
        answer = @@prompt.yes?('Woud like to change?')
          
        case answer
        when true
        puts "your new @email please"
        new_email = User.until_no_blank
        user = User.user_find_email(profile[0].email)
        user.email = new_email
        user.save
        user_profile = []
        user_profile << user
        self.userview_edit_profile(user_profile)
        when false
            self.userview_edit_profile(profile)
        end
    end

    def self.userview_edit_profile_contact(profile)
        puts "your current contact is #{profile[0].contact}"
        answer = @@prompt.yes?('Woud like to change?')

        case answer
        when true
        puts "your new contact please"
        new_contact = User.until_no_blank
        user = User.user_find_email(profile[0].email)
        user.contact = new_contact
        user.save
        user_profile = []
        user_profile << user
        self.userview_edit_profile(user_profile)
        when false
            self.userview_edit_profile(profile)
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
          Company.display_companies_list(input)
          end
    end

    def self.display_companies(list)
        @@companies = nil
        @@companies = list
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
        @@company = nil
        @@company = result[0]
        puts "Company name: #{result[0].name} || Company email: #{result[0].email} || Program language: #{result[0].program_language}"
        input = @@prompt.select("What would you like to do?") do |menu|
            menu.enum '.'

            menu.choice 'Apply', 1
            menu.choice 'previous page', 2
            menu.choice 'Go back to Main menu', 3
        end

        case input
        when 1
            self.user_apply_page(result)
        when 2
            self.display_companies(@@companies)
        when 3
            self.main_screen
        end
    end

    def self.user_apply_page(company_info)
        p "prrrrinting out company info!"
        p company_info
        result = User_Company.find_if_exit(company_info)
        if result == nil
            User_Company.create(user_email: @@user[0].email, company_email: @@company.email)
            puts "Apply done!"
            self.menu_with_chosen_company(@@company)
        else 
            puts "You've already added!"
            input = @@prompt.select("what would you like to do?") do |menu|
                menu.enum '.'

                menu.choice 'Remove from my list', 1
                menu.choice 'previouse page', 2
            end

            case input
            when 1
                destroy_it = User_Company.destory_record(result)
                self.menu_with_chosen_company(company_info)
            when 2
                self.menu_with_chosen_company(company_info)
            end
        end
    end
        
end