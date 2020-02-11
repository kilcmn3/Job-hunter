class Company < ActiveRecord::Base
    def create_table(name:, email:, program_language: )
        company = Company.new(name, email, program_language)
        company.save
    end
end