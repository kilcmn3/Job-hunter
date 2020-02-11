require_relative '../config/environment'

puts "Welcome  to my User_create Test world!"
def user_or_company 
    prompt = TTY::Prompt.new
    input = prompt.select("who are you user? or company?", %w(User Company))

    if input == "User"
        user_input
    elsif input == "Company"
        company_input
    end
end

def user_input
     puts "Enter your email"
     input_email = gets.chomp
     finder = User.user_find_email(input_email)
     if finder == nil
        puts "Enter your name"
         input_name = gets.chomp
         puts "Enter your contact number"
         input_contact = gets.chomp
    
         User.create(name: input_name.downcase, email: input_email.downcase, contact: input_contact)
     else
        puts "Welcome back #{finder.name}!"
     end
 end

def company_input
    puts "hello you are in company site"
end

# user_or_company
user_or_company