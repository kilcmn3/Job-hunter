class Company < ActiveRecord::Base
    has_many :User_Company
    has_many :User , through: :User_Company

    def create(name:, email:, program_language: )
        user_company_finder = User_Company.find_or_create_by(comany_id: self.id )
        company = Company.new(name, email, program_language)
        self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM comapny")
        company.save
    end

    def self.find_list(input)
        choice = input.downcase
        chosen_language = Company.all.select do |companies|
            companies.program_language == choice
        end
        User_view.display_companies(chosen_language)
    end

end

   