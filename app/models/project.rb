class Project < ApplicationRecord
  acts_as_tenant :organisation
  belongs_to :team, optional: true
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: :organisation_id, case_sensitive: false}
  broadcasts_refreshes
end
