class AddMaximumNumberToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_column :secret_santas, :maximum_number, :integer
  end
end
