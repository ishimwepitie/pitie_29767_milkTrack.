# Dairy Milk Collection and Quality Monitoring System

**Student:** ISHIMWE Pitie | **Student ID:** 29767
**Course:** INSY 8311 – Database Development with PL/SQL | **Instructor:** Eric Maniraguha
**Repository:** pitie_29767_milkTrack

## Problem Statement
Dairy farmers deliver milk to collection centres every day. Quality is often checked and recorded on paper, so poor-quality batches are accepted by mistake, farmer payments are calculated by hand, and managers learn about repeated rejections too late. This project builds an Oracle database with PL/SQL that records deliveries, tests quality, calculates payments, and raises alerts automatically.

## Objectives
**Main objective:** Build an Oracle PL/SQL database that records milk deliveries, enforces quality rules and automatically alerts managers about rejected batches.

**Specific objectives:**
1. Record farmers, collection centres, daily deliveries and quality tests in a normalized (3NF) schema.
2. Accept or reject each batch with PL/SQL based on quality rules, and calculate farmer payments.
3. Block invalid data with triggers and record every rejected attempt in an audit log.
4. Run a nightly scheduled job that flags centres with repeated rejected batches and creates alerts.

## Data Source
- **Dataset:** Milk Quality dataset (Kaggle) – pH, temperature, taste, odour, fat, turbidity, colour and quality grade per sample.
- **Link:** https://www.kaggle.com/datasets/cpluzshrijayan/milkquality *(confirm link on Kaggle)*
- **Size:** about 1,000 records *(confirm after download)*
- **Licence:** *(copy the licence from the Kaggle page; must allow educational use)*
- **Personal data:** none. Farmers and collection centres are modelled with non-identifying, simulated records around the real quality data.

## Innovation
**Option:** Smart automation.
**Tool:** DBMS_SCHEDULER (nightly job), with optional UTL_MAIL email alerts.
A nightly job finds centres with repeated rejected batches and writes alerts to an alerts table for the manager.

## Planned Tables
Farmers, Collection_Centres, Milk_Deliveries, Quality_Tests, Payment_Rates, Payments, Alerts, Audit_Log.

## Planned PL/SQL Features
- **Procedure `record_delivery`:** saves a delivery and its quality test, then accepts or rejects the batch.
- **Function `calculate_payment`:** returns a farmer's payment from accepted litres and the current rate.
- **Cursor:** loops through collection centres to count recent rejections.
- **Package `milk_pkg`:** groups the delivery, payment and alert logic.
- **Trigger:** blocks impossible values (for example pH outside 0–14) and writes the denied attempt to `Audit_Log`.
- **Exceptions:** handle unknown farmers, invalid quantities and duplicate deliveries.
- **Scheduler job:** runs nightly and creates alerts for centres with repeated rejections.

## Folder Structure
- `docs/research/` – research log
- `docs/proposal/` – proposal
- `docs/presentation/` – slides
- `data/` – dataset

## References
*(Add APA references here only for sources you have actually read.)*
