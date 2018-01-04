class ChangeddiffLevelTodifflevel < ActiveRecord::Migration
  def change
     rename_column :problems, :diffLevel, :difflevel
  end
end
