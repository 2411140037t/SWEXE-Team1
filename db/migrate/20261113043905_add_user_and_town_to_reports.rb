class AddUserAndTownToReports < ActiveRecord::Migration[8.1]
  def change
    add_reference :reports, :user, null: false, foreign_key: true
    add_reference :reports, :town, null: false, foreign_key: true
  end
end
