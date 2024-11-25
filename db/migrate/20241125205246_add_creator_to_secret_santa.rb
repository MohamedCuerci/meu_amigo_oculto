class AddCreatorToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_reference :secret_santa, :creator, null: false, foreign_key: { to_table: :users }
  end
end
