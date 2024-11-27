class AddFieldsToUserPreference < ActiveRecord::Migration[7.1]
  def change
    add_column :user_preferences, :phone, :string
    add_column :user_preferences, :cpf, :string
    add_column :user_preferences, :cep, :string
  end
end
