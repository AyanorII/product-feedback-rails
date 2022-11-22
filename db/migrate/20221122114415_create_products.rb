class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :category
      t.integer :status, default: 0
      t.integer :upvotes, default: 0

      t.timestamps
    end
  end
end
