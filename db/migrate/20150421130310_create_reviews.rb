class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :student_netid
      t.string :student_class
      t.string :professor_netid
      t.string :relationship
      t.integer :availability
      t.integer :responsiveness
      t.integer :knowledge
      t.integer :organization
      t.integer :friendliness
      t.integer :helpfulness
      t.text :comments
      t.references :professor, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :reviews, [:professor_id, :created_at]
  end
end
