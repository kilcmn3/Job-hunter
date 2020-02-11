class Company < ActiveRecord::Base
    has_many :User_Company
    has_many :User , through: :User_Company

    def create_table(name:, email:, program_language: )
        company = Company.new(name, email, program_language)
        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM comapny")
        company.save
    end
end