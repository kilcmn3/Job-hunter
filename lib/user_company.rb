class User_Company < ActiveRecord::Base
    belongs_to :User 
    belongs_to :Company
    
    def self.create(user_email: , company_email:)
        user_company = User_Company.new(user_email: user_email, company_email: company_email)
        user_company.save
    end

    def self.find_if_exit(result)
        User_Company.all.find{|company| company.company_email == result[0].email}
    end

    def self.find_company(search)
       search_list = User_Company.all.select do |search|
            search.user_email == search[0].email
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
        list_email = User_Company.all.select do |company|
            company.company_email == company_data[0].email
        end
        if list_email.length > 1
            user_only = list_email.map do |find_user|
                find_user.user_email
            end
            result = User.all.select do |user|
            user.email == result[0].user_email
            end
        else
            puts "No applicants :-("
            User_view.company_menu
        end
    end

    def self.user_added_list(profile)
        puts "Companies lists"
       companies_list = self.find_company(profile)
       if companies_list != nil
       User_view.display_companies(companies_list)
       else
        puts "Empty slots"
        User_view.userview_edit_profile(profile)
       end
    end

    def self.destory_record(record)
        User_Company.destroy(record.id)
        puts "Remove complete!!"
    end
end