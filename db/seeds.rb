require 'faker'
require_all 'lib'

david_shin = User.create(name: "David Shin", email: "david@email", contact: "111-222-3333")

Flat_Iron_School = Company.create(name: "FlatIron School", email: "flaironschool@email.com", program_language: "ruby")

user_or_company_1 = User_Company.create(user_id: 1, company_id: 2)