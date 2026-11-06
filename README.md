# Student Placement Data Analysis System

A comprehensive web application designed for engineering colleges to manage student records, placement drives, and perform in-depth statistical analytics on department-wise outcomes, salary package distributions, and student technical skill demand.

---

## 🛠️ Complete Tech Stack

| Layer | Technologies |
| :--- | :--- |
| **Frontend** | **HTML5**, **CSS3**, **JavaScript** (Vanilla JS, Fetch API, Chart.js) |
| **Backend** | **Python 3**, **Flask** REST API (`Flask-CORS`) |
| **Data Analytics** | **Pandas** & **NumPy** for descriptive statistical calculations |
| **Visual Reports** | **Matplotlib** for server-side chart rendering & downloadable PNG exports |
| **Database** | **MySQL 8** Relational Database (SQLAlchemy ORM + `pymysql` driver) |

> **Zero Node.js/NPM Dependency**: The entire frontend is written in pure HTML, CSS, and modern JavaScript. No build step, webpack, or Node.js required!

---

## 📋 Conformance to Specification Requirements

This project strictly adheres to all specified project guidelines:

### 1. Relational Entities / MySQL Tables
The relational schema is defined in [backend/schema.sql](file:///d:/Project/python%20project/backend/schema.sql) and mapped via SQLAlchemy in [backend/models.py](file:///d:/Project/python%20project/backend/models.py):
- `students(student_id, roll_no, department, graduation_year)` *(plus `student_name`, `sub_branch`, `eligible`)*
- `skills(skill_id, skill_name)`
- `student_skills(student_id, skill_id)` *(Foreign keys with cascading updates/deletes)*
- `placements(placement_id, student_id, company, role, package, placement_date, status)` *(accepts both `package` and `package_lpa`)*

### 2. Data Analysis & Visualization
- **Pandas**: Placement-rate summaries, skill frequency distributions, department cross-tabulations.
- **NumPy**: Median, mean, min, max package calculations (`np.mean`, `np.median`, `np.histogram`).
- **Matplotlib**: Server-rendered charts exported on-demand (`/api/reports/charts/department.png`, `/api/reports/charts/package.png`, `/api/reports/charts/skills.png`).

### 3. Expected Outputs
- **Placement-Rate Report**: Calculated per cohort using the documented eligible denominator.
- **Department Comparison**: Department and sub-branch breakdown of student counts, eligibility, placement ratios, and top packages.
- **Package Summary**: Central tendency statistics (mean, median), salary range tiers (`< 4 LPA`, `4–7 LPA`, `7–10 LPA`, `10–15 LPA`, `15–25 LPA`, `> 25 LPA`), and distribution histograms.
- **Skill-Demand Report**: Most common student technical skills, frequency in placements, and placed vs. unplaced cohort comparison.

### 4. Acceptance Criteria Verification
- **Package Units Documented**: All salary packages are strictly measured and displayed in **LPA (Lakhs Per Annum)**.
- **Placement Denominator Documented**: 
  $$\text{Placement Rate (\%)} = \left(\frac{\text{Unique Eligible Placed Students}}{\text{Total Eligible Students}}\right) \times 100$$
- **Duplicate Placements Handled**: Students holding multiple placement offers are tracked individually without artificially inflating the unique placed count or department placement rates.
- **Privacy & Sensitivity**: Aggregate reports, department analytics, and package summaries never expose sensitive individual student roll numbers or personal details.

---

## 🚀 One-Click Launch

Simply run `start.bat` in the project root:

```cmd
start.bat
```

Or run manually from the terminal:

```cmd
cd backend
python app.py
```

Open your browser at:
- **Application Portal**: [http://localhost:5000](http://localhost:5000)
- **API Health Check**: [http://localhost:5000/api/health](http://localhost:5000/api/health)

---

## 🗄️ MySQL Database Setup

1. Configure your MySQL credentials in [backend/.env](file:///d:/Project/python%20project/backend/.env):
   ```ini
   DB_TYPE=mysql
   MYSQL_HOST=127.0.0.1
   MYSQL_PORT=3306
   MYSQL_USER=root
   MYSQL_PASSWORD=your_mysql_password
   MYSQL_DB=placement_system
   ```
2. On startup, Flask connects to MySQL, automatically creates the `placement_system` database and all required tables, and seeds fictional sample data if empty.
3. You can also execute the DDL script manually in MySQL Workbench:
   ```sql
   source backend/schema.sql;
   ```
4. *(Optional)* A local SQLite fallback is included so the application remains functional even before MySQL credentials are configured.

---

## 📁 Directory Structure

```
python project/
├── data/                         # Standalone Sample Datasets (CSV & JSON)
│   ├── sample_students.csv       # 275 student records with skills & details
│   ├── sample_placements.csv     # 246 placement offers with LPA packages
│   └── sample_dataset.json       # Complete relational database dump
├── frontend/                     # Pure HTML/CSS/JavaScript Client
│   ├── index.html                # Multi-page responsive portal UI
│   ├── styles.css                # Custom CSS styling (clean, modern theme)
│   ├── app.js                    # Vanilla JS application & Chart.js integration
│   └── README.md
├── backend/                      # Python Flask Backend
│   ├── app.py                    # Flask application factory & static file serving
│   ├── config.py                 # Environment configuration (.env loader)
│   ├── database.py               # MySQL engine & session management
│   ├── models.py                 # SQLAlchemy relational ORM models
│   ├── schema.sql                # MySQL 8 DDL schema script
│   ├── seed_data.py              # Fictional student dataset seeder & exporter
│   ├── requirements.txt          # Python dependencies
│   ├── routes/
│   │   ├── analytics.py          # Dashboard, department, package & skill analytics
│   │   ├── placements.py         # Placement CRUD & offer tracking
│   │   ├── students.py           # Student CRUD, skill tagging & eligibility
│   │   └── reports.py            # Matplotlib PNG chart export endpoints
│   └── services/
│       ├── analytics_service.py  # Pandas & NumPy analysis engine
│       └── report_service.py     # Matplotlib chart generator
├── start.bat                     # One-click Windows launch script
└── README.md                     # Documentation
```

---

## 📊 Sample Data & Seeding

The project comes pre-loaded with comprehensive, realistic sample data modeling an engineering college placement cell:
- **275 Students**: Covering all 9 batches (**2018 through 2026**) across 5 departments (`CSE`, `ECE`, `EEE`, `ME`, `CE`) and 15+ specializations/sub-branches (`AIML`, `AIDS`, `DS`, `VLSI`, `Embedded`, `Robotics`, etc.).
- **246 Placement Offers**: Spanning 35+ top recruiters (Google, Microsoft, Amazon, Cisco, Qualcomm, Texas Instruments, Deloitte, Tata Motors, TCS, Infosys, etc.) with salaries ranging from **3.5 LPA to 44.0 LPA**.
- **48 Technical Skills**: Realistic industry stacks categorized with department-level affinity.
- **Deduplicated Analytics**: Students with multiple offers (1, 2, or 3 offers) and ~12% ineligible students to demonstrate accurate placement statistics.

### Re-seeding or Managing Sample Data:
1. **Via Web UI**: Navigate to **Settings** in the portal and click **Re-seed Sample Data** or **Download CSV/JSON**.
2. **Via Command Line**:
   ```cmd
   cd backend
   python seed_data.py
   ```
   This clears and populates the database, then exports fresh CSV and JSON copies into the `data/` folder.

