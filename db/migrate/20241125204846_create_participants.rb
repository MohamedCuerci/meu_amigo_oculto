class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :secret_santa, null: false, foreign_key: true

      t.timestamps
    end

    add_index :participants, [:user_id, :secret_santa_id], unique: true
  end
end
