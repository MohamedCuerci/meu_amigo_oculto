class RenameSecretSantaToSecretSantas < ActiveRecord::Migration[7.1]
  def change
    rename_table :secret_santa, :secret_santas
  end
end
