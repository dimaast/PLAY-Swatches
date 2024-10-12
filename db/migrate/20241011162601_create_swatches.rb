class CreateSwatches < ActiveRecord::Migration[7.2]
  def change
    create_table :swatches do |t|
      t.string :name
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
