require 'faker'
require_all 'lib'

david_shin = User.create(name: "David Shin", email: "david@email", contact: "111-222-3333")

Flat_Iron_School = Company.create(name: "FlatIron School", email: "flaironschool@email.com", program_language: "ruby")