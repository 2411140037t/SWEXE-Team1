class User < ApplicationRecord
  has_many :reports

  enum :role, { citizen: "citizen", staff: "staff" }, default: "citizen"

  has_secure_password

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :email, presence: true, uniqueness: true
end
