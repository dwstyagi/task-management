class Task < ApplicationRecord
  belongs_to :project

  validates :name, :due_date, presence: true
  validate :due_date_is_futuristic
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  enum :priority, {high: 0, medium:1, low:2 }

  before_update :update_completed_at

  scope :incomplete_first, -> {order(completed_at: :desc)}
  scope :completed, -> {where(completed: true)}
  # def self.incomplete_first
  #   order(completed_at: :desc)
  # end

  def update_completed_at
    self.completed_at = if completed?
      Time.current
    end
  end

  def due_date_is_futuristic
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Must Be in Future")
    end
  end
end
