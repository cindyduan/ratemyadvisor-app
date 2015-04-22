class AddIndexToProfessorsNetid < ActiveRecord::Migration
  def change
     add_index :professors, :netid, unique: true
  end
end
