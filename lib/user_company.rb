class User_Company < ActiveRecord::Base
    belongs_to :User 
    belongs_to :Company
    
    def self.create(user_email: , company_email:)
        user_company = User_Company.new(user_email: user_email, company_email: company_email)
        user_company.save
    end

    def self.find_if_exit(result)
        p "you are at if exit"
        p result
        User_Company.all.find{|company| company.company_email == result[0].email}
    end

    def self.find_company(search)
        search_email = search[0]
       search_list = User_Company.all.select do |search|
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
        final_result = []
        result = []
        User_Company.all.select do |company|
            company.company_email == company_data[0].email
            result << company
            final_result << result
             end
    
        if final_result.length > 0
            user_only = final_result.flatten.map do |list_applicants|
                list_applicants.user_email
            end
            user_result = []
            list_user = []
            list_user << User.all 
            
            list_user_object = user_only.each do |compare|
                user_result << list_user[0].select {|users| compare == users.email }
                end
            return user_result[0]
        else 
            puts "No applicants :-("
            User_view.company_menu(company_data)
        end
    end

    def self.user_added_list(profile)
        puts "Companies lists"
       companies_list = self.find_company(profile)
       if companies_list != nil
       User_view.display_companies(companies_list)
       else
        puts "Empty slots"
        User_view.user_menu(profile)
       end
    end

    def self.destory_record(record)
        User_Company.destroy(record.id)
        puts "Remove complete!!"
    end
end