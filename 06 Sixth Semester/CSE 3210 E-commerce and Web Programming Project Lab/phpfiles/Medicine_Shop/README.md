# Medicine Shop Billing System

Raw PHP + MySQL (procedural MySQLi) + Bootstrap project for the CSE 3210
E-commerce and Web Programming Project Lab.

## Project structure

```
Medicine_Shop_Project/
├── index.php                    Dashboard
├── config/
│   ├── config.php               App constants, session, base URL
│   └── db.php                   Procedural MySQLi connection
├── includes/
│   ├── auth.php                 Session guard for protected pages
│   ├── functions.php            Helpers (escape, flash, money, expiry)
│   ├── header.php               HTML head + top navbar
│   ├── sidebar.php              Sidebar + main wrapper
│   └── footer.php               Footer + scripts
├── auth/
│   ├── login.php                Admin login
│   ├── logout.php               Session destroy
│   └── change_password.php      Change password
├── categories/
│   ├── index.php                Category list
│   ├── create.php               Add category
│   ├── edit.php                 Edit category
│   └── delete.php               Delete category
├── products/
│   ├── index.php                Product list, search, category filter
│   ├── create.php               Add product
│   ├── edit.php                 Edit product
│   ├── delete.php               Delete product
│   └── _form.php                Shared add/edit product form
├── billing/
│   └── index.php                Billing (POS)
├── sales/
│   ├── index.php                Sales history with date filter
│   └── view.php                 Single bill view
├── invoices/
│   └── print.php                Printable invoice
├── reports/
│   └── profit_loss.php          Profit / loss report
├── assets/
│   ├── css/style.css            Custom styles + print rules
│   └── js/app.js                Confirm dialogs, print buttons
└── database/
    └── medicine_shop.sql        Schema, starter categories, default admin
```

## Setup

1. Copy the `Medicine_Shop_Project` folder into `htdocs` (XAMPP) or `www` (WAMP/Laragon).
2. Start Apache and MySQL.
3. Import `database/medicine_shop.sql` in phpMyAdmin (or with the MySQL CLI).
4. Set your MySQL credentials in `config/db.php`. The file currently uses:
   - host `localhost`
   - port `3306`
   - user `phpuser`
   - password `root123`
   - database `medicine_shop`

   Change these to match your server (XAMPP's usual default is user `root`
   with an empty password). The same values can also be supplied through
   environment variables: `MEDICINE_DB_HOST`, `MEDICINE_DB_PORT`,
   `MEDICINE_DB_USER`, `MEDICINE_DB_PASS` and `MEDICINE_DB_NAME`.
5. Open `http://localhost/Medicine_Shop_Project/` in the browser.

`config/config.php` detects the project's URL path automatically, so it also
works when the folder is renamed or served from a sub-directory.

## Default admin login

- Username: `admin`
- Password: `admin123`

Change this password after the first login.

## Implementation status

| Module | Status |
| :--- | :--- |
| Login & logout | Working |
| Change password | Working |
| Category management | Working (list, add, edit, delete) |
| Product management | Working (list, add, edit, delete, search, category filter) |
| Billing (POS) | Working (search, cart, quantity, discount, payment method, stock update) |
| Invoice | Working (unique invoice number, printable bill) |
| Sales history | Working (list, view, date filter) |
| Profit/loss report | Working (date range, per-bill breakdown) |
| Dashboard | Working (today's sales/profit, low stock, expiry watch, category counts) |

## Feature notes

- Expired medicines are blocked in billing and are highlighted on the product list.
- Adding or updating a cart quantity above available stock is rejected/clamped.
- Checkout re-checks stock inside a database transaction before reducing it.
- A warning is shown while typing and after saving if the selling price is
  higher than the printed MRP.
- Stock and reorder level accept whole numbers only.
- Invoice numbers look like `INV-20261114-A1B2C3` and are unique.

## Notes

- All protected pages include `includes/auth.php` to check the admin session.
- Pages and action handlers use the shared helpers in `includes/functions.php`.
- Passwords are stored with `password_hash()` and checked with `password_verify()`.
- All database access uses procedural MySQLi (`mysqli_connect`, `mysqli_query`,
  `mysqli_fetch_assoc`, `mysqli_real_escape_string`).
- `sale_items.cost_price` stores the cost at the time of sale so historical
  profit reports do not change when a product's cost is edited later.
- Discount is treated as a reduction of revenue when profit is calculated,
  i.e. profit = (subtotal - discount) - total cost of goods sold.

## Final submission

Rename the deliverables before submitting:

- `GroupNo_Medicine.zip`
- `GroupNo_Medicine.sql`
- `GroupNo_Report.pdf`
