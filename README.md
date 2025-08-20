# Pahana Edu Bookshop Billing System

A comprehensive billing management system for the Pahana Edu Bookshop, built with Java Servlets, JSP, and MySQL.

## 🚀 Features

- **Bill Generation**: Create new bills with multiple items
- **Customer Management**: Manage customer accounts and view their bills
- **Inventory Management**: Track item stock levels
- **Bill Status Management**: Mark bills as paid or pending
- **Print Functionality**: Generate printer-friendly bill copies
- **Responsive Design**: Modern, mobile-friendly user interface

## 🔧 Recent Fixes Applied

The billing system has been completely overhauled to fix all major issues:

### 1. Model Layer Fixes
- ✅ Added missing `description` field to `BillItem` model
- ✅ Fixed constructor parameters for `BillItem`
- ✅ Added proper getter/setter methods

### 2. DAO Layer Fixes
- ✅ Fixed SQL queries to include all required fields
- ✅ Corrected `INSERT_BILL_ITEMS` statement
- ✅ Fixed bill item extraction from ResultSet
- ✅ Added proper bill item ID generation
- ✅ Fixed bill listing to include items

### 3. Service Layer Fixes
- ✅ Fixed bill generation logic
- ✅ Added proper stock validation
- ✅ Implemented automatic description setting from item titles
- ✅ Fixed total amount calculation
- ✅ Added proper error handling

### 4. Servlet Layer Fixes
- ✅ Fixed action parameter handling
- ✅ Added comprehensive input validation
- ✅ Improved error handling and user feedback
- ✅ Fixed form submission processing
- ✅ Added proper redirects and error messages

### 5. Frontend Fixes
- ✅ Created proper `listBills.jsp` (was incorrectly named)
- ✅ Fixed `viewBill.jsp` to handle missing description field
- ✅ Enhanced `customerBills.jsp` with statistics
- ✅ Created printer-friendly `printBill.jsp`
- ✅ Improved form validation and user experience
- ✅ Added responsive design and modern styling

### 6. Database Layer Fixes
- ✅ Fixed `updateStock` method in `ItemDAO`
- ✅ Added proper stock calculation logic
- ✅ Prevented negative stock levels

## 🗄️ Database Setup

1. Create a MySQL database named `pahana_edu`
2. Run the SQL commands from `database_schema.sql`
3. Update `DBConnection.java` with your database credentials

### Database Tables
- `Bill` - Main bill information
- `BillItem` - Individual items in each bill
- `Customer` - Customer account information
- `items` - Inventory items
- `users` - System users

## 🚀 Getting Started

### Prerequisites
- Java 8 or higher
- Apache Tomcat 9 or 10
- MySQL 5.7 or higher
- Maven (for building)

### Installation
1. Clone the repository
2. Import into your IDE as a Maven project
3. Update database connection settings
4. Build the project: `mvn clean install`
5. Deploy to Tomcat
6. Access at: `http://localhost:8080/pahana-edu`

## 📋 Usage Guide

### 1. Generate New Bill
- Navigate to: `bill?action=generate`
- Select customer from dropdown
- Set bill and due dates
- Add items with quantities and prices
- Click "Generate Bill"

### 2. View All Bills
- Navigate to: `bill?action=list`
- View all bills in a table format
- Use action buttons to view, print, or mark as paid

### 3. View Customer Bills
- Navigate to: `bill?action=customer&accountNumber=CUST001`
- View bills for a specific customer
- See summary statistics

### 4. View Individual Bill
- Click "View" button from bill list
- See complete bill details
- Mark as paid if status is pending

### 5. Print Bill
- Click "Print" button from bill view
- Generate printer-friendly version
- Save as PDF or print directly

## 🔍 System Flow

```
Customer Selection → Item Selection → Quantity/Price Input → Bill Generation → Stock Update → Bill Creation
```

## 🛡️ Error Handling

The system now includes comprehensive error handling:
- Input validation for all form fields
- Stock availability checks
- Database error handling
- User-friendly error messages
- Proper exception handling

## 🎨 UI/UX Improvements

- Modern, responsive design
- Consistent color scheme and typography
- Interactive elements with hover effects
- Mobile-friendly layout
- Professional invoice styling
- Clear navigation and action buttons

## 🧪 Testing

To test the system:
1. Ensure database is populated with sample data
2. Try generating a bill with multiple items
3. Test bill viewing and printing
4. Verify stock updates work correctly
5. Test error scenarios (invalid inputs, insufficient stock)

## 📁 File Structure

```
src/main/
├── java/com/icbt/
│   ├── dao/           # Data Access Objects
│   ├── model/         # Data Models
│   ├── service/       # Business Logic
│   ├── servlet/       # HTTP Controllers
│   └── util/          # Utility Classes
├── webapp/
│   ├── JSP files      # View Templates
│   └── WEB-INF/       # Configuration
└── resources/          # Configuration Files
```

## 🐛 Common Issues & Solutions

### Issue: "Description field not found"
- **Solution**: The `BillItem` model now includes the description field

### Issue: "Stock not updating"
- **Solution**: Fixed `updateStock` method in `ItemDAO`

### Issue: "Bill items not displaying"
- **Solution**: Fixed bill item extraction and display logic

### Issue: "Form submission errors"
- **Solution**: Added comprehensive validation and error handling

## 🔮 Future Enhancements

- Email bill notifications
- Payment gateway integration
- Advanced reporting and analytics
- Multi-currency support
- Tax calculation features
- Customer portal

## 📞 Support

For technical support or questions about the billing system, please contact the development team.

---

**Note**: This system has been thoroughly tested and all major billing functionality issues have been resolved. The system is now production-ready with proper error handling, validation, and user experience improvements.
