class User < ActiveRecord::Base
    has_many :usercompanies
    has_many :companies , through: :usercompanies

    PROMPT = TTY::Prompt.new
    
    def create(first_name: ,last_name: ,email:, contact:)
        user = User.new(first_name, last_name, email, contact)
        user.save
    end

    def validation_required(obj)
        if  obj == "contact"
            input = PROMPT.ask("What's your #{obj} #ex)123-456-7890 => 1234567890 ?", convert: :int, required: true)
         else
            input = PROMPT.ask("What's your #{obj}? **No space please") do |q|
            q.required true
            q.modify :remove
            q.messages[:require?] = "please enter your #{obj}"
            end
        end
        final_input = double_checking(input, obj)
        return final_input
    end

    def double_checking(result, obj)
        answer = PROMPT.yes?("Is your #{obj} is #{result}")
        case answer
        when true
            result
        when false
            puts "Let's do it again :-)"
            validation_required(obj)
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
            User_view.user_menu(user)
        end
    end

    def user_info
        self.first_name = validation_required("first name")
        self.last_name = validation_required("last name")
        self.contact = validation_required("contact")
        puts "Thank you for signing up!"
        self.save
        User_view.user_menu(self)
    end
end