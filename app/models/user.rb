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

  # enum generates both instance and class methods(e.g, User.admin?)
  enum :role, admin: "admin", manager: "manager", employee: "employee", default: :employee

  validates :employee_code, presence: true, uniqueness: true

  has_secure_password

  # Scopes (class-methods, belongs to class not it's instance)
  scope :active,     -> { where(is_active: true) }
  scope :inactive,   -> { where(is_active: false) }
  scope :admins,     -> { where(role: "admin") }
  scope :managers,   -> { where(role: "manager") }
  scope :employees,  -> { where(role: "employee") }
  scope :recent,     -> { order(created_at: :desc) }

  # Instance Methods (belongs to instance, not available for the class)
  def full_name
    username
  end

  # Class Methods (belongs to class itself, and not it's instance)
  def self.active_count
    active.count
  end

  def self.employee_count
    employees.count
  end

  private

  def assign_employee_code
    if employee_code.nil?
      last_code = User.maximum(:employee_code) || 1000
      self.employee_code = last_code + 1
    end
  end
end
