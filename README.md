# Multitenant Task Management System 📊🔧

## Description
This Rails 7 application is a comprehensive task management system with multitenancy support. It allows organizations to manage teams, projects, and tasks efficiently within isolated environments.

## Features
- 🏢 **Multitenancy**: Each organization has its own isolated environment, accessed via subdomains
- 👥 **User Management**: 
  - Custom registration process for creating new organizations
  - Invite system for adding users to existing organizations
- 🔐 **Role-based Access Control**: 
  - Organization owners have full access
  - Team leaders can manage their teams and projects
  - Team members have limited access based on assignments
- 📝 **Project and Task Management**: 
  - Create and assign tasks within projects
  - Set deadlines for tasks
- 🔔 **Notifications**: 
  - Automatic notifications for tasks nearing their deadline (within 24 hours)
- 🔍 **Search Functionality**: Efficient task searching using background jobs

## Technology Stack
- 💎 Ruby on Rails 7
- 🐘 PostgreSQL
- 🔒 Devise for authentication
- 🏢 Acts_as_tenant for multitenancy
- 👤 Rolify for role management
- 📢 Noticed for notifications
- ⚙️ Good Job for background processing
- 🎨 Tailwind CSS for styling

## 🚀 Installation Guide

### Prerequisites
- Ruby 3.2.0 or newer
- PostgreSQL
- Node.js and Yarn

### Step-by-Step Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/multitenant-task-management.git
   cd multitenant-task-management

2. **Install Dependencies**
   ```bash
   bundle install
   yarn install

3. **Setting up the database**
   ```bash
   rails db:create db:migrate db:seed

4. **Install Dependencies**
   ```bash
   bundle install
   yarn install

5. **Pre Compile Assets**
   ```bash
   rails assets:precompile

6. **Start the Rails Server**
   ```bash
   rails server
