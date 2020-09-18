class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message_id
      t.string :to_number
      t.string :message
      t.string :status, default: 'pending'

      t.timestamps
    end
  end
end
