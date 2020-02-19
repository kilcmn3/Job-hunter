require_all 'db'

# david_shin = User.create(name: "David Shin", email: "david@email", contact: "111-222-3333")

companyA = Company.find_or_create_by(name: "FlatIron School", email: "flatironschool@email.com", program_language: "ruby")
companyB = Company.find_or_create_by(name: "Triplebyte", email: "triplebyte@email.com", program_language: "ruby")
companyC = Company.find_or_create_by(name: "Google", email: "google@email.com", program_language: "java")
companyD = Company.find_or_create_by(name: "Amazone", email: "amazone@email.com", program_language: "python")
companyE = Company.find_or_create_by(name: "Facebook", email: "facebook@email.com", program_language: "javascript")
companyF = Company.find_or_create_by(name: "Airbnb", email: "airbnb@email.com", program_language: "c")
companyG = Company.find_or_create_by(name: "Indeed", email: "indeed@email.com", program_language: "javascript")
companyH = Company.find_or_create_by(name: "Github", email: "github@email.com", program_language: "javascript")
companyI = Company.find_or_create_by(name: "Apple", email: "apple@email.com", program_language: "python")

# david = User.find_or_create_by(first_name: "david", last_name: "shin", email: "david@gmail.com", contact: 1234567890)