class RenameDescripionToDescriptionOnReports < ActiveRecord::Migration[8.1]
  def change
    rename_column :reports, :descripion, :description
  end
end
