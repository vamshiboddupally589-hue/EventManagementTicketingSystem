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

.header{
    background:#0d6efd;
    color:white;
    padding:20px;
    text-align:center;
    font-size:30px;
    font-weight:bold;
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

.card h2{
    color:#0d6efd;
    margin-bottom:20px;
}

.booking-table{
    width:100%;
    border-collapse:collapse;
}

.booking-table th{
    background:#0d6efd;
    color:white;
    padding:14px;
    text-align:center;
}

.booking-table td{
    padding:14px;
    border-bottom:1px solid #ddd;
    text-align:center;
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
    padding:6px 16px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}

.status-cancelled{
    display:inline-block;
    background:#dc3545;
    color:white;
    padding:6px 16px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
}

.download-btn{
    display:inline-block;
    background:#dc3545;
    color:white;
    padding:10px 18px;
    border-radius:8px;
    text-decoration:none;
    font-weight:bold;
    min-width:150px;
    text-align:center;
    transition:.3s;
}

.download-btn:hover{
    background:#bb2d3b;
}

.cancel-btn{
    display:inline-block;
    background:#ffc107;
    color:#000;
    padding:10px 18px;
    border-radius:8px;
    text-decoration:none;
    font-weight:bold;
    min-width:110px;
    text-align:center;
    transition:.3s;
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
    color:white;
    text-decoration:none;
    padding:12px 22px;
    border-radius:8px;
    font-weight:bold;
}

.back-btn:hover{
    background:#0b5ed7;
}

</style>

</head>

<body>

<div class="header">
    My Bookings
</div>

<div class="container">

<div class="card">

<h2>My Confirmed Bookings</h2>

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
    <th>Booking ID</th>
    <th>Event</th>
    <th>Ticket Type</th>
    <th>Tickets</th>
    <th>Amount</th>
    <th>Status</th>
    <th>Date</th>
    <th>Download</th>
    <th>Cancel</th>
</tr>

<%
for(Booking booking : bookings){
%>

<tr>

<td><%= booking.getBookingId() %></td>

<td><%= booking.getEventName() %></td>

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
if("CONFIRMED".equals(booking.getStatus())){
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
<td><%= booking.getBookingDate() %></td>

<td>

<%
if("CONFIRMED".equals(booking.getStatus())){
%>

<a href="DownloadTicketServlet?bookingId=<%= booking.getBookingId() %>"
   class="download-btn">
    Download Ticket
</a>

<%
}else{
%>

<span style="color:gray;font-weight:bold;">
    Not Available
</span>

<%
}
%>

</td>

<td>

<%
if("CONFIRMED".equals(booking.getStatus())){
%>

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
    ← Back to Dashboard
</a>

</div>

</div>

</body>

</html>