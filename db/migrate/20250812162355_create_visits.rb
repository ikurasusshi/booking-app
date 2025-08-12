class CreateVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :visits do |t|
      t.string :visitor_name
      t.date :visit_on
      t.text :note
      t.references :user, null: false, foreign_key: true
      t.integer :created_by_id

      t.timestamps
    end
  end
end
