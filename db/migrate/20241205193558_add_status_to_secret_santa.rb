class AddStatusToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_column :secret_santas, :status, :integer, default: 0, null: false
  end
end
