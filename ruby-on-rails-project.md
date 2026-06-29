# Ruby on Rails Assessment Project: Employee Task & Project Management System

## Objective
Build a complete Ruby on Rails application that demonstrates your understanding of Rails fundamentals, best practices, MVC architecture, authentication, authorization, Active Record, ActiveAdmin, and clean code principles.

The application should follow the "Fat Model, Skinny Controller" approach and Rails conventions.

## Project Overview
A company wants an internal web application where employees can manage projects and tasks.

There are three types of users:
- **Admin**
- **Manager**
- **Employee**

Employees work on projects and complete tasks assigned to them. Managers can create projects and assign tasks to employees. Admins can manage the entire system through both the normal application and an ActiveAdmin panel.

---

## Roles & Permissions

### Admin
**Can:**
- Manage Users
- Manage Projects
- Manage Tasks
- Manage Comments
- View Dashboard
- Access ActiveAdmin Panel
- Activate/Deactivate Users
- Change User Roles
- Delete Any Record
- Export Reports

### Manager
**Can:**
- Create Projects
- Edit Own Projects
- Assign Tasks
- View Team Tasks
- Add Comments

**Cannot:**
- Access ActiveAdmin
- Delete Users

### Employee
**Can:**
- Login
- View Assigned Tasks
- Update Task Status
- Add Comments
- Edit Own Profile

**Cannot:**
- Create Projects
- Access ActiveAdmin

---

## Authentication
Implement your own session-based authentication (**Do not use Devise**).

### Features
- Register
- Login
- Logout
- Change Password
- Edit Profile

### Requirements
- Password hashing using `has_secure_password`
- Session-based login
- Store current user
- Logout
- Protect routes
- Remember requested URL: After successful login redirect user back to the originally requested page.

#### Example
1. User opens `/projects/10/tasks` without login.
2. Redirect to login.
3. Login successful.
4. Redirect back to `/projects/10/tasks`.

---

## Authorization
- Use role-based authorization.
- Only Admin can access `/admin`.
- Managers and Employees should receive `403 Forbidden` or `Access Denied`.
- Protect all routes using `before_action`.

---

## Models
Create the following models.

### User
#### Fields
- `name`
- `email`
- `password_digest`
- `role`
- `active`
- `employee_code`

#### Associations
- `has_many :tasks`
- `has_many :comments`

#### Validations
- Presence
- Uniqueness
- Length
- Email format

#### Callbacks
- Normalize email `before_validation`
- Generate `employee_code` `before_create`

#### Scopes
- `active`
- `inactive`
- `admins`
- `managers`
- `employees`
- `recent`

#### Model Methods
- `admin?`
- `manager?`
- `employee?`
- `active?`
- `full_name`

#### Class Methods
- `active_count`
- `employee_count`

### Project
#### Fields
- `title`
- `description`
- `deadline`
- `status`

#### Associations
- `has_many :tasks`

#### Validations
- Presence
- Deadline cannot be in past

#### Scopes
- `active`
- `completed`
- `overdue`
- `latest`

#### Model Methods
- `completed?`
- `overdue?`

#### Class Methods
- `overdue_count`

### Task
#### Fields
- `title`
- `description`
- `priority`
- `status`
- `due_date`
- `project_id`
- `user_id`

#### Associations
- `belongs_to :project`
- `belongs_to :user`
- `has_many :comments`

#### Validations
- Presence
- Due date validation

#### Scopes
- `pending`
- `completed`
- `overdue`
- `due_today`
- `high_priority`

#### Model Methods
- `completed?`
- `overdue?`
- `mark_complete`
- `display_status`

#### Class Methods
- `completed_percentage`

### Comment
#### Fields
- `body`
- `task_id`
- `user_id`

#### Associations
- `belongs_to :task`
- `belongs_to :user`

#### Validations
- Presence

---

## CRUD Modules
- Complete CRUD should be available for:
  - Users
  - Projects
  - Tasks
  - Comments
- Follow RESTful routes.

### Nested Resources
Use nested routes.
**Example:**
- Project
  - Tasks
    - Comments

---

## Dashboard
After login display dashboard.
Dashboard should show:
- Total Users
- Total Projects
- Total Tasks
- Completed Tasks
- Pending Tasks
- Overdue Tasks
- My Assigned Tasks
- Recent Projects
- Recent Tasks

---

## Search
Implement search using params.
- Search Users
- Search Projects
- Search Tasks

---

## Filtering
Provide filters:
- **Tasks**: Pending, Completed, Overdue, High Priority
- **Projects**: Active, Completed, Overdue
- **Users**: Active, Inactive, Managers, Employees

---

## Sorting
Support sorting:
- **Tasks**: Latest, Oldest, Due Date, Priority
- **Projects**: Latest, Deadline
- **Users**: Name, Created Date

---

## Pagination
Use pagination. You may use:
- Kaminari
- Pagy

---

## Flash Messages
Display proper flash messages.
**Examples:**
- User created successfully.
- Project updated.
- Task completed.
- Invalid email or password.
- Access denied.

---

## Views
Use layouts and partials properly.
**Examples:**
- `shared/`
  - `_navbar`
  - `_sidebar`
  - `_flash`
- `tasks/`
  - `_form`
- `projects/`
  - `_form`
- `users/`
  - `_form`
- Render collections where appropriate.

---

## Helpers
Move presentation logic into helpers.
**Examples:**
- `format_date()`
- `status_badge()`
- `priority_badge()`
- `truncate_text()`
- `page_title()`

**Helpers should NOT:**
- Query database
- Perform authorization
- Contain business logic

---

## Controller Concerns
Create reusable concerns:
- **Authenticatable**
  - Methods: `current_user`, `logged_in?`, `require_login`, `store_location`, `redirect_back_or_default`
- **Authorizable**
  - Methods: `require_admin`, `require_manager`, `authorize_user`
- Use these concerns in controllers.

---

## Controllers
Controllers should only:
- Load data
- Call model methods
- Render
- Redirect

Do NOT write business logic inside controllers.
- **Bad:** `if task.due_date < Date.today`
- **Good:** `task.overdue?`

---

## Fat Model, Skinny Controller
Business logic belongs inside models.
**Examples:**
- **Bad:** `Task.where(status: "Pending").order(created_at: :desc)`
- **Good:** `Task.pending.latest`
- **Bad:** `if current_user.role == "admin"`
- **Good:** `current_user.admin?`

---

## Validations
Use:
- Presence
- Uniqueness
- Length
- Format
- Numericality (where applicable)
- Comparison
- Custom validation (e.g., Task due date cannot be earlier than today)

---

## Callbacks
Use callbacks only where appropriate.
**Examples:**
- `before_validation`: Normalize email
- `before_create`: Generate employee code
- `after_create`: (Optional) Send welcome email

---

## Scopes
Create meaningful scopes.
**Examples:**
- **User**: `active`, `inactive`, `admins`, `employees`
- **Task**: `pending`, `completed`, `overdue`, `due_today`, `latest`
- **Project**: `completed`, `overdue`

---

## Model Methods
**Examples:**
- **User**: `admin?`, `manager?`, `employee?`
- **Task**: `overdue?`, `completed?`, `mark_complete()`
- **Project**: `completed?`

---

## Class Methods
**Examples:**
- `Task.completed_percentage`
- `Project.overdue_count`
- `User.active_count`

---

## Routes
Use proper RESTful routing. Use:
- `resources`
- nested resources
- member routes
- collection routes
- root route

---

## Error Handling
Handle:
- 403
- 404
- Display user-friendly pages.

---

## ActiveAdmin
Install and configure ActiveAdmin.
- Only Admin users should be able to access `/admin`.
- Managers and Employees should not have access.

### ActiveAdmin Resources
Create ActiveAdmin resources for:
- Users
- Projects
- Tasks
- Comments

### ActiveAdmin Dashboard
Dashboard should display:
- Total Users
- Total Projects
- Total Tasks
- Completed Tasks
- Pending Tasks
- Overdue Tasks
- Latest Users
- Latest Projects
- Latest Tasks

### ActiveAdmin User Management
Admin should be able to:
- Create User
- Update User
- Delete User
- Activate User
- Deactivate User
- Change Role
- Reset Password

#### Filters
- Role
- Status
- Created Date
- Email

#### Search
- Name
- Email
- Customize index page.

### ActiveAdmin Project Management
- CRUD
- Filters: Status, Deadline
- Batch Actions: Delete, Archive, Mark Completed

### ActiveAdmin Task Management
- CRUD
- Filters: Priority, Status, Project, Employee
- Batch Actions: Complete Selected, Delete Selected, Assign Selected

### ActiveAdmin Comment Management
- CRUD

### ActiveAdmin Customizations
Use:
- `permit_params`
- `filters`
- `scopes`
- `index`
- `show`
- `form`
- `sidebar`
- `actions`

Implement at least one custom `member_action` (e.g., Suspend User).
Implement at least one custom `collection_action` (e.g., Export CSV).

### CSV Export
Admin should be able to export:
- Users
- Projects
- Tasks

---

## Bonus Features (Optional)
- Soft Delete
- Activity Log / Audit Trail
- Avatar Upload
- Slug URLs
- Turbo Frames / Turbo Streams
- AJAX Comments
- CSV Import
- Dark Mode

---

## Code Quality Requirements
- Your application should follow Rails best practices.
- Follow MVC architecture.
- Follow Fat Model, Skinny Controller.
- Use meaningful model methods.
- Use scopes instead of repeating queries.
- Reuse code using concerns.
- Reuse forms using partials.
- Use helper methods only for presentation logic.
- Use strong parameters.
- Use `before_action` appropriately.
- Keep controllers small and clean.
- Write readable and maintainable code.
- Follow RESTful conventions.
- Avoid duplicate code.
- Use meaningful commit messages (if using Git).

---

## Expected Folder Structure
```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── users_controller.rb
│   ├── projects_controller.rb
│   ├── tasks_controller.rb
│   ├── comments_controller.rb
│   └── concerns/
│       ├── authenticatable.rb
│       └── authorizable.rb
├── helpers/
│   ├── application_helper.rb
│   ├── tasks_helper.rb
│   └── users_helper.rb
├── models/
│   ├── user.rb
│   ├── project.rb
│   ├── task.rb
│   └── comment.rb
└── views/
    ├── shared/
    │   ├── _navbar.html.erb
    │   ├── _sidebar.html.erb
    │   └── _flash.html.erb
    ├── users/
    ├── projects/
    ├── tasks/
    └── comments/
admin/
├── users.rb
├── projects.rb
├── tasks.rb
├── comments.rb
└── dashboard.rb
```

---

## Evaluation Criteria (100 Marks)

| Category | Marks |
| :--- | :--- |
| Routes & RESTful Design | 10 |
| Models (Associations, Validations, Scopes, Methods, Callbacks) | 20 |
| Controllers (RESTful, Thin Controllers) | 10 |
| Views (Layouts, Partials, Forms) | 10 |
| Authentication | 10 |
| Authorization | 10 |
| Helpers & Concerns | 10 |
| ActiveAdmin Configuration & Customization | 10 |
| Code Quality & Rails Best Practices | 10 |

---

## Submission Requirements
Submit the project with:
- Source code in a Git repository.
- `README.md` containing:
  - Project setup instructions
  - Ruby version
  - Rails version
  - Database configuration
  - Commands to run the project
  - Default admin credentials (if seeded)
- A `db/seeds.rb` file that creates sample data:
  - 1 Admin
  - 2 Managers
  - 5 Employees
  - Multiple Projects
  - Multiple Tasks
  - Multiple Comments

The application should be fully functional, follow Rails conventions, and demonstrate a clear understanding of Ruby on Rails fundamentals and best practices.
