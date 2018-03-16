class RemoveScorePositionDefault < ActiveRecord::Migration[5.1]
  def up
    change_column :scores, :position, :string, default: nil
  end

  def down
    change_column :scores, :position, :string, default: Score::DEFAULT_POSITION

    Score.where.not(position: Score::POSITIONS).find_each do |score|
      score.repair_position
    end
  end
end
