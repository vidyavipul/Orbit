class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  enum :status, active: "active", completed: "completed", default: :active

  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  # Deadline cannot be in past
  validate :deadline_cannot_be_in_the_past

  # Scopes
  scope :overdue, -> { where("deadline < ?", Time.current).where.not(status: "completed") }
  scope :latest, -> { order(created_at: :desc) }


  # Class Methods
  def overdue?
    deadline.present? && deadline < Time.current && !completed?
  end

  def self.overdue_count
    overdue.count
  end

  private

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Time.current
      errors.add(:deadline, "can't be in the past")
    end
  end
end
