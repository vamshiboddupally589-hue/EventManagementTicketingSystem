<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Booking"%>

<%
BookingDAO dao = new BookingDAO();
List<Booking> bookings = dao.getAllBookings();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>All Bookings</title>

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
    width:92%;
    margin:40px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
}

h1{
    color:#0d6efd;
    margin-bottom:25px;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th{
    background:#0d6efd;
    color:white;
    padding:15px;
}

table td{
    padding:14px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

table tr:hover{
    background:#f8fbff;
}

.status{
    background:#28a745;
    color:white;
    padding:6px 15px;
    border-radius:20px;
    font-size:13px;
    font-weight:bold;
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

<div class="container">

<div class="card">

<h1>All Bookings</h1>

<table>

<tr>
    <th>Booking ID</th>
    <th>User</th>
    <th>Event</th>
    <th>Seats</th>
    <th>Total Amount</th>
    <th>Status</th>
    <th>Booking Date</th>
</tr>
<%
if(bookings.size() == 0){
%>

<tr>
    <td colspan="7" style="padding:25px;font-size:18px;color:gray;">
        No bookings found.
    </td>
</tr>

<%
}else{

for(Booking booking : bookings){
%>

<tr>

    <td><%= booking.getBookingId() %></td>

    <td><%= booking.getUserName() %></td>

    <td><%= booking.getEventName() %></td>

    <td><%= booking.getSeatsBooked() %></td>

    <td>₹ <%= booking.getTotalAmount() %></td>

    <td>
        <span class="status">
            <%= booking.getStatus() %>
        </span>
    </td>

    <td><%= booking.getBookingDate() %></td>

</tr>

<%
}
}
%>
</table>

<br>

<a href="adminDashboard.jsp" class="back-btn">
    ← Back to Dashboard
</a>

</div>

</div>

</body>

</html>