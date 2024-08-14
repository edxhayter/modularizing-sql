# Legacy SQL to Modularized dbt Demo

## Overview

Welcome to the **Legacy SQL to Modularized dbt Demo** repository. This repository is part of an internal upskilling session designed to demonstrate the benefits of modularizing SQL code using dbt. The repository includes two key branches:

- **`main` branch:** Contains a starter legacy SQL script that represents how code might be written in a non-modular, monolithic way.
- **`modularized` branch:** Contains a refactored version of the legacy SQL script, where the code has been modularized to demonstrate best practices in dbt.

## Purpose

The goal of this demo is to highlight the advantages of modularizing SQL code, specifically:

- **DRY Code (Don't Repeat Yourself):** Modularized code reduces redundancy by reusing common logic across different parts of the project.
- **Version Control:** With modularized code, multiple team members can work on separate branches without conflicts, making collaboration smoother.
- **Readability:** Modular code is easier to read, understand, and maintain, especially for new team members or those inheriting the project.
- **Unit Testing:** Modular components can be individually tested, making it easier to write unit tests and isolate issues.

## Modularizing the Code

In this project, we undertook a modularization process to enhance code maintainability, clarity, and alignment with best practices. Below are the steps we followed:

### Step 1: Approach to Refactoring

**Strategy:** **Alongside**

For this refactoring, we opted for an "alongside" approach, maintaining the existing legacy file while creating new modularized files. This method allows us to:

- **Verification:** Ensure that the new modularized code produces results consistent with the legacy code.
- **Comparison:** Facilitate a direct comparison between the legacy and refactored versions.

### Step 2: File Structure Setup

We established a file structure that supports modularization with the following layers:

- **Staging Layer:** Handles basic operations such as renaming, casting, and preliminary calculations. This layer is grouped by source system to keep data organized.
  
- **Intermediary Layer:** Aggregates data from staging models and combines multiple tables for broader business use. This layer avoids direct joins between staging tables and final models.

- **Final Layer:** Consists of final tables or views used for reporting. It integrates results from intermediary models and defines materialization strategies based on performance needs.

### Step 3: Building Models

**Staging Models:**

- **Import Source Files:** Import raw data from source tables.
- **Basic Transformations:** Perform initial operations such as renaming columns and casting data types.

**Intermediary and Final Models:**

- **Import Prior Models:** Import data from staging or intermediary models at the beginning of the model.
- **Logical CTEs:** Include complex calculations, aggregations, or joins necessary for business requirements.
- **Final CTE:** Combine results to generate the final dataset.

### Step 4: `sources.yml` Configuration

We configured a `sources.yml` file to define our data sources. For simplicity, we used a single configuration file in this use case, although, for more complex scenarios, this file might be split by system or source. The `sources.yml` file contains:

- **Source Definitions:** Metadata about the data sources, including tables and schemas.
- **Documentation:** Information about each source to aid in understanding and maintenance.

### Step 5: Final Table, Audit Check, and Materialization

- **Built the Final Table:** Integrate results from intermediary models to create the final tables or views used for reporting.
- **Performed an Audit Check:** Ensure the refactored code aligns with the legacy code and meets the expected outcomes.
- **Considered Materialization:** Decide on materialization strategies (e.g., table, view) based on performance and reporting needs.

## Getting Started

1. **Explore the `main` branch:**
   - Review the legacy SQL script to understand its original structure.
   
2. **Switch to the `modularized` branch:**
   - Explore the refactored, modularized version.
   - Observe how the logic is broken down into reusable components.

## How to Use

- **Internal Training:** Use this repository for internal upskilling. Experiment with the code and see how modularization can simplify SQL workflows.
- **Demo:** During the session, we'll walk through refactoring the legacy SQL script into a modular structure using dbt.

## Contributions

This repository is intended for educational purposes only. If you have suggestions for improvement, feel free to reach out.

## Useful Resources

- [Refactoring Legacy SQL with dbt](https://docs.getdbt.com/guides/refactoring-legacy-sql?step=7)

---

## Connect with Me

- [GitHub Profile](https://github.com/edxhayter)