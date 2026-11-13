class Report < ApplicationRecord
  belongs_to :user
  belongs_to :town

  has_one_attached :photo

  enum :ear_tip, { left: "left", right: "right", both: "both", none: "none", unknown: "unknown" }, default: "unknown", prefix: true
  enum :status, { pending: "pending", approved: "approved", rejected: "rejected" }, default: "pending"
end
