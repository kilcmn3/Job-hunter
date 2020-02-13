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

    def self.find_join(search)
        p search
       search_list = User_Company.all.select do |join|
            join.user_email == search[0].email
        end
        search_list
        companies = search_list.map do |only_company|
            only_company.company_email
        end
        companies
        result = companies.map do |company|
            Company.all.select do |finder|
                finder.email == company
            end
        end
        result[0]
    end

    def self.user_added_list(profile)
        puts "Companies lists"
       companies_list = self.find_join(profile)
       User_view.display_companies(companies_list)
    end

    def self.destory_record(record)
        User_Company.destroy(record.id)
        puts "Remove complete!!"
    end
end