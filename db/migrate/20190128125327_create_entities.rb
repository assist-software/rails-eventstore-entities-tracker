class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :entities do |t|
      t.string :uid
      t.string :name
      t.text :description
      t.integer :state
      t.text :extra_data, hash: true

      t.timestamps
    end
  end
end
