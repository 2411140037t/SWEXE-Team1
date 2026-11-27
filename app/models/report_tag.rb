class ReportTag < ApplicationRecord
  belongs_to :report
  belongs_to :tag

  # citizen: 報告者が選んだ / staff: 職員が付け足した
  enum :source, { citizen: "citizen", staff: "staff" }, default: "citizen"

  validates :tag_id, uniqueness: { scope: :report_id }
end
