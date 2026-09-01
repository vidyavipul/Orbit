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

### Environment variables

Database credentials are configuration, not source code. Orbit reads local PostgreSQL settings from `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_USER`, and `POSTGRES_PASSWORD`. Production uses the hosting provider's `DATABASE_URL`.

Use [`.env.example`](.env.example) as the variable list for your shell, environment manager, or hosting platform. Rails does not load `.env` files by itself, and real values must never be committed.

Production also requires `RAILS_MASTER_KEY` and `APP_HOST`. The optional `SOLID_QUEUE_IN_PUMA=true` setting runs the background-job supervisor with the web process, which is suitable for an initial small deployment.

## 🔒 Local demo accounts

Running `db:seed` outside production rebuilds the local database with synthetic demo data. These credentials are never created by production seeds:

* **Admin**: `admin@orbit.com` / `password123`
* **Manager**: `marcus@orbit.com` / `password123`
* **Employee**: `employee1@orbit.com` / `password123`

Production seeds never delete data. An initial admin is created only when the three `ORBIT_ADMIN_*` variables documented in [`.env.example`](.env.example) are present, and an existing account is never overwritten.

---
<div align="center">
  <small>Built with ❤️ using Ruby on Rails.</small>
</div>
