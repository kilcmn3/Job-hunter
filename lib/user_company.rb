class User_Company < ActiveRecord::Base
    belongs_to :User 
    belongs_to :Company

    def create(user_id: nil, company_id:)
        user_company = User_Company.new(user_id, company_id)
        user_company.save
    end
end