class Team < ApplicationRecord
  validates :team_id, uniqueness: true, presence: true
  validates :security_token, presence: true
end
