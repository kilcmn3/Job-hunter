require_relative '../config/environment'


def user_or_company 
    input = PROMPT.select("who are you user? or company?", %w(User Company))
    
    if input == "User"
        User_view.main_screen
    elsif input == "Company"
        company_input
    end
end

user_or_company

