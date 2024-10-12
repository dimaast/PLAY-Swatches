class CreateFills < ActiveRecord::Migration[7.2]
  def change
    create_table :fills do |t|
      t.string :name
      t.string :color
      t.references :swatch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
