class Task < ApplicationRecord
  acts_as_tenant :organisation
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"
  belongs_to :project, touch: true
  belongs_to :assignee, class_name: "User", optional: true

  validates :name, :due_date, presence: true
  validate :due_date_is_futuristic
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  enum :priority, {high: 0, medium:1, low:2 }

  before_update :update_completed_at
  after_update :notify_urgent_task

  scope :incomplete_first, -> { order(completed_at: :desc) }
  scope :urgent, -> { where(due_date: (Time.current..24.hours.from_now)).where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :expired, -> { where("due_date < ? AND completed = ?", Date.current, false) }
  scope :pending, -> { where("due_date > ? AND completed = ?", Date.current, false) }

  # def self.incomplete_first
  #   order(completed_at: :desc)
  # end

  def notify_urgent_task
    UrgentTaskJob.perform_later
  end

  def update_completed_at
    self.completed_at = if completed?
      Time.current
    end
  end

  def urgent?
    (Time.current..24.hours.from_now).cover?(due_date) && !completed
  end

  def due_date_is_futuristic
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "Must Be in Future")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [
      "completed", "completed_at", "created_at", "due_date", "id", "name", "priority", 
      "project_id", "updated_at"
    ]
  end

  def expired?
    due_date < Date.current && !completed
  end
end
