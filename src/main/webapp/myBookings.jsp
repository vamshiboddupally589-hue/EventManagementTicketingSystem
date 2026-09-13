<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>
<%@page import="com.mycompany.eventmanagement.model.Booking"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

BookingDAO bookingDAO = new BookingDAO();
List<Booking> bookings = bookingDAO.getBookingsByUser(user.getUserId());
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Bookings</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:#f4f6f9;
}

.container{
    width:90%;
    margin:40px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
}

.header{
    background:linear-gradient(135deg,#0d6efd,#3b82f6);
    color:white;
    padding:30px;
    text-align:center;
    border-bottom-left-radius:15px;
    border-bottom-right-radius:15px;
}

.header h1{
    margin:0;
    font-size:34px;
}

.header p{
    margin-top:8px;
    font-size:16px;
    opacity:.9;
}

.card h2{
    color:#0d6efd;
    margin-bottom:20px;
    font-size:30px;
}

.booking-table{
    width:100%;
    border-collapse:collapse;
}

.booking-table th{
    background:#0d6efd;
    color:#fff;
    padding:16px;
    text-align:center;
    font-size:16px;
    font-weight:600;
    letter-spacing:.5px;
}

.booking-table td{
    padding:18px 12px;
    border-bottom:1px solid #ddd;
    text-align:center;
    vertical-align:middle;
}

.booking-table td:nth-child(2){
    white-space:nowrap;
}

.booking-table td:nth-child(7){
    white-space:nowrap;
}

.booking-table tr:nth-child(even){
    background:#fafafa;
}

.booking-table tr:hover{
    background:#eef5ff;
}

.status-confirmed{
    display:inline-block;
    background:#28a745;
    color:white;
    padding:8px 18px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}

.status-cancelled{
    display:inline-block;
    background:#dc3545;
    color:white;
    padding:8px 18px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}
/* ================= Buttons ================= */

.download-btn{
    display:inline-block;
    background:#dc3545;
    color:#fff;
    padding:8px 14px;
    border-radius:6px;
    text-decoration:none;
    font-size:14px;
    font-weight:600;
    white-space:nowrap;
}

.download-btn:hover{
    background:#bb2d3b;
}
.action-buttons{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:10px;
}

.cancel-btn{
    display:inline-block;
    background:#ffc107;
    color:#212529;
    padding:8px 12px;
    border-radius:5px;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
    text-align:center;
    transition:0.3s;
}

.cancel-btn:hover{
    background:#e0a800;
}

.no-booking{
    text-align:center;
    padding:30px;
    font-size:20px;
    color:#777;
}

.back-btn{
    display:inline-block;
    margin-top:25px;
    background:#0d6efd;
    color:#fff;
    text-decoration:none;
    padding:10px 20px;
    border-radius:6px;
    font-size:15px;
    font-weight:600;
    transition:0.3s;
}

.back-btn:hover{
    background:#0b5ed7;
}
</style>

</head>

<body>

<div class="header">

    <h1>My Bookings</h1>

    <p>
        View all your confirmed and cancelled event tickets
    </p>

</div>

<div class="container">

<div class="card">

<h2>My Bookings</h2>

<%
if(bookings.size()==0){
%>

<div class="no-booking">
    No bookings found.
</div>

<%
}else{
%>

<table class="booking-table">

<tr>
    <th>Event</th>
    <th>Ticket Type</th>
    <th>Tickets</th>
    <th>Amount</th>
    <th>Status</th>
    <th>Booking Date</th>
    <th>Actions</th>
</tr>

<%
for(Booking booking : bookings){
%>

<tr>

    <td style="max-width:180px;">
        <%= booking.getEventName() %>
    </td>

    <td>
        <%
        if("VIP".equalsIgnoreCase(booking.getTicketType())){
        %>

        <span style="background:#ffc107;
                     color:black;
                     padding:6px 15px;
                     border-radius:20px;
                     font-weight:bold;">
            VIP
        </span>

        <%
        }else{
        %>

        <span style="background:#17a2b8;
                     color:white;
                     padding:6px 15px;
                     border-radius:20px;
                     font-weight:bold;">
            REGULAR
        </span>

        <%
        }
        %>
    </td>

    <td><%= booking.getSeatsBooked() %></td>

    <td>₹ <%= booking.getTotalAmount() %></td>

    <td>

        <%
        if("CONFIRMED".equalsIgnoreCase(booking.getStatus())){
        %>

        <span class="status-confirmed">
            CONFIRMED
        </span>

        <%
        }else{
        %>

        <span class="status-cancelled">
            CANCELLED
        </span>

        <%
        }
        %>

    </td>

    <td>
        <%= booking.getBookingDate().toString().substring(0,10) %>
    </td>

    <td class="action-buttons">

        <%
        if("CONFIRMED".equalsIgnoreCase(booking.getStatus())){
        %>

        <a href="DownloadTicketServlet?bookingId=<%= booking.getBookingId() %>"
           class="download-btn">
            Download
        </a>

        <a href="CancelBookingServlet?bookingId=<%= booking.getBookingId() %>"
           class="cancel-btn"
           onclick="return confirm('Are you sure you want to cancel this booking?');">
            Cancel
        </a>

        <%
        }else{
        %>

        <span style="color:red;font-weight:bold;">
            Cancelled
        </span>

        <%
        }
        %>

    </td>

</tr>

<%
}
%>

</table>
<%
}
%>

<a href="dashboard.jsp" class="back-btn">
    Back
</a>

</div>

</div>

</body>

</html>