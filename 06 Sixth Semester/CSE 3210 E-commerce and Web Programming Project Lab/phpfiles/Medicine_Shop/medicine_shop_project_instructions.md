# Project Instructions
**Medicine Shop Billing System | Duration: 10 Days**

## 1. Project Allocation

> **Group Assignment:** EVEN-NUMBERED GROUPS (2, 4, 6, 8, 10, 12, ...)
> **Assigned Project:** Medicine Shop Billing System

## 2. Technology Requirements

* Use raw PHP only. Do not use PHP frameworks.
* Use MySQL with procedural MySQLi functions only. Do not use PDO or object-style MySQLi.
* Queries may be written in a flexible style using `mysqli_query()`. Prepared statements are not required.
* Use HTML, CSS and Bootstrap for the interface.
* Run the project using XAMPP, WAMP or Laragon.
* Separate common page layouts into `header.php`, `sidebar.php` and `footer.php`.
* Passwords must be hashed (not stored as plain text).
* Check the admin session on every protected page.

## 3. Required Modules

| No. | Module | Main Requirements |
| :--- | :--- | :--- |
| 1 | Login & Logout | Admin login, logout and change password |
| 2 | Category Management | Add, edit, delete and list categories |
| 3 | Product Management | Add, edit, delete, list, search and filter by category |
| 4 | Billing (POS) | Search products, cart, quantity, discount, payment method and save sale |
| 5 | Invoice | Unique invoice number and printable customer bill |
| 6 | Sales History | List and view bills; filter by date |
| 7 | Profit/Loss Report | Calculate profit or loss for a selected date range |
| 8 | Dashboard | Today's sales, today's profit and low-stock products |

## 4. Project-Specific Requirements

* **Product fields:** Product name, generic name, category, unit, cost price, selling price, printed MRP, stock, reorder level and expiry date.
* Category is required for every product.
* Expiry date is required for every medicine.
* Product quantities must be whole numbers.
* Expired medicines must not be sold.
* Show a warning if the selling price is higher than the printed MRP.
* **Extra dashboard information:** product count per category, expired medicines and medicines expiring within the next 60 days.
* **Starter categories:** Tablet, Capsule, Syrup, Injection, Ointment/Cream, Drops, First Aid, Baby Care and Supplements.

## 5. Billing and Invoice Requirements

* Search products by name.
* Add products to the cart, change quantities and remove items.
* Apply discounts and select a payment method: Cash, Card or Mobile Banking.
* Calculate subtotal, discount and grand total correctly.
* Save the sale and reduce product stock after a successful sale.
* Generate a unique invoice number and provide a print option.
* Do not allow a sale when the available stock is insufficient.
* Save the product's cost price with each sold item, so old profit reports do not change if the cost is edited later.
* Block expired medicines during billing.

## 6. Final Submission Requirements

Submit exactly three files within 10 days:

| No. | Deliverable | File name |
| :--- | :--- | :--- |
| 1 | Project ZIP: complete PHP source code | GroupNo_ProjectName.zip (example: Group2_Medicine.zip) |
| 2 | Database file (.sql): all tables, starter categories and one default admin account | GroupNo_ProjectName.sql |
| 3 | Project Report (PDF) | GroupNo_Report.pdf |

**The Project Report must contain:**
* Group number, project type and member names
* Setup steps and default admin login
* List of completed modules and ER diagram
* Screenshots of key pages (login, categories, products, billing, invoice, dashboard, profit/loss report)
* How discount is treated in the profit calculation