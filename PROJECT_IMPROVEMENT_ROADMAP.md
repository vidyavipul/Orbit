# Orbit Improvement Roadmap

This document summarizes the project audit and provides the order in which Orbit should be improved before it is deployed as a public, resume-ready application.

## Current Assessment

Orbit has a solid Rails foundation, a clear project-management domain, role-based behavior, and a polished visual direction. However, it is not ready for public deployment yet because production configuration, CI, tests, authentication, authorization, and data isolation need work.

The goal is not merely to make the application deploy successfully. The finished project should be secure, reliable, easy to evaluate, safe for real users, and strong enough to discuss in interviews.

## Phase 1: Deployment and Security Blockers

- [x] Remove the committed PostgreSQL username/password from `config/database.yml`.
- [x] Read database credentials from `DATABASE_URL` or environment variables.
- [ ] Rotate the exposed development password if it is used anywhere else.
- [x] Add a safe `.env.example` or documented environment-variable list.
- [x] Correct production database configuration for the primary, cache, queue, and cable connections, or deliberately simplify to a primary-only setup.
- [x] Enable production HTTPS, secure cookies, host authorization, and an appropriate Content Security Policy.
- [x] Remove the state-changing `GET /logout` route.
- [x] Protect public login and signup endpoints with rate limiting.
- [x] Make production seed data safe and non-destructive.
- [x] Never deploy known public credentials with a fully privileged admin account.

Implementation note: Orbit uses one PostgreSQL database for its application,
Solid Cache, Solid Queue, and Solid Cable tables. This keeps the initial
deployment inexpensive and operationally simple; the infrastructure tables can
move to dedicated databases later if workload or isolation needs justify it.

## Phase 2: Repair CI and Build a Real Test Suite

- [ ] Add PostgreSQL to GitHub Actions and configure the test database correctly.
- [ ] Fix all RuboCop violations.
- [ ] Resolve the Brakeman role mass-assignment warning safely.
- [ ] Correct obsolete controller tests and nonexistent route helpers.
- [ ] Repair fixtures so they match the current schema and required associations.
- [ ] Add model tests for validations, scopes, enums, callbacks, and date behavior.
- [ ] Add authentication tests for login, logout, inactive users, session rotation, and redirect-back behavior.
- [ ] Add an authorization matrix covering Admin, Manager, and Employee access.
- [ ] Add request tests for every CRUD workflow and failure path.
- [ ] Add system tests for the main user journeys.
- [ ] Require green lint, security, test, and system-test jobs before deployment or dependency merging.

## Phase 3: Authentication and Authorization

- [ ] Call `reset_session` after login and logout to prevent session fixation.
- [ ] Prevent inactive users from logging in or continuing an existing session.
- [ ] Remember the originally requested URL and return there after login.
- [ ] Add forgot-password/reset-password functionality.
- [ ] Require the current password before a user changes their password.
- [ ] Decide whether public signup, invitation-only signup, or demo-only access is appropriate.
- [ ] Replace scattered controller checks with tested policy objects or a policy library.
- [ ] Prevent employees from accessing unassigned tasks through direct IDs.
- [ ] Prevent comments from bypassing task access rules.
- [ ] Ensure project pages do not expose tasks an employee is not allowed to view.
- [ ] Define whether managers may access all projects or only projects they own.
- [ ] Return a friendly and correct `403 Forbidden` response for denied access.

## Phase 4: Multi-Tenancy for Real Users

The current application has one global workspace. If unrelated teams sign up, they would share projects, tasks, comments, and the team directory.

- [ ] Add an `Organization` or `Workspace` model.
- [ ] Add memberships containing each user's role within a workspace.
- [ ] Add workspace ownership to projects, tasks, and related records.
- [ ] Add invitations for joining a workspace.
- [ ] Scope every query through the current workspace.
- [ ] Add tests proving that one workspace cannot access another workspace's data.

If Orbit remains a portfolio demo instead, clearly label it as a sandbox, use synthetic data, hide privileged admin access, and periodically reset demo data.

## Phase 5: Functional Correctness and Data Integrity

- [ ] Fix admin user-management forms so role and `is_active` can actually be changed.
- [ ] Do not log out an admin when the admin deletes another user.
- [ ] Define safe behavior for deleting users who own tasks or comments.
- [ ] Allow overdue tasks to be marked complete without failing due-date validation.
- [ ] Only validate dates when a date is created or changed.
- [ ] Use `Date.current`/`Time.current` consistently.
- [ ] Prevent task due dates from exceeding the project deadline when appropriate.
- [ ] Define project-completion rules when unfinished tasks remain.
- [ ] Restrict assignment choices to eligible active users.
- [ ] Sort priority in business order: High, Medium, Low.
- [ ] Preserve username/display-name capitalization while keeping login lookup case-insensitive.
- [ ] Generate employee codes safely under concurrent registrations.

### Database constraints

- [ ] Add unique indexes for normalized email, username, and employee code.
- [ ] Add `NOT NULL` constraints for required fields.
- [ ] Add check constraints for valid roles, statuses, and priorities.
- [ ] Add indexes for workspace IDs, statuses, deadlines, due dates, and priorities.
- [ ] Define intentional foreign-key and dependent-deletion behavior.

## Phase 6: Complete the Original Project Requirements

- [ ] Install and configure ActiveAdmin.
- [ ] Add ActiveAdmin resources for users, projects, tasks, and comments.
- [ ] Add an admin dashboard, filters, batch actions, and at least one custom action.
- [ ] Add CSV exports for users, projects, and tasks.
- [ ] Add user search, filtering, sorting, and pagination.
- [ ] Add sorting controls to the project and task interfaces.
- [ ] Complete dashboard statistics and recent-task sections.
- [ ] Add admin activation, deactivation, role change, and password-reset workflows.
- [ ] Use conventional `resources`, nested resources, and shallow routes.
- [ ] Complete the intended comment administration workflows.

## Phase 7: Performance and Maintainability

- [ ] Remove N+1 queries from task, project, comment, and dashboard pages using eager loading.
- [ ] Move reusable filtering and sorting into model scopes or query objects.
- [ ] Keep controllers focused on HTTP orchestration and move workflows into appropriate objects.
- [ ] Remove unused dependencies or implement the features that justify them.
- [ ] Move development-only gems such as debugging/pretty-printing tools out of production.
- [ ] Remove the unused Stimulus hello controller.
- [ ] Move, archive, or remove `prototype.html` once it is no longer needed.
- [ ] Split the large stylesheet into maintainable layout, component, and page files.
- [ ] Replace inline JavaScript with Stimulus controllers.
- [ ] Reduce inline styles and introduce reusable CSS components.

## Phase 8: UX and Accessibility

- [ ] Make the workspace layout, sidebar, tables, cards, filters, and task details responsive.
- [ ] Allow wide tables to scroll horizontally on small screens.
- [ ] Replace mouse-only clickable rows with accessible links.
- [ ] Add visible keyboard focus states and semantic navigation cues.
- [ ] Audit text and button color contrast against WCAG targets.
- [ ] Fix duplicate flash messages on the login page.
- [ ] Replace broken footer links and the missing `switchView` behavior.
- [ ] Implement or remove placeholder Pricing, About, Contact, Security, and demo controls.
- [ ] Add useful empty states with next-step actions.
- [ ] Make dashboard greetings time-aware or use a neutral greeting.
- [ ] Use Turbo Frames/Streams for task updates and comments where they improve the experience.

## Phase 9: Resume-Weight Features

Prioritize a few features that demonstrate backend engineering depth instead of adding many shallow features.

- [ ] Assignment and overdue notifications using Solid Queue.
- [ ] Activity/audit history showing who changed assignments, roles, and statuses.
- [ ] Live comments and task-status updates with Turbo Streams.
- [ ] Workspace invitations and tenant-isolation tests.
- [ ] Reporting and CSV export.
- [ ] Error tracking, structured logs, and request IDs.
- [ ] Health/readiness checks, uptime monitoring, backups, and rollback documentation.
- [ ] An architecture decision record explaining tenancy, authorization, jobs, and database choices.

## Phase 10: README and Repository Presentation

- [ ] Correct the documented database and demo credentials.
- [ ] Add the final hosted URL to the README and GitHub repository homepage.
- [ ] Add screenshots or a short product GIF.
- [ ] Add a feature and role-permission matrix.
- [ ] Document Ruby, Rails, PostgreSQL, setup, tests, security checks, and deployment commands.
- [ ] Add an architecture diagram and data model overview.
- [ ] Explain important engineering decisions and known limitations.
- [ ] Add CI/deployment badges.
- [ ] Add an open-source license if other people should be allowed to reuse the project.
- [ ] Add contribution and security-reporting guidance if the repository will accept outside use.

## Deployment Plan

Deploy only after the main branch has a green CI pipeline.

The production setup should include:

- A Rails web service
- Durable PostgreSQL storage
- Environment-managed secrets
- Automatic database migrations
- HTTPS and a custom or stable public domain
- Health checks and uptime monitoring
- Database backups
- Error reporting and structured logs
- A documented rollback process

Render is a straightforward Rails/PostgreSQL option, but free services have availability and persistence limitations. Select the final host based on the acceptable monthly budget and how reliably the resume link must remain available.

## Recommended Implementation Order

1. Secrets and production configuration
2. CI and test infrastructure
3. Authentication and authorization bugs
4. Database constraints and correctness fixes
5. Workspace/multi-tenancy decision
6. Missing original requirements
7. Performance and maintainability
8. Responsive and accessible UX
9. Resume-focused features
10. Documentation, observability, and deployment

## Definition of Deployment Ready

Orbit is ready to publish when:

- [ ] No real secrets are stored in Git.
- [ ] All CI jobs pass on `main`.
- [ ] Authentication and authorization paths have regression tests.
- [ ] Users cannot access another user's or workspace's restricted data.
- [ ] Database configuration and migrations work in production.
- [ ] Seed operations cannot accidentally erase production data.
- [ ] Core workflows work on desktop and mobile.
- [ ] HTTPS, health monitoring, logs, and backups are configured.
- [ ] The README contains accurate setup instructions, screenshots, demo access, and the live URL.
