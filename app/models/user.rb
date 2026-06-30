class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_validation :assign_employee_code, on: :create

  has_many :tasks
  has_many :comments

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 14 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  enum :role, admin: "admin", manager: "manager", employee: "employee"

  validates :employee_code, presence: true, uniqueness: true

  has_secure_password

  # Scopes
  scope :active,     -> { where(is_active: true) }
  scope :inactive,   -> { where(is_active: false) }
  scope :admins,     -> { where(role: "admin") }
  scope :managers,   -> { where(role: "manager") }
  scope :employees,  -> { where(role: "employee") }
  scope :recent,     -> { order(created_at: :desc) }

  private

  def assign_employee_code
    if employee_code.nil?
      last_code = User.maximum(:employee_code) || 1000
      self.employee_code = last_code + 1
    end
  end
end
