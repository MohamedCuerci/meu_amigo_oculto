class CreateWishList < ActiveRecord::Migration[7.1]
  def change
    create_table :wish_lists do |t|
      t.string :item
      t.text :description
      t.text :font_reference
      t.references :participant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
