class CreateUserPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :user_preferences do |t|
      t.string :nickname
      t.string :age
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end