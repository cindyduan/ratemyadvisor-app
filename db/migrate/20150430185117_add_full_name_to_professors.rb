class AddFullNameToProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :full_name, :string
  end
end
