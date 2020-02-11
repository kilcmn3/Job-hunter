require_relative '../config/environment'


puts "Welcome  to my User_create Test world!"

def user_input
    puts "Enter your name"
     input_name = gets.chomp
     puts "Enter your email"
     input_email = gets.chomp
     puts "Enter your contact number"
     input_contact = gets.chomp

     User.create(name: input_name, email: input_email, contact: input_contact)
 end

 user_input
