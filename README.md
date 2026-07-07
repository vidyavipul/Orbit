<div align="center">
  <h1>🪐 Orbit</h1>
  <p><strong>A Modern Project Management Platform Built on Rails 8</strong></p>
</div>

---

## ✨ Overview

Orbit is a sleek and intuitive project management application designed to help teams collaborate effectively. It allows managers to create projects, assign tasks to employees, and track progress—all within a clean, modern interface.

## 🚀 Key Features

* **Role-Based Access Control**: Secure roles for Admins, Managers, and Employees.
* **Project Tracking**: Manage multiple projects, track deadlines, and monitor active statuses.
* **Task Management**: Assign tasks, set priorities, and update statuses seamlessly.
* **Team Collaboration**: Integrated task commenting system to keep everyone in the loop.
* **Modern Dashboard**: Real-time overview of active projects, overdue tasks, and user assignments.

## 🛠 Tech Stack

* **Backend**: Ruby on Rails 8.1
* **Database**: SQLite / PostgreSQL (via ActiveRecord)
* **Frontend**: Custom CSS Variables + Hotwire (Turbo & Stimulus)
* **Design**: Bespoke Earth Tones & Modern Workspace Layouts

## ⚙️ Quick Start

Follow these steps to run Orbit locally:

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Setup the database:**
   ```bash
   rails db:create db:migrate db:seed
   ```

3. **Start the server:**
   ```bash
   bin/rails server
   ```

4. **Visit the app:**
   Open your browser and navigate to `http://localhost:3000`.

## 🔒 Default Accounts (If using db:seed)

* **Admin**: `admin@example.com` / `Password123!`
* **Manager**: `manager@example.com` / `Password123!`
* **Employee**: `employee@example.com` / `Password123!`

---
<div align="center">
  <small>Built with ❤️ using Ruby on Rails.</small>
</div>
