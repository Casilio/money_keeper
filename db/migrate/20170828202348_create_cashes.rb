class CreateCashes < ActiveRecord::Migration[5.1]
  def change
    create_table :cashes do |t|
      t.decimal :value, precision: 9, scale: 2
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
