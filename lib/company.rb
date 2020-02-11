class Company < ActiveRecord::Base
    has_many :User_Company
    has_many :User , through: :User_Company

    def create(name:, email:, program_language: )
        user_company_finder = User_Company.find_or_create_by(comany_id: self.id )
        company = Company.new(name, email, program_language)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM comapny")
        company.save
    end
end

   