puts 'creating tables..'
UserCompany.destroy_all
Company.destroy_all
User.destroy_all

company1 = Company.create(name: "FlatIron School", email: "flatironschool@email.com", program_language: "ruby")
company2 = Company.create(name: "Triplebyte", email: "triplebyte@email.com", program_language: "ruby")
company3 = Company.create(name: "Google", email: "google@email.com", program_language: "java")
company4 = Company.create(name: "Amazone", email: "amazone@email.com", program_language: "python")
company5 = Company.create(name: "Facebook", email: "facebook@email.com", program_language: "javascript")
company6 = Company.create(name: "Airbnb", email: "airbnb@email.com", program_language: "C")
company7 = Company.create(name: "Indeed", email: "indeed@email.com", program_language: "javascript")
company8 = Company.create(name: "Github", email: "github@email.com", program_language: "javascript")
company9 = Company.create(name: "Apple", email: "apple@email.com", program_language: "python")

user1 = User.create(first_name: 'David', last_name: 'Shin', email: 'david@email.com', contact: '145-577-5044')
user2 = User.create(first_name: 'John', last_name: 'Dow', email: 'john@email.com', contact: '322-123-8411')

UserCompany.create(user_id: user1.id, company_id: company3.id)
UserCompany.create(user_id: user2.id, company_id: company3.id)