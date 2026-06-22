<div align="center">

# 🏛️ User Management System
### *Enterprise-grade Web Application built with Java Servlets, JSP & MySQL*

<br/>

[![Java](https://img.shields.io/badge/Java-23-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://openjdk.org/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-4E9BCD?style=for-the-badge&logo=eclipseide&logoColor=white)](https://jakarta.ee/)
[![Apache Tomcat](https://img.shields.io/badge/Apache%20Tomcat-10.0-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Eclipse IDE](https://img.shields.io/badge/Eclipse%20IDE-2024-2C2255?style=for-the-badge&logo=eclipse-ide&logoColor=white)](https://www.eclipse.org/)
[![License](https://img.shields.io/badge/License-MIT-22C55E?style=for-the-badge)](LICENSE)

<br/>

> A full-stack, production-ready **User Management System** built entirely on the classic Java EE stack — zero frameworks, pure **Servlet + JSP + JDBC** — demonstrating a clean MVC architecture with modular CRUD operations across 7 independent business modules.

<br/>

[🚀 Quick Start](#-quick-start) • [📐 Architecture](#-system-architecture) • [📦 Modules](#-modules) • [🗄️ Database](#️-database-schema) • [🚢 Deployment](#-deployment) • [📤 GitHub Setup](#-push-to-github)

</div>

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Tech Stack](#-tech-stack)
- [System Architecture](#-system-architecture)
- [Project Structure](#-project-structure)
- [Modules](#-modules)
- [Database Schema](#️-database-schema)
- [Quick Start](#-quick-start)
- [Deployment](#-deployment)
- [Push to GitHub](#-push-to-github)
- [Default Credentials](#-default-credentials)
- [API — Servlet URL Reference](#-servlet-url-reference)
- [Security Notes](#-security-notes)
- [License](#-license)

---

## 🌟 Overview

**UMS (User Management System)** is a multi-module web application that provides complete lifecycle management for Users and Persons along with supporting reference data. It was built to demonstrate a clean, layered Java EE architecture without any external web framework — every routing decision, every database call, and every rendered page is handled by hand-written Servlets and JSPs.

### ✨ Highlights

| Feature | Detail |
|---|---|
| 🔐 Authentication | Session-based login with admin + user roles |
| 🔑 Password Reset | OTP-based forgot password flow |
| 📸 File Upload | Profile image upload with `@MultipartConfig` |
| 📊 Data Tables | Interactive tables via DataTables.js |
| 🎨 Modern UI | Poppins font, gradient design, smooth animations |
| 🛡️ SQL Safety | `PreparedStatement` throughout all DB operations |
| 🔁 MVC Pattern | Clean separation of Model, View, Controller layers |
| 🗄️ Centralized DB | Single `DBConfig` class for all connections |

---

## 🛠️ Tech Stack

<table>
<tr>
<td><strong>Layer</strong></td>
<td><strong>Technology</strong></td>
<td><strong>Version</strong></td>
</tr>
<tr><td>Language</td><td>Java</td><td>23 (OpenJDK)</td></tr>
<tr><td>Runtime Spec</td><td>Jakarta EE (Servlet / JSP)</td><td>10.x</td></tr>
<tr><td>Server</td><td>Apache Tomcat</td><td>10.0.27</td></tr>
<tr><td>Database</td><td>MySQL</td><td>8.0.x</td></tr>
<tr><td>JDBC Driver</td><td>mysql-connector-j</td><td>9.4.0</td></tr>
<tr><td>Frontend</td><td>JSP + HTML5 + CSS3 + Vanilla JS</td><td>—</td></tr>
<tr><td>UI Library</td><td>DataTables.js</td><td>1.13.6</td></tr>
<tr><td>Fonts</td><td>Google Fonts (Poppins)</td><td>—</td></tr>
<tr><td>IDE</td><td>Eclipse IDE for Enterprise Java</td><td>2024+</td></tr>
</table>

---

## 📐 System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENT BROWSER                          │
│                    HTTP Request / Response                       │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                  Apache Tomcat 10 (Servlet Container)           │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │                    VIEW LAYER (JSP)                     │    │
│  │  signIn.jsp  │  adminIndex.jsp  │  personDashboard.jsp  │    │
│  │  registration.jsp  │  userDashboard.jsp  │  ...         │    │
│  └─────────────────────┬───────────────────────────────────┘    │
│                        │  forward / include                     │
│  ┌─────────────────────▼───────────────────────────────────┐    │
│  │               CONTROLLER LAYER (Servlets)               │    │
│  │                                                         │    │
│  │  LoginController    @WebServlet /login/LoginController  │    │
│  │  PersonController   @WebServlet /person/personCntrl     │    │
│  │  CityController     @WebServlet /city/cityCntrl         │    │
│  │  StateController    @WebServlet /state/stateCntrl       │    │
│  │  GenderController   @WebServlet /gender/genderCntrl     │    │
│  │  QualController     @WebServlet /qualification/...      │    │
│  │  StateCityController @WebServlet /statecity/...         │    │
│  └─────────────────────┬───────────────────────────────────┘    │
│                        │  calls                                 │
│  ┌─────────────────────▼───────────────────────────────────┐    │
│  │                  DAO LAYER (DBServices)                 │    │
│  │                                                         │    │
│  │  LoginDBService  │  PersonDBService  │  CityDBService   │    │
│  │  StateDBService  │  GenderDBService  │  QualDBService   │    │
│  │  StateCityDBService                                     │    │
│  └─────────────────────┬───────────────────────────────────┘    │
│                        │  JDBC                                  │
│  ┌─────────────────────▼───────────────────────────────────┐    │
│  │              DBConfig (Connection Factory)              │    │
│  │         jdbc:mysql://localhost:3306/ums                 │    │
│  └─────────────────────────────────────────────────────────┘    │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                        MySQL 8.x (ums)                          │
│   user │ person │ person_qualification │ dd_city │ dd_state     │
│   dd_gender │ dd_qualification │ statecity │ studentinfo        │
└─────────────────────────────────────────────────────────────────┘
```

### 🔄 Request Flow

```
User clicks "Save" →
  Browser POST →
    Servlet reads ?opr=save →
      DBService.insertRecord(DTO) →
        DBConfig.getConnection() →
          PreparedStatement executes SQL →
            response.sendRedirect(dashboard)
```

### 📋 Design Patterns Used

| Pattern | Implementation |
|---|---|
| **MVC** | JSP (View) + Servlet (Controller) + DTO (Model) |
| **DAO** | Every module has its own `*DBService` class |
| **DTO** | Plain Java objects transfer data between layers |
| **Front Controller** | Each module has one servlet handling all operations via `?opr=` |
| **Factory** | `DBConfig.getConnection()` centralizes connection creation |

---

## 📁 Project Structure

```
UMS_Production/
│
├── src/main/java/com/
│   ├── config/
│   │   └── DBConfig.java              ← Central JDBC connection factory
│   │
│   ├── login/
│   │   ├── LoginController.java       ← Auth, register, forgot pwd, CRUD
│   │   ├── LoginDBService.java        ← All user table queries
│   │   └── UserDTO.java               ← Serializable session object
│   │
│   ├── person/
│   │   ├── PersonController.java      ← Person CRUD + session guard
│   │   ├── PersonDBService.java       ← person + person_qualification queries
│   │   ├── PersonDTO.java
│   │   └── PersonQualification.java   ← Junction table DTO
│   │
│   ├── city/          → CityController, CityDBService, CityDTO
│   ├── state/         → StateController, StateDBService, StateDTO
│   ├── gender/        → GenderController, GenderDBService, GenderDTO
│   ├── qualification/ → QualificationController, QualificationDBService, QualificationDTO
│   ├── statecity/     → stateCityController, stateCityDBService, stateCityDTO
│   ├── service/       → UploadFile, DownloadFile, DeleteFile, DBConnection
│   └── nav/           → NavCntrl
│
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── web.xml                    ← Deployment descriptor
│   │   └── lib/
│   │       └── mysql-connector-j-9.4.0.jar
│   │
│   ├── adminIndex.jsp                 ← Admin control panel
│   ├── style.css                      ← Shared form styles
│   ├── dashboard.css                  ← Shared dashboard styles
│   │
│   ├── login/
│   │   ├── signIn.jsp                 ← Login page
│   │   ├── forgetPassword.jsp         ← OTP password reset
│   │   ├── userRegistration.jsp       ← New user form
│   │   ├── registrationSuccess.jsp
│   │   ├── userDashboard.jsp
│   │   ├── userEdit.jsp
│   │   └── viewUser.jsp
│   │
│   ├── person/    → registration, dashboard, edit, view
│   ├── city/      → addNew, dashboard, edit, view
│   ├── state/     → addNew, dashboard, edit, view
│   ├── gender/    → addNew, dashboard, edit, view
│   ├── qualification/ → addNew, dashboard, edit, view
│   └── statecity/ → addNew, dashboard, edit, view
│
├── build/classes/                     ← Compiled .class files (git-ignored)
├── umsDB.sql                          ← Full database dump with seed data
├── .gitignore
└── README.md
```

---

## 📦 Modules

### 🔐 Login & Authentication
- Admin login (`admin` / `123`) → redirects to Admin Panel
- Normal user login → validates against `user` table
- OTP-based password reset via `forgetPassword.jsp`
- Session management with 30-min timeout
- Logout invalidates session completely
- Duplicate username check on registration
- Profile image upload (stored in `/images/`)

### 👥 Person Management
- Full CRUD with session guard
- DOB picker, mobile + email validation
- Gender radio buttons (M / F / O)
- State + City dropdowns (from reference tables)
- Multi-select Qualification checkboxes
- Qualifications stored in `person_qualification` junction table
- View page resolves qualification codes → full names

### 👤 User Management
- Full CRUD for system users
- Status management (Active / Inactive)
- Profile image upload with filename stored in DB
- Password visible on edit (plain text — see Security Notes)

### 🗂️ Reference Data Modules
Each module (City, State, Gender, Qualification, State-City) provides:
- DataTables-powered sortable/searchable dashboard
- Add / Edit / View / Delete operations
- Centralized shared CSS for consistent UI

---

## 🗄️ Database Schema

```sql
-- ─────────────────── USERS ───────────────────
CREATE TABLE user (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    userId      VARCHAR(45) NOT NULL,
    user_name   VARCHAR(45),
    user_pwd    VARCHAR(45),
    encrypt_pwd VARCHAR(45),
    user_otp    VARCHAR(45),        -- used for password reset
    user_status VARCHAR(45),        -- 'active' | 'inactive'
    update_date DATE,
    update_time VARCHAR(45),
    update_by   VARCHAR(45),
    profileImg  VARCHAR(255)        -- filename only
);

-- ─────────────────── PERSONS ─────────────────
CREATE TABLE person (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(45),
    mobileNumber VARCHAR(45),
    emailId      VARCHAR(45),
    dob          DATE,
    gender       VARCHAR(45),       -- 'M' | 'F' | 'O'
    state        VARCHAR(45),       -- stores state code e.g. 'MP'
    city         VARCHAR(45)        -- stores city code e.g. 'BPL'
);

CREATE TABLE person_qualification (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    personId          INT,          -- FK → person.id
    qualificationCode VARCHAR(45)   -- FK → dd_qualification.code
);

-- ────────────── REFERENCE / DROPDOWN TABLES ──
CREATE TABLE dd_state        (id INT AUTO_INCREMENT PRIMARY KEY, code VARCHAR(45), value VARCHAR(45));
CREATE TABLE dd_city         (id INT AUTO_INCREMENT PRIMARY KEY, code VARCHAR(45), value VARCHAR(45), pincode INT);
CREATE TABLE dd_gender       (id INT AUTO_INCREMENT PRIMARY KEY, code VARCHAR(45), value VARCHAR(45));
CREATE TABLE dd_qualification(id INT AUTO_INCREMENT PRIMARY KEY, code VARCHAR(45), value VARCHAR(45));
CREATE TABLE statecity       (id INT AUTO_INCREMENT PRIMARY KEY, stateCode VARCHAR(45), cityCode VARCHAR(45));
```

### Entity Relationship

```
person ──< person_qualification >── dd_qualification
person >── dd_state   (via state code)
person >── dd_city    (via city code)
person >── dd_gender  (via gender code)
statecity >── dd_state + dd_city  (mapping)
```

---

## 🚀 Quick Start

### Prerequisites

| Tool | Version | Download |
|---|---|---|
| Java JDK | 17 / 21 / 23 | [OpenJDK](https://adoptium.net/) |
| Apache Tomcat | 10.x | [tomcat.apache.org](https://tomcat.apache.org/) |
| MySQL | 8.x | [mysql.com](https://dev.mysql.com/downloads/) |
| Eclipse IDE | 2023+ | [eclipse.org](https://www.eclipse.org/downloads/) |
| MySQL Workbench | 8.x | [mysql.com](https://dev.mysql.com/downloads/workbench/) |

### Step 1 — Import the Database

Open MySQL Workbench or run via command line:

```bash
# Create the database first
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ums;"

# Import all tables + seed data
mysql -u root -p ums < umsDB.sql
```

> **Workbench users:** Server → Data Import → select `umsDB.sql` → set Default Target Schema to `ums` → Start Import

### Step 2 — Configure Database Password

Open `src/main/java/com/config/DBConfig.java`:

```java
private static final String PASSWORD = "your_mysql_password";
```

### Step 3 — Import into Eclipse

```
File → Import → Existing Projects into Workspace
→ Select root directory: path/to/UMS_Production
→ Finish
```

### Step 4 — Add JAR to Build Path

In **Project Explorer**:
```
WEB-INF/lib/mysql-connector-j-9.4.0.jar
→ Right-click → Build Path → Add to Build Path
```

### Step 5 — Configure Tomcat Server

```
Window → Preferences → Server → Runtime Environments
→ Add → Apache Tomcat 10.x → Browse to Tomcat directory → Finish
```

### Step 6 — Run

```
Right-click project → Run As → Run on Server → Finish
```

🌐 Open: **`http://localhost:8080/UMS_Production/login/signIn.jsp`**

---

## 🚢 Deployment

### Deploy as WAR on any Tomcat Server

**Step 1 — Export WAR from Eclipse:**
```
Right-click project → Export → WAR file
→ Destination: /path/to/UMS_Production.war
→ Finish
```

**Step 2 — Deploy to Tomcat:**
```bash
# Copy WAR to Tomcat webapps folder
cp UMS_Production.war /opt/tomcat/webapps/

# Tomcat auto-deploys on detection
# Or restart Tomcat manually:
./bin/shutdown.sh && ./bin/startup.sh
```

**Step 3 — Access:**
```
http://your-server-ip:8080/UMS_Production/login/signIn.jsp
```

### Deploy on Cloud (AWS EC2 / Azure / DigitalOcean)

```bash
# 1. Install Java
sudo apt install openjdk-17-jdk -y

# 2. Install Tomcat
wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz
tar -xvf apache-tomcat-10.0.27.tar.gz
mv apache-tomcat-10.0.27 /opt/tomcat

# 3. Install MySQL
sudo apt install mysql-server -y
mysql -u root -p -e "CREATE DATABASE ums;"
mysql -u root -p ums < umsDB.sql

# 4. Drop WAR into webapps
cp UMS_Production.war /opt/tomcat/webapps/

# 5. Start Tomcat
/opt/tomcat/bin/startup.sh
```

> Open port **8080** in your cloud security group / firewall rules.

---

## 📤 Push to GitHub

### 🏷️ Recommended Repository Name
```
user-management-system-java
```

### 📝 Repository Description
```
A production-ready User Management System built with Java Servlets, JSP & MySQL — featuring MVC architecture, session-based auth, OTP password reset, file upload, and 7 CRUD modules. No frameworks. Pure Jakarta EE.
```

### 🏷️ Topics / Tags to add on GitHub
```
java  servlet  jsp  mysql  jdbc  tomcat  jakarta-ee  mvc  crud  user-management  java-web  eclipse
```

---

### Git Commands — Step by Step

Open **Git Bash** inside your project folder and run these commands **one by one**:

```bash
# ── Step 1: Navigate to your project folder ──
cd "D:/UMS_Workspace/UMS_Production"

# ── Step 2: Initialize git repository ──
git init

# ── Step 3: Add the .gitignore (IMPORTANT — do this before adding files) ──
# The .gitignore file is already in the project root

# ── Step 4: Stage all files ──
git add .

# ── Step 5: First commit ──
git commit -m "🎉 Initial commit: UMS - User Management System

- Java Servlet + JSP + MySQL MVC architecture
- 7 CRUD modules: Login, Person, City, State, Gender, Qualification, StateCity
- Session-based authentication with admin and user roles
- OTP-based forgot password reset
- Profile image upload support
- DataTables.js for interactive dashboards
- Centralized DBConfig connection factory
- PreparedStatement throughout for SQL injection prevention"

# ── Step 6: Create repo on GitHub first, then add remote ──
# Go to github.com → New Repository
# Name: user-management-system-java
# Description: (paste from above)
# Visibility: Public
# DO NOT check "Add README" (we have our own)
# Click Create Repository

# ── Step 7: Add remote origin ──
git remote add origin https://github.com/YOUR_USERNAME/user-management-system-java.git

# ── Step 8: Push to GitHub ──
git branch -M main
git push -u origin main
```

> Replace `YOUR_USERNAME` with your actual GitHub username.

---

## 🔑 Default Credentials

| Role | Username | Password | Access |
|---|---|---|---|
| **Admin** | `admin` | `123` | Full admin panel + all modules |
| **User** | *(register via UI)* | *(your choice)* | User dashboard |

> Admin credentials are hardcoded in `LoginController.java`. Change them before production use.

---

## 🌐 Servlet URL Reference

| Module | Operation | URL |
|---|---|---|
| **Login** | Sign In page | `GET /login/signIn.jsp` |
| **Login** | Authenticate | `POST /login/LoginController` |
| **Login** | Forgot Password | `GET /login/forgetPassword.jsp` |
| **Login** | Reset Password | `POST /login/LoginController?opr=resetPwd` |
| **Login** | Logout | `GET /login/LoginController?opr=logout` |
| **Users** | Dashboard | `GET /login/LoginController?opr=dashboard` |
| **Users** | Add New | `GET /login/LoginController?opr=addNew` |
| **Users** | Delete | `GET /login/LoginController?opr=delete&id={id}` |
| **Person** | Dashboard | `GET /person/personCntrl?opr=dashboard` |
| **Person** | Register | `GET /person/personCntrl?opr=addNew` |
| **Person** | Save | `POST /person/personCntrl?opr=save` |
| **Person** | Edit | `GET /person/personCntrl?opr=edit&id={id}` |
| **Person** | Delete | `GET /person/personCntrl?opr=delete&id={id}` |
| **City** | Dashboard | `GET /city/cityCntrl?opr=dashboard` |
| **State** | Dashboard | `GET /state/stateCntrl?opr=dashboard` |
| **Gender** | Dashboard | `GET /gender/genderCntrl?opr=dashboard` |
| **Qualification** | Dashboard | `GET /qualification/qualificationCntrl?opr=dashboard` |
| **State-City** | Dashboard | `GET /statecity/statecityCntrl?opr=dashboard` |

---

## 🔒 Security Notes

> This project is built for **educational and portfolio purposes**. For a real production system, apply these hardening steps:

| Risk | Current State | Recommended Fix |
|---|---|---|
| Plain text passwords | Stored as-is in `user_pwd` | Use BCrypt hashing |
| Hardcoded admin | `admin/123` in `LoginController.java` | Move to DB with hashed password |
| SQL Injection | ✅ `PreparedStatement` used everywhere | — |
| CSRF | ❌ No CSRF tokens on forms | Add CSRF token validation |
| Session Fixation | Basic session management | Call `invalidate()` before new session |
| Input Validation | Minimal HTML5 validation | Add server-side validation layer |

---

## 📊 Module Summary

```
UMS_Production
├── 28 Java source files
├── 35 JSP view files  
├── 14 CSS files (shared across modules)
├── 1  MySQL JAR (WEB-INF/lib)
├── 1  web.xml
└── 1  umsDB.sql (full schema + seed data)
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

```bash
# Fork → Clone → Branch → Commit → Push → Pull Request
git checkout -b feature/your-feature-name
git commit -m "✨ Add: your feature description"
git push origin feature/your-feature-name
```

---

## 📄 License

```
MIT License — Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software.
```

---

<div align="center">

**Built with ☕ Java &nbsp;|&nbsp; 🌐 JSP &nbsp;|&nbsp; 🗄️ MySQL &nbsp;|&nbsp; 🐱 Apache Tomcat**

<br/>

⭐ *If this project helped you, please consider giving it a star!* ⭐

</div>
