class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, limit: 100, null: false
      t.date :published_at, null: false
      t.text :text, null: false
      # precision é a quantidade de números que será possível ter
      # scale é a quantidade de números decimais
      # sendo precision = 10 e scale = 2, temos um máximo de 8 números antes 
      # da vírgula
      t.decimal :value, precision: 10, scale: 2, null: false
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
