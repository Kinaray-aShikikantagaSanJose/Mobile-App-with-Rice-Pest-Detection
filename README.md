# 🌾 Mobile-Based Rice Pest Detection, Infestation Hotspot Monitoring, Treatment Recommendation, and Trend Prediction System Using AI-Based Image Counting

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Mobile-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688?logo=fastapi)](https://fastapi.tiangolo.com/)
[![YOLOv8](https://img.shields.io/badge/AI-YOLOv8-FF6F00?logo=ultralytics)](https://docs.ultralytics.com/)
[![PostgreSQL](https://img.shields.io/badge/Database-PostGIS-4169E1?logo=postgresql)](https://postgis.net/)
[![React](https://img.shields.io/badge/Dashboard-React.js-61DAFB?logo=react)](https://react.dev)

---

## 📌 Executive Summary

Agricultural productivity in the Philippines—specifically within the Province of Antique—is heavily dependent on rice farming. However, persistent pest infestations from organisms such as **rice stem borers**, **brown planthoppers**, **rice bugs**, and **green leafhoppers** account for substantial yield losses (up to 30% nationally and 20–40% globally according to FAO). 

Traditional surveillance relies on manual visual observation and sticky trap counting, which are labor-intensive, error-prone, and slow to respond to rapid infestation surges. Existing high-tech solutions often require costly IoT infrastructure, continuous grid power, and constant internet connectivity—rendering them impractical for rural small-scale farmers.

This repository contains the full source code and technical implementation for an integrated, mobile-first, offline-capable, and AI-driven agricultural platform. The platform empowers rice farmers and local agricultural technicians with:
1. **Automated AI Image Counting**: Instantly detects and counts target rice pests on field sticky traps using computer vision (YOLOv8 & OpenCV).
2. **Geospatial Hotspot Mapping**: Tracks pest density using GPS tagging and PostGIS spatial queries to generate low, medium, and high-risk zone maps.
3. **Actionable Treatment & Logging**: Recommends tailored chemical/biological pest control actions and tracks intervention success rates over time.
4. **Infestation Trend Prediction**: Uses historical field data and predictive modeling (Scikit-learn) to forecast future pest surges before widespread crop damage occurs.

---

## 🎯 Objectives

### General Objective
To develop and evaluate a mobile-based rice pest detection, infestation hotspot monitoring, treatment recommendation, and trend prediction system using AI-based image counting to enhance early pest surveillance, facilitate timely agricultural interventions, and mitigate crop losses in Antique, Philippines.

### Specific Objectives
1. **Mobile Field Surveillance**: Build a mobile app (Flutter) enabling field capture of sticky trap photos, automatic GPS location logging, offline data caching, and synchronized cloud reporting.
2. **Computer Vision Pest Detection**: Train and deploy an AI model (YOLOv8) capable of real-time multi-class identification and automated counting of common rice pests.
3. **Spatial Risk Visualization**: Develop a centralized web dashboard (React.js + Leaflet.js) to display pest density maps and classify regions into actionable risk zones (Low, Medium, High).
4. **Treatment & Outcomes Tracking**: Implement an intelligent advisory engine offering targeted treatment strategies while logging historical intervention effectiveness.
5. **Predictive Analytics**: Integrate machine learning algorithms to model seasonal pest trend trajectories and alert technicians to potential outbreaks.

---

## ✨ System Architecture & Key Modules

```
 📱 Mobile App (Flutter)           🌐 Web Dashboard (React.js)
  ├─ Sticky Trap Capture            ├─ Interactive Heatmaps (Leaflet)
  ├─ GPS Geotagging                 ├─ Analytical Reports & Charts
  └─ SQLite Local Storage           └─ Intervention Management
            │                                  │
            └───────────────┬──────────────────┘
                            │ REST APIs / HTTPS
                            ▼
              ⚡ Backend Server (FastAPI)
                ├─ Authentication (JWT, bcrypt)
                ├─ Spatial Engine (PostGIS)
                └─ Inference Pipeline (YOLOv8, OpenCV, Scikit-learn)
                            │
            ┌───────────────┴──────────────────┐
            ▼                                  ▼
 🐘 PostgreSQL + PostGIS             ☁️ Cloud Storage
  (Pest Logs, Users, Geospatial)       (AWS S3 / Cloudinary)
```

### Module Breakdown
* **📱 Field Mobile Client**: Cross-platform Flutter app designed for low-connectivity field environments. Features camera integration, offline SQLite queuing, automatic background sync, and instant visual bounding-box feedback.
* **🧠 AI Detection Engine**: Python FastAPI microservice utilizing YOLOv8 for detection/counting and OpenCV for preprocessing (contrast enhancement, noise reduction, trap grid segmentation).
* **🗺️ Geospatial & Hotspot Mapping**: PostGIS-powered backend engine utilizing Kernel Density Estimation (KDE) and spatial proximity querying to render dynamic heatmaps on Leaflet.js.
* **📊 Analytics & Predictive Dashboard**: React.js front-end with Tailwind CSS, delivering statistical breakdowns, infestation severity indicators, and trend forecasters powered by Scikit-learn.

---

## 🛠️ Tech Stack & Dependencies

| Domain | Technology / Library | Description / Usage |
| :--- | :--- | :--- |
| **Mobile Hardware** | Android Smartphones | Primary capture device for field technicians and farmers |
| **Mobile Framework** | Flutter (Dart) | Cross-platform client with offline-first state architecture |
| **Web Front-End** | React.js, Tailwind CSS | Responsive administrative dashboard & spatial interface |
| **GIS Mapping** | Leaflet.js, PostGIS | Open-source interactive map rendering and spatial querying |
| **AI / Computer Vision**| YOLOv8, OpenCV, PyTorch | Real-time pest detection, spatial counting, and image pre-processing |
| **Predictive ML** | Scikit-learn | Time-series and regression modeling for trend forecasting |
| **Backend API** | FastAPI (Python) | High-performance asynchronous RESTful microservice |
| **Database & Storage** | PostgreSQL + PostGIS, SQLite | Relational database with GIS extensions + client offline db |
| **Cloud File Storage**| AWS S3 / Cloudinary | Secure cloud hosting for raw trap photos & annotated images |
| **Security & Auth** | JWT, bcrypt, HTTPS/SSL | Token-based session control and encrypted password hashing |
| **Developer Tools** | VS Code, Android Studio, Postman | Code editing, mobile emulators, and API testing |
| **Deployment Platforms**| Render, Railway, Vercel, Netlify | Distributed microservices hosting & static edge delivery |

---

## 🔄 Development Methodology

This project follows the **Agile Development Methodology**, structured in iterative Sprints to ensure continuous refinement based on user feedback from local agricultural technicians and farmers.

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Planning   │ ──> │   Design    │ ──> │ Development │ ──> │   Testing   │ ──> │ Deployment  │
│ Requirement │     │ Wireframes  │     │ Mobile/Web  │     │ UAT, Accuracy│    │ Field Pilot │
│ Definition  │     │ Architecture│     │ AI Pipeline │     │ GPS Syncing │     │ Optimization│
└─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘     └─────────────┘
       ▲                                                                               │
       └────────────────────────────────── Iteration ──────────────────────────────────┘
```

1. **Planning Phase**: Feasibility evaluation, requirements gathering with Antique agricultural workers, domain literature review, and API scope definition.
2. **Design Phase**: System architecture mapping, entity-relationship diagrams (ERD), wireframing in Figma, and UI/UX optimization for outdoors visibility.
3. **Development Phase**: Concurrent sprint cycles for Flutter mobile app, YOLOv8 model training, FastAPI backend, and React web dashboard.
4. **Testing Phase**: Verification of bounding-box precision (mAP@50), GPS accuracy tests, offline sync stress testing, and User Acceptance Testing (UAT).
5. **Deployment & Maintenance Phase**: Pilot rollout in selected rice farming communities in Antique, continuous feedback gathering, database indexing, and incremental AI retraining.

---

## 📂 Repository Layout

```text
├── .github/                   # Workflows, issue templates, and CI/CD pipelines
├── backend/                   # FastAPI Server Source Code
│   ├── app/
│   │   ├── api/               # API endpoints (Auth, Pests, Maps, Forecasts)
│   │   ├── core/              # Config, database connections, security helpers
│   │   ├── models/            # SQLAlchemy database models
│   │   ├── schemas/           # Pydantic models for validation
│   │   └── services/          # Business logic & GIS calculations
│   ├── main.py                # Application entrypoint
│   └── requirements.txt       # Python dependencies
├── ai_engine/                 # YOLOv8 & Computer Vision Pipeline
│   ├── dataset/               # Annotated sticky trap image dataset
│   ├── models/                # Trained PyTorch / ONNX model weights (.pt / .onnx)
│   ├── train.py               # Model training script
│   └── inference.py           # Preprocessing & object detection logic
├── mobile_app/                # Flutter Mobile Client
│   ├── lib/
│   │   ├── blocks/            # State management (Bloc/Provider)
│   │   ├── models/            # SQLite & API data models
│   │   ├── services/          # Camera, Location (GPS), Sync engine
│   │   └── views/             # UI screens & offline forms
│   ├── pubspec.yaml           # Flutter dependencies
│   └── android/               # Android native configuration
├── web_dashboard/             # React Administrative & GIS Portal
│   ├── src/
│   │   ├── components/        # Reusable UI widgets & Leaflet map overlays
│   │   ├── pages/             # Hotspot Dashboard, Trend Analytics, Reports
│   │   └── services/          # Axios API client integrations
│   ├── package.json
│   └── tailwind.config.js
└── docs/                      # Capstone Documentation & Diagrams
```


## 📜 License

This project is licensed under the [MIT License](LICENSE) - see the file for details. Built for public research and non-profit agricultural advancement.
