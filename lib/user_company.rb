class UserCompany < ActiveRecord::Base
    belongs_to :user 
    belongs_to :company

    PROMPT = TTY::Prompt.new
    # def self.find_if_exit(id)
    #    result = UserCompany.find(id)
    # end

    def self.find_company(search)
        search_email = search[0]
       search_list = UserCompany.all.select do |search|
            search.user_email == search_email.email
        end
        companies = search_list.map do |only_company|
            only_company.company_email
        end
        result = companies.map do |company|
            Company.all.select do |finder|
                finder.email == company
            end
        end
        result[0]
    end

    def self.user_added_list(user)
        if user.userCompanies.length == 0
            puts "No list yet! Empty list!"
            UserView.user_menu(user)
        else
            list = user.companies
            companies = list.map {|choice| "Name: #{choice.name}, Language: #{choice.program_language}"}
            input = PROMPT.select("List of companies", companies , per_page: 4) 
        
            delimiters = [', ', ': ']
            split_input = input.split(Regexp.union(delimiters))[1]
            
            chosen_company = Company.find{|chosen| chosen.name == split_input}
          
            UserView.menu_with_chosen_company(chosen_company, user)  
        end 
    end

    def self.destory_id(result)
        UserCompany.destroy(result.id)
        puts "Remove complete!!"
    end
end