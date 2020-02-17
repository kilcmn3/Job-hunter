class CreateUsercompanyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :usercompanies do |t|
      t.integer :user_id
      t.integer :company_id
    end
  end
end
