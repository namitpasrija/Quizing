class ChangestartTimeTostarttime < ActiveRecord::Migration
  def change
     rename_column :tests, :startTime, :starttime
     rename_column :tests, :endTime, :endtime
     rename_column :tests, :conductedBy, :conductedby
     rename_column :tests, :tType, :ttype

  end
end
