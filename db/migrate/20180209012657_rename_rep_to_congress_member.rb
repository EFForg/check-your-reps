class RenameRepToCongressMember < ActiveRecord::Migration[5.1]
  def change
    rename_table :reps, :congress_members
    rename_column :scores, :rep_id, :congress_member_id
  end
end
