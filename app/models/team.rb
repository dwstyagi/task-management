class Team < ApplicationRecord
  acts_as_tenant :organisation
  has_many :team_members
  has_many :users, through: :team_members
  has_many :projects
end
