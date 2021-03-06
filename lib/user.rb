class User < ActiveRecord::Base
    has_many :userCompanies
    has_many :companies , through: :userCompanies

    PROMPT = TTY::Prompt.new

    def self.validation_required(obj)
        if  obj == "contact"
            input = PROMPT.ask("What's your #{obj} #ex)123-456-7890 => 1234567890# ?",  required: true)
         else
            input = PROMPT.ask("What's your #{obj}? **No space please") do |q|
            q.required true
            q.modify :remove
            q.messages[:require?] = "please enter your #{obj}"
            end
        end
        final_input = self.double_checking(input, obj)
        return final_input
    end

    def self.double_checking(result, obj)
        answer = PROMPT.yes?("Is your #{obj} is #{result}")
        case answer
        when true
            result
        when false
            puts "Let's do it again :-)"
            self.validation_required(obj)
        end
    end

    def self.user_email
        input = PROMPT.ask("What's your email?") do |q|
            q.validate :email
            q.messages[:required?] = 'Please re-enter again'
            q.messages[:valid?] = 'Invalid email address'
        end
        user = User.find_by(email: input)
        
        if user == nil
            user = User.new(email: input)
            user.user_info
        else  
            UserView.user_menu(user)
        end
    end

    def user_info
        self.first_name = validation_required("first name")
        self.last_name = validation_required("last name")
        self.contact = validation_required("contact")
        puts "Thank you for signing up!"
        self.save
        UserView.user_menu(self)
    end
end