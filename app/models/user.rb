class User < ApplicationRecord
  has_many :reports

  enum :role, { citizen: "citizen", staff: "staff" }, default: "citizen"

  has_secure_password
end
