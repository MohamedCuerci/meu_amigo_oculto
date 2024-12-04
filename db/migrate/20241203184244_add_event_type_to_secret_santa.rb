class AddEventTypeToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_column :secret_santas, :event_type, :integer, default: 0, null: false
  end
end
