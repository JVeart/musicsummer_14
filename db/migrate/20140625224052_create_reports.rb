class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.string :name
      t.string :contest_link
      t.timestamps
    end
  end
end
