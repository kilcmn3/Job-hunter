class UserCompany < ActiveRecord::Base
    belongs_to :user 
    belongs_to :company
    
    def self.create(user_id: , company_id:)
        user_company = UserCompany.new(user_email, company_email)
        user_company.save
    end

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

    def self.find_applicants(company_data)
        company_flat = company_data[0].email
        result = []
        result << UserCompany.all
        company_list = result[0].each do |company|
                 company.company_email
             end
        
        if company_list.length > 0
            user_only = company_list.map do |list_applicants|
                list_applicants.user_email
            end
            final_result = []
            user_only.each do |x|
                final_result << User.user_find_email(x)
            end
            final_result
        else 
            puts "No applicants :-("
            User_view.company_menu(company_data)
        end
    end

    def self.user_added_list(user)
        if user.usercompanies.length == 0
            puts "No list yet! Empty list!"
            User_view.user_menu(user)
        else
            list = Company.all.find_by {|added| added.id == user.company_id}
            User_view.display_companies(list, user)
        end 
    end

    def self.destory_id(result)
        UserCompany.destroy(result.id)
        puts "Remove complete!!"
    end
end