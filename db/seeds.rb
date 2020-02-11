require 'faker'
require_all 'lib'

david_shin = User.create(name: "David Shin", email: "david@email", contact: "111-222-3333")

companyA = Company.create(name: "FlatIron School", email: "flaironschool@email.com", program_language: "ruby")
companyB = Company.create(name: "Mcdonald", email: "mcdonald@email.com", program_language: "ruby")
companyC = Company.create(name: "Burger King", email: "burgerking@email.com", program_language: "java")
companyD = Company.create(name: "KFC", email: "kfc@email.com", program_language: "python")
companyE = Company.create(name: "Chipotle", email: "chipotle@email.com", program_language: "javascript")
companyF = Company.create(name: "Subway", email: "subway@email.com", program_language: "c")
companyG = Company.create(name: "Panera", email: "panera@email.com", program_language: "javascript")
companyH = Company.create(name: "Dunkin", email: "dunkin@email.com", program_language: "javascript")
companyI = Company.create(name: "Starbucks", email: "starbucks@email.com", program_language: "python")

