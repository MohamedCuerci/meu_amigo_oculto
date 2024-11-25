class CreateSecretSanta < ActiveRecord::Migration[7.1]
  def change
    create_table :secret_santa do |t|
      t.string :name
      t.string :code
      t.text :description

      t.timestamps
    end

    add_index :secret_santa, :code, unique: true
    add_index :secret_santa, :name
  end
end
