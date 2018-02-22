class AddTwitterIdToCongressMember < ActiveRecord::Migration[5.1]
  def change
    add_column :congress_members, :twitter_id, :string
  end
end
