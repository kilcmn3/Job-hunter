class CreateUsercompanyTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_companies do |t|
      t.string :user_id
      t.string :company_id
    end
  end
end
