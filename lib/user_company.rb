class UserCompany < ActiveRecord::Base
    belongs_to :user 
    belongs_to :company
    
    def self.create(user_email: , company_email:)
        user_company = User_Company.new(user_email: user_email, company_email: company_email)
        user_company.save
    end

    def self.find_if_exit(result)
        output = User_Company.all.find{|company| company.company_email == result.email}
        output
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
        company_flat = company_data[0].email
        result = []
        result << User_Company.all
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
        p record
        User_Company.destroy(record.id)
        puts "Remove complete!!"
    end
end