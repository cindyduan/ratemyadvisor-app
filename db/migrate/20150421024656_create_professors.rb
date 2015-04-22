class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :first_name
      t.string :last_name
      t.string :netid
      t.string :department

      t.timestamps null: false
    end
  end
end
