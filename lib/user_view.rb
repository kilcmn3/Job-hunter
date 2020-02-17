puts "Welcome  to my User_create Test world!"
class User_view < ActiveRecord::Base
    PROMPT = TTY::Prompt.new
    @@companies = nil
    @@company = nil
    @@user = nil
    @@users = nil

    def self.user_or_company 
        input = PROMPT.select("who are you user? or company?") do |menu|
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

        input = PROMPT.select("What would you like to do?") do |menu|
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

    def self.company_menu(company_profile)
        @@company = nil
        @@company = company_profile
        input = PROMPT.select("What would like to do?") do |menu|
            menu.enum '.'

            menu.choice 'Applicants list', 1
            menu.choice 'Edit profile', 2
            menu.choice 'previsoue page', 3
        end

        case input
        when 1
            list = User_Company.find_applicants(company_profile)
            self.companyview_applicants_list(list)
        when 2
            self.companyview_edit_profile(company_profile)
        when 3
            self.user_or_company
        end
    end

    def self.companyview_applicants_list(list)
        @@users = nil
        @@users = list

            users = list.map {|choice| "Name: #{choice.name}, email: #{choice.email}"}
            input = PROMPT.select("List of applicants", users , per_page: 4) 
        
            delimiters = [', ', ': ']
            split_input = input.split(Regexp.union(delimiters))[1]
            
            result = list.select do |user|
            user.name == split_input
            end
            self.companyview_selected_applicatn(result[0])
    end

    def self.companyview_selected_applicatn(applicant)
        puts "applicant name: #{applicant.name}, email: #{applicant.email}, contact: #{applicant.contact}"
        input = PROMPT.select("what would you like to do?") do |menu|
            menu.enum '.'

            menu.choice 'Remove applicant', 1
            menu.choice 'previouse page', 2
            menu.choice 'Go back to Main menu', 3
        end

        case input
        when 1
            user_profile = User_Company.find_if_exit(@@company[0])
            User_Company.find_applicants(@@company)
            User_Company.destory_record(user_profile)
            self.companyview_applicants_list(@@users)
        when 2
            self.companyview_applicants_list(@@users)
        when 3
            self.company_menu(@@company)
        end
    end

    def self.companyview_edit_profile(company_profile)
        input = PROMPT.select("Company infomation") do |menu|
            menu.enum '.'

            menu.choice '@email', 1
            menu.choice 'Program Language', 2
            menu.choice 'previouse page', 3
        end

        case input
        when 1
            self.companyview_edit_profile_email(company_profile)
        when 2
            self.companyview_edit_profile_program_language(company_profile)
        when 3
            self.company_menu(company_profile)
        end

    end

    def self.companyview_edit_profile_email(company_profile)
        puts "Company current @email is #{company_profile[0].email}"
        answer = PROMPT.yes?('Woud like to change?')
          
        case answer
        when true
        puts "Company new @email please"
        new_email = Company.until_no_blank
        company = Company.find_company(company_profile[0].email)[0]
        company.email = new_email
        company.save
        puts "Company new @email is #{company.email}"

        company_new_profile = []
        company_new_profile << company
        self.companyview_edit_profile(company_new_profile)
        when false
            self.companyview_edit_profile(company_profile)
        end
    end

    def self.companyview_edit_profile_program_language(company_profile)
        puts "Company current program language is #{company_profile[0].program_language}"
        answer = PROMPT.yes?('Would you like to change?')

        case answer
        when true
        puts "please enter new language to be change."
        new_language = Company.until_no_blank
        company = Company.find_company(company_profile[0].email)[0]
        company.program_language = new_language
        company.save
        puts "Company new program langauge is #{company.program_language}"

        company_new_profile = []
        company_new_profile << company
        self.companyview_edit_profile(company_new_profile)
        when false
            self.companyview_edit_profile(company_profile)
        end
    end

    def self.userview_edit_profile(profile)
        input = PROMPT.select("Perosal Information") do |menu|
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
        answer = PROMPT.yes?('Woud like to change?')
          
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
        answer = PROMPT.yes?('Woud like to change?')

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
        input = PROMPT.select("Choose your program lanaguage") do |menu|
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
        input = PROMPT.select("List of companies", companies , per_page: 4) 
        
        delimiters = [', ', ': ']
        split_input = input.split(Regexp.union(delimiters))[1]
   
        result = list.select do |company|
            company.name== split_input
       end
       self.menu_with_chosen_company(result)
    end
      
    def self.menu_with_chosen_company(result)
        @@company = nil
        @@company = result

        puts "Company name: #{result[0].name} || Company email: #{result[0].email} || Program language: #{result[0].program_language}"
        input = PROMPT.select("What would you like to do?") do |menu|
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
            self.user_menu(@@user)
        end
    end

    def self.user_apply_page(company_info)
        user_email = @@user[0].email
        company_email = @@company

        result = User_Company.find_if_exit(company_email[0])
        if result == nil
            User_Company.create(user_email: user_email,  company_email: company_email[0].email)
            puts "Apply done!"
            company_last = Company.find_company(company_email[0].email)
            self.menu_with_chosen_company(company_last)
        else 
            puts "You've already added!"
            input = PROMPT.select("what would you like to do?") do |menu|
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