class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.datetime :seen_at
      t.string :ear_tip
      t.string :trouble
      t.text :descripion
      t.string :photo
      t.float :gps_latitude
      t.float :gps_longitude
      t.float :reported_latitude
      t.float :reported_longitude
      t.string :status
      t.string :reject_reason

      t.timestamps
    end
  end
end
