class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.datetime :date
      t.text :text
      t.timestamps
    end
  end
end
