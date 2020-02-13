class CreateUsercompanyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_companies do |t|
      t.string :user_email
      t.string :company_email
    end
  end
end
