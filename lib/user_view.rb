puts "Welcome  to my User_create Test world!"
class User_view < ActiveRecord::Base
    PROMPT = TTY::Prompt.new
    @@companies = nil
    @@company = nil
    @@user = nil
    @@users = nil


    #TODO : need to work on companyside now
    def self.user_or_company 
        input = PROMPT.select("who are you user? or company?") do |menu|
            menu.enum '.'

            menu.choice 'User', 1
            menu.choice 'Company', 2
            menu.choice 'oops..wrong homepage!', 3
        end

        case input
        when 1
            Ucontact
        when 2
            Company.match_company
        when 3
            puts "Bye Bye!"
        end
    end

    def self.user_menu(user)
        input = PROMPT.select("What would you like to do?") do |menu|
            menu.choice 'View added List'
            menu.choice 'Edit profile'
            menu.choice 'Job Search'
            menu.choice 'previous page'
        end

        case input
        when 'View added List'
            UserCompany.user_added_list(user)
        when 'Edit profile'
            self.user_edit_profile(user)
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

    def self.user_edit_profile(user)
        input = PROMPT.select("Perosal Information") do |menu|
            menu.enum '.'
            menu.choice '@email', 1
            menu.choice 'Contact', 2
            menu.choice 'previouse page', 3
         end

         case input
         when 1
            new_email = self.check_validation("email", user)
            self.user_email(user, new_email)
         when 2
            new_contact = self.check_validation("contact", user)
            user.contact = new_contact
         when 3
            self.user_menu(user)
         end
    end

    def self.check_validation(obj, user)
        puts "your current #{obj} is #{user}"
        answer = PROMPT.yes?('Woud like to change?')
          
        if answer == true
             puts "Ok!let's update your  new #{obj}!"
             new_email = User.validation_required("#{obj}")
             return new_email
        else answer == false
            self.user_edit_profile(obj, user)
        end
    end

    def self.user_email(user, new_email)
         find_if_exit = User.find_by(email: new_email) 
        if find_if_exit != nil
            puts "Someone is using that email!"
        else
            user.email = new_email
            user.save 
        end
        self.user_edit_profile(user)
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
          Company.find_match_companies(input)
          end
    end

    def self.display_companies(display, user = nil)
        companies = display.map {|choice| "Name: #{choice.name}, Language: #{choice.program_language}"}
        input = PROMPT.select("List of companies", companies , per_page: 4) 
        
        delimiters = [', ', ': ']
        split_input = input.split(Regexp.union(delimiters))[1]
 
        chosen_company = Company.find{|chosen| chosen.name == split_input}
        self.menu_with_chosen_company(chosen_company, user, dispaly)
    end
      
    def self.menu_with_chosen_company(result, user = nil, display = nil)
        puts "Company name: #{result.name} || Company email: #{result.email} || Program language: #{result.program_language}"
        input = PROMPT.select("What would you like to do?") do |menu|
            menu.enum '.'

            menu.choice 'Apply', 1
            menu.choice 'previous page', 2
            menu.choice 'Go back to Main menu', 3
        end

        case input
        when 1
            self.user_apply_page(result, user)
        when 2
            self.display_companies(display)
        when 3
            self.user_menu(user)
        end
    end

    def self.user_apply_page(company, user = nil)
        result = User_Company.find_if_exit(company.id)
        if result == nil
            User_Company.create(user_id: user.id,  company_id: company.id)
            puts "Apply done!"
            self.menu_with_chosen_company(company, user)
        else 
            puts "You've already applied!"
            input = PROMPT.select("what would you like to do?") do |menu|
                menu.enum '.'

                menu.choice 'Remove from my list', 1
                menu.choice 'previouse page', 2
            end

            case input
            when 1
                User_Company.destory_id(result)
                self.menu_with_chosen_company(company, user)
            when 2
                self.menu_with_chosen_company(company, user)
            end
        end
    end
end