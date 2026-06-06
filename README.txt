ShareSpace - IFN582 Assessment 3

Project structure:
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


Setup instructions:

1. Create a virtual environment

   Mac/Linux:
   python3 -m venv venv

   Windows:
   python -m venv venv

2. Activate the virtual environment

   Mac/Linux:
   source venv/bin/activate

   Windows:
   venv\Scripts\activate

3. Install dependencies

   pip install -r requirements.txt

4. Create and populate the MySQL database using MySQL Workbench

   The application is configured to use:
   - Database name: sharespace
   - MySQL host: localhost
   - MySQL user: root

   Open MySQL Workbench, connect to the local MySQL server, then open and run
   the SQL file:

   project/sharespace-database.sql

   If your local MySQL username or password is different, update the MySQL
   settings in project/__init__.py before running the application.

5. Run the application

   python run.py

6. Open the application in Google Chrome

   http://127.0.0.1:8888

Seeded test accounts:

Admin accounts:
- admin1@sharespace.com
- admin2@sharespace.com

Seller accounts:
- sarah@sharespace.com
- daniel@sharespace.com

Buyer accounts:
- rahul@sharespace.com
- emily@sharespace.com

All seeded accounts use the same password:
Test@123
