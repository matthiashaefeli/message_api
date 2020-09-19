class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :url
      t.integer :load
      t.integer :count, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
