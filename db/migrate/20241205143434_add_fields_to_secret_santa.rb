class AddFieldsToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_column :secret_santas, :address, :string
    add_column :secret_santas, :gift_value, :integer
    add_column :secret_santas, :winner, :string
  end
end
