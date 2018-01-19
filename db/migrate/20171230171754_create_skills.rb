class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string :category_type
      t.string :skill_type
      t.integer :perk
      t.integer :day_hour
      t.string :skill_name
      t.text :summary
      t.string :portfolio
      t.string :address
      t.boolean :is_skype
      t.boolean :is_ip
      t.boolean :is_discord
      t.boolean :is_steam
      t.boolean :is_fi
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
