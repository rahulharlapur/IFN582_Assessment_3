# ShareSpace - IFN582 Assessment 3

## Project Structure

```text
Group_4_582_A3.zip
├── run.py
├── README.txt
├── requirements.txt
└── project/
    ├── static/
    │   ├── css/
    │   ├── documents/
    │   └── img/
    ├── templates/
    ├── __init__.py
    ├── db.py
    ├── forms.py
    ├── models.py
    ├── views.py
    └── sharespace-database.sql
```

## Setup Instructions

### 1. Create A Virtual Environment

Mac/Linux:

```bash
python3 -m venv venv
```

Windows:

```bat
python -m venv venv
```

### 2. Activate The Virtual Environment

Mac/Linux:

```bash
source venv/bin/activate
```

Windows:

```bat
venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Create And Populate The MySQL Database Using MySQL Workbench

The application is configured to use:

- Database name: `sharespace`
- MySQL host: `localhost`
- MySQL user: `root`

Open MySQL Workbench, connect to the local MySQL server, then open and run the SQL file:

```text
project/sharespace-database.sql
```

If your local MySQL username or password is different, update the MySQL settings in `project/__init__.py` before running the application.

### 5. Run The Application

```bash
python run.py
```

### 6. Open The Application In Google Chrome

```text
http://127.0.0.1:8888
```

## Seeded Test Accounts

Admin accounts:

- `admin1@sharespace.com`
- `admin2@sharespace.com`

Seller accounts:

- `sarah@sharespace.com`
- `daniel@sharespace.com`

Buyer accounts:

- `rahul@sharespace.com`
- `emily@sharespace.com`

All seeded accounts use the same password:

```text
Test@123
```
