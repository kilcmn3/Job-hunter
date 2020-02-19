class Createcompany < ActiveRecord::Migration[5.2]
  def change
    create_table :comapnies do |t|
      t.string :name
      t.string :email
      t.string :program_language
    end
  end
end
