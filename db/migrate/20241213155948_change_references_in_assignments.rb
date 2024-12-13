class ChangeReferencesInAssignments < ActiveRecord::Migration[7.1]
  def change
    # Remove as referências antigas
    remove_reference :assignments, :giver, foreign_key: { to_table: :users }
    remove_reference :assignments, :receiver, foreign_key: { to_table: :users }

    # Adiciona as novas referências
    add_reference :assignments, :giver, null: false, foreign_key: { to_table: :participants }
    add_reference :assignments, :receiver, null: false, foreign_key: { to_table: :participants }
  end
end
