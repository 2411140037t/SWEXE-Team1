class RemovePhotoFromReports < ActiveRecord::Migration[8.1]
  def change
    remove_column :reports, :photo, :string
  end
end
