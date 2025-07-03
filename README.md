# 🛡️ Phishing URL Classifier

An end-to-end machine learning project that detects whether a given URL is **phishing** or **legitimate**, using extracted features and a trained classifier.

---

## 🎯 Objective

To automatically detect phishing URLs using a trained machine learning model based on features extracted from URLs (length, structure, symbols, etc.).

---

## ❗ Why This Model Is Important

Phishing is a common cyberattack method where attackers trick users into clicking on malicious links. These links often appear legitimate (e.g., fake banking or login pages) and aim to steal sensitive user data like passwords or credit card numbers.

**Problems with manual detection**:
- Inconsistent
- Time-consuming
- Requires domain knowledge

This model offers a reliable and scalable solution.

---

## ⚙️ How the Model Works

1. **Input**  
   A dataset of URLs (either uploaded in real time or loaded from `phishing.csv`).

2. **Feature Engineering**  
   Extracted features include:
   - URL length
   - Use of `@`, `//`, and suspicious words
   - Number of dots/subdomains
   - HTTPS presence

3. **Classification**  
   A machine learning model (e.g., Random Forest) classifies:
   - `1` → Phishing  
   - `0` → Legitimate

4. **Output**  
   - Predictions for each input URL
   - Result shown on UI or saved as CSV

---

## 🗂️ Project Workflow: Step-by-Step

### 1. 📁 Data Preparation & Upload
- **Dataset**: `notebook implementation/phishing.csv`
- **Script**: `upload_data_to_db/mongodbupload.ipynb`
- **Process**:
  - Load CSV using pandas
  - Upload to MongoDB for persistent storage

---

### 2. ⚙️ Training Pipeline Execution

#### 2.1 🔄 Data Ingestion
- `src/components/data_ingestion.py`
- Fetch data from MongoDB and save to `artifacts/data_ingestion/`

#### 2.2 ✅ Data Validation
- `src/components/data_validation.py`
- Validate schema (`config/training_schema.json`)
- Store in `artifacts/data_validation/validated/`

#### 2.3 🔧 Data Transformation
- `src/components/data_transformation.py`
- Convert URLs to features
- Save preprocessor as `preprocessing.pkl`

#### 2.4 🧠 Model Training
- `src/components/model_trainer.py`
- Train model (e.g., Random Forest)
- Save model to `model.pkl` in `artifacts/model_trainer/trained_model/`

#### 🔁 Orchestrator
- `src/pipeline/train_pipeline.py` runs all steps above

---

### 3. ☁️ Upload Model Artifacts to AWS

- **S3 Bucket**: Store `model.pkl` securely
- **Elastic Container Registry (ECR)**:
  - Dockerize app using `Dockerfile`
  - Push image to ECR

---

### 4. 🚀 Deploy with AWS App Runner

- **App**: `app.py` (Flask)
- **Frontend**:
  - HTML: `templates/prediction.html`
  - CSS: `static/css/style.css`
- **Functionality**:
  - Upload test CSV
  - Load model and preprocessor from S3/local
  - Predict and show/save results

---

### 5. 📊 Real-Time Prediction

- `src/pipeline/predict_pipeline.py`
- Reads uploaded CSV, preprocesses, predicts
- Output saved to `Result/predicted_file.csv`

---

### 6. 📝 Logging & Monitoring

- Logs stored in `logs/` directory
- Useful for debugging, pipeline tracking, error monitoring

---

