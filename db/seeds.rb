puts 'creating tables..'
Company.destroy_all
User.destroy_all
UserCompany.destroy_all

company1 = Company.create(name: "FlatIron School", email: "flatironschool@email.com", program_language: "ruby")
company2 = Company.create(name: "Triplebyte", email: "triplebyte@email.com", program_language: "ruby")
company3 = Company.create(name: "Google", email: "google@email.com", program_language: "java")
company4 = Company.create(name: "Amazone", email: "amazone@email.com", program_language: "python")
company5 = Company.create(name: "Facebook", email: "facebook@email.com", program_language: "javascript")
company6 = Company.create(name: "Airbnb", email: "airbnb@email.com", program_language: "c")
company7 = Company.create(name: "Indeed", email: "indeed@email.com", program_language: "javascript")
company8 = Company.create(name: "Github", email: "github@email.com", program_language: "javascript")
company9 = Company.create(name: "Apple", email: "apple@email.com", program_language: "python")

user1 = User.create(first_name: 'David', last_name: 'Shin', email: 'david@email.com', contact: '145-577-5044' )

UserCompany.create(user_id: User.first.id, company_id: Company.first.id)