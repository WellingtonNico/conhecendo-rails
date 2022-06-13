class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name, limit: 50, null: false
      t.string :email, limit: 100, index:{unique: true}
      t.string :password, limit: 100
      t.date :born_at
      t.boolean :admin

      t.timestamps
    end
  end
end
