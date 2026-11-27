class CreateReportTags < ActiveRecord::Migration[8.1]
  def change
    create_table :report_tags do |t|
      t.references :report, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.string :source, null: false, default: "citizen"

      t.timestamps
    end
    add_index :report_tags, [ :report_id, :tag_id ], unique: true
  end
end
