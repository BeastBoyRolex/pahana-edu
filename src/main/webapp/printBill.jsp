<%@page import="com.icbt.model.Bill, com.icbt.model.BillItem, java.util.List, java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
  Bill bill = (Bill) request.getAttribute("bill");
  List<BillItem> items = (List<BillItem>) request.getAttribute("items");
  if (bill == null) {
    response.sendRedirect("bill?action=generate");
    return;
  }

  SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
%>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Pahana Edu - Bill Receipt</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3a0ca3;
      --accent-color: #4cc9f0;
      --success-color: #2ecc71;
      --warning-color: #f39c12;
      --danger-color: #e74c3c;
      --light-color: #f8f9fa;
      --dark-color: #212529;
    }

    @media print {
      body * {
        visibility: hidden;
      }
      .print-content, .print-content * {
        visibility: visible;
      }
      .print-content {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
      }
      .no-print {
        display: none !important;
      }
    }

    body {
      background-color: #f5f7ff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .invoice-container {
      max-width: 800px;
      margin: 2rem auto;
      background: white;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      overflow: hidden;
    }

    .invoice-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .invoice-title {
      font-size: 2.2rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .invoice-subtitle {
      font-size: 1.1rem;
      opacity: 0.9;
    }

    .invoice-body {
      padding: 2.5rem;
    }

    .invoice-section {
      margin-bottom: 2rem;
    }

    .section-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: var(--primary-color);
      border-bottom: 2px solid var(--primary-color);
      padding-bottom: 0.5rem;
      margin-bottom: 1.5rem;
    }

    .company-info, .customer-info {
      line-height: 1.6;
    }

    .info-label {
      font-weight: 600;
      color: var(--dark-color);
    }

    .invoice-table {
      width: 100%;
      border-collapse: collapse;
    }

    .invoice-table th {
      background-color: #f8f9fa;
      padding: 12px 15px;
      text-align: left;
      font-weight: 600;
    }

    .invoice-table td {
      padding: 12px 15px;
      border-bottom: 1px solid #eee;
    }

    .invoice-table tr:last-child td {
      border-bottom: none;
    }

    .total-row {
      font-weight: 700;
      font-size: 1.1rem;
    }

    .status-badge {
      display: inline-block;
      padding: 0.35rem 0.75rem;
      border-radius: 50px;
      font-weight: 600;
      font-size: 0.85rem;
    }

    .status-paid {
      background-color: rgba(46, 204, 113, 0.1);
      color: var(--success-color);
    }

    .status-pending {
      background-color: rgba(231, 76, 60, 0.1);
      color: var(--danger-color);
    }

    .invoice-footer {
      background-color: #f8f9fa;
      padding: 1.5rem 2.5rem;
      text-align: center;
      border-top: 1px solid #eee;
    }

    .thank-you {
      font-size: 1.2rem;
      font-weight: 600;
      color: var(--primary-color);
      margin-bottom: 0.5rem;
    }

    .contact-info {
      color: #666;
      font-size: 0.95rem;
    }

    .action-buttons {
      display: flex;
      justify-content: flex-end;
      gap: 1rem;
      margin-bottom: 1.5rem;
    }

    .btn-print {
      background-color: var(--primary-color);
      border: none;
      padding: 0.6rem 1.5rem;
      border-radius: 50px;
      color: white;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-print:hover {
      background-color: var(--secondary-color);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .btn-back {
      background-color: white;
      border: 2px solid var(--primary-color);
      color: var(--primary-color);
      padding: 0.6rem 1.5rem;
      border-radius: 50px;
      font-weight: 500;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-back:hover {
      background-color: var(--primary-color);
      color: white;
      transform: translateX(-3px);
    }

    .watermark {
      position: fixed;
      opacity: 0.05;
      font-size: 20rem;
      font-weight: 800;
      color: var(--primary-color);
      z-index: -1;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%) rotate(-15deg);
      pointer-events: none;
      user-select: none;
    }
  </style>
</head>
<body>
<div class="container py-4">
  <div class="action-buttons no-print">
    <button onclick="window.print()" class="btn-print">
      <i class="fas fa-print me-2"></i>Print Receipt
    </button>
    <a href="bill?action=list&accountNumber=<%= bill.getAccountNumber() %>" class="btn-back">
      <i class="fas fa-arrow-left"></i>Back to Bills
    </a>
  </div>

  <div class="print-content">
    <div class="invoice-container">
      <div class="invoice-header">
        <h1 class="invoice-title">INVOICE RECEIPT</h1>
        <p class="invoice-subtitle">Thank you for your business</p>
      </div>

      <div class="invoice-body">
        <div class="row mb-4">
          <div class="col-md-6">
            <div class="company-info">
              <h3 class="section-title">From</h3>
              <p><span class="info-label">Pahana Edu</span></p>
              <p>123 Bookshop Street</p>
              <p>Colombo, Sri Lanka</p>
              <p><span class="info-label">Phone:</span> +94 11 2345678</p>
              <p><span class="info-label">Email:</span> info@pahanaedu.lk</p>
            </div>
          </div>

          <div class="col-md-6">
            <div class="customer-info">
              <h3 class="section-title">Bill To</h3>
              <p><span class="info-label">Account #:</span> <%= bill.getAccountNumber() %></p>
              <p><span class="info-label">Invoice #:</span> <%= bill.getBillId() %></p>
              <p><span class="info-label">Date:</span> <%= dateFormat.format(bill.getBillDate()) %></p>
              <p><span class="info-label">Due Date:</span> <%= dateFormat.format(bill.getDueDate()) %></p>
            </div>
          </div>
        </div>

        <div class="invoice-section">
          <h3 class="section-title">Payment Information</h3>
          <div class="row">
            <div class="col-md-6">
              <p><span class="info-label">Payment Method:</span> Cash</p>
            </div>
            <div class="col-md-6">
              <p>
                <span class="info-label">Status:</span>
                <span class="status-badge <%= bill.getPaymentStatus().equalsIgnoreCase("PAID") ? "status-paid" : "status-pending" %>">
                  <%= bill.getPaymentStatus() %>
                </span>
              </p>
            </div>
          </div>
        </div>

        <div class="invoice-section">
          <h3 class="section-title">Invoice Details</h3>
          <table class="invoice-table">
            <thead>
            <tr>
              <th>Description</th>
              <th>Quantity</th>
              <th>Unit Price</th>
              <th>Amount</th>
            </tr>
            </thead>
            <tbody>
            <% for (BillItem item : items) { %>
            <tr>
              <td><%= item.getDescription() %></td>
              <td><%= item.getQuantity() %></td>
              <td>Rs. <%= String.format("%.2f", item.getUnitPrice()) %></td>
              <td>Rs. <%= String.format("%.2f", item.getAmount()) %></td>
            </tr>
            <% } %>
            </tbody>
            <tfoot>
            <tr class="total-row">
              <td colspan="3">Total Due</td>
              <td>Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></td>
            </tr>
            </tfoot>
          </table>
        </div>
      </div>

      <div class="invoice-footer">
        <p class="thank-you">Thank you for your business!</p>
        <p class="contact-info">For any inquiries, please contact: +94 11 2345678 | info@pahanaedu.lk</p>
      </div>
    </div>
  </div>

  <div class="watermark no-print">PAHANA EDU</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const invoice = document.querySelector('.invoice-container');
    invoice.style.opacity = '0';
    invoice.style.transform = 'translateY(20px)';
    invoice.style.transition = 'all 0.5s ease';

    setTimeout(() => {
      invoice.style.opacity = '1';
      invoice.style.transform = 'translateY(0)';
    }, 100);
  });
</script>
</body>
</html>