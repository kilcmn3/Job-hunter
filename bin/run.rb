require_relative '../config/environment'


puts "Welcome  to my User_create Test world!"
def user_or_company 
    puts "who are you user? or company?"
    input = gets.chomp
    if input == "user"
        user_input
    elsif input == "company"
        company_input
    else
    puts "try it again please"
    end

end

def user_input
    puts "Enter your name"
     input_name = gets.chomp
     puts "Enter your email"
     input_email = gets.chomp
     puts "Enter your contact number"
     input_contact = gets.chomp

     User.create(name: input_name, email: input_email, contact: input_contact)
 end

def company_input
    puts "hello you are in company site"
end

user_or_company