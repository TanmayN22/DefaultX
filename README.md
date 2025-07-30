# 🔐 DefaultX: Intelligent Defaulter Prediction System

**DefaultX** is a secure, AI-powered credit scoring system designed for banks and financial institutions. It predicts the likelihood of loan default using deep learning models and provides risk insights for smarter lending decisions.

Built as a cross-platform **Flutter Desktop App** with a **FastAPI-powered backend**, DefaultX focuses on enterprise-grade security, role-based access, and predictive analytics.

---

## 🚀 Features

- 🔍 Predict loan default risk using DL models
- 📊 View applicant credit scores and probability of default
- 🧠 Feature importance explanations
- 👥 Role-based access (Admin / Officer / Reviewer)
- 📈 Dashboard for application and risk insights
- 🗃 Report generation and downloadable logs
- 🔐 Fully secure: JWT authentication, encrypted local storage

---

## 🏗️ Tech Stack

| Layer        | Technology              |
|--------------|--------------------------|
| UI (Frontend) | Flutter (Desktop)       |
| State Mgmt   | GetX     |
| Backend API  | FastAPI (Python)         |
| ML Model     | scikit-learn / TensorFlow |
| Auth         | JWT + Bcrypt             |
| Database     | PostgreSQL + SharedPrefernces|
| File Storage | Encrypted Local Files    |
| Deployment   | Docker / Linux VM        |

---

## 📸 Screenshots

> *(Will add screenshots soon!)*

---

## 📁 Folder Structure

```

lib/
└── app/
    ├── core/                     # Shared core utilities and components
    │   ├── constants/            # API routes, app-wide constants
    │   ├── theme/                # Color palette, themes, typography
    │   ├── utils/                # Common helper functions
    │   ├── widgets/              # Reusable widgets (buttons, tables, cards)
    │   └── services/             # Shared services like API, storage, notifications
    │
    ├── data/                     # Data layer: models, repositories, providers
    │   ├── models/               # Data models (User, Applicant, Loan, etc.)
    │   ├── repositories/         # Business logic and data-fetching layers
    │   └── providers/            # API and storage provider instances
    │
    ├── modules/                  # Feature-based modules (screens, controllers)
    │   ├── auth/                 # Login, password, auth widgets
    │   ├── dashboard/            # Main dashboard with charts and KPIs
    │   ├── applicant_management/ # Applicant list, filters, risk tags
    │   ├── applicant_details/    # Profile view with score and docs
    │   ├── loan_decision/        # Decision engine UI and forms
    │   ├── model_insights/       # AI explainability and fairness analysis
    │   ├── reports/              # Report generation and export
    │   ├── admin/                # Admin tools, user mgmt, model settings
    │   ├── audit_logs/           # Activity and security logs
    │   └── notifications/        # Alerts, badges, and notification settings
    │
    ├── routes/                   # App routing and middleware
    │   ├── app_pages.dart
    │   ├── app_routes.dart
    │   └── middlewares/          # Auth and role-based access
    │
    └── main.dart                 # App entry point


````
---

## 🔐 Security Features

* Passwords hashed with **Bcrypt**
* JWT-based session authentication
* Encrypted file storage for documents
* Audit logs for decision tracking
* Role-based feature access control
* No Firebase or third-party data storage

---

## 📈 ML Model Summary

* Model Type: 
* Input: Borrower financial data (age, income, credit history, etc.)
* Output:

  * Binary prediction: 0 (safe) / 1 (risky)
  * Probability of default (0.0 to 1.0)
* Tools: `scikit-learn`, `xgboost`

---

## 🛠 Future Enhancements

* ⏳ Offline-first mode with sync
* 📥 Batch upload for loan portfolios
* 📊 Credit score simulator
* 🔄 Auto-retraining model pipeline

---

## 📄 License

This project is intended for academic and research use.
Please contact the team for commercial licensing.

---

## 🤝 Contributors

* \[{Piyush Das] – ML Developer
* \[Tanmay Nayak] – Flutter Developer, UI/UX Designer
* \[Kaustubh Gondkar] – Flutter Developer 

---

## 📬 Contact

For queries or collaboration, reach out to:
📧 [nayaktanmayg@gmail.com](mailto:nayaktanmayg@gmail.com)

---

