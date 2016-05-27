class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :picture_id, index: true
      t.integer :sender
      t.integer :receiver
      t.boolean :read, default:false

      t.timestamps
    end
  end
end
