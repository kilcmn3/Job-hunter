puts "Welcome  to my User_create Test world!"
module User_view
    PROMPT = TTY::Prompt.new

    def User_view.main_screen 
        input= PROMPT.select("Choose your program lanaguage") do |menu|
            menu.choice 'Ruby'
            menu.choice 'Java'
            menu.choice 'Python'
            menu.choice 'JavaScript'
            menu.choice 'C'
        end
    end

    def after_main_screen
       input = User_view.main_screen
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
end