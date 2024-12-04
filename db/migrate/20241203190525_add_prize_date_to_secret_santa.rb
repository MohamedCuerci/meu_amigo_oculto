class AddPrizeDateToSecretSanta < ActiveRecord::Migration[7.1]
  def change
    add_column :secret_santas, :prize_date, :datetime
  end
end
