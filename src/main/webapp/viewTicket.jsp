<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Booking"%>

<%
String id = request.getParameter("bookingId");

BookingDAO dao = new BookingDAO();

Booking booking = dao.getBookingById(Integer.parseInt(id));

if(booking == null){
    out.println("<h2>Invalid Ticket</h2>");
    return;
}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Event Ticket</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:#f2f5f9;
}

.container{
    width:450px;
    margin:40px auto;
}

.ticket{

    background:white;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 10px 25px rgba(0,0,0,.2);

}

.header{

    background:#0d6efd;
    color:white;
    text-align:center;
    padding:25px;

}

.header h1{

    font-size:28px;

}

.body{

    padding:30px;

}

.row{

    margin-bottom:18px;
    font-size:18px;

}

.label{

    font-weight:bold;
    color:#0d6efd;

}

.status{

    display:inline-block;
    background:#28a745;
    color:white;
    padding:8px 18px;
    border-radius:20px;
    font-weight:bold;

}

.vip{

    display:inline-block;
    background:#ffc107;
    color:black;
    padding:8px 18px;
    border-radius:20px;
    font-weight:bold;

}

.regular{

    display:inline-block;
    background:#17a2b8;
    color:white;
    padding:8px 18px;
    border-radius:20px;
    font-weight:bold;

}

.footer{

    background:#f8f9fa;
    padding:20px;
    text-align:center;
    font-weight:bold;
    color:#28a745;

}

</style>

</head>

<body>

<div class="container">

<div class="ticket">

<div class="header">

<h1>EVENT TICKET</h1>

</div>

<div class="body">

<div class="row">

<span class="label">Booking ID :</span>

<%= booking.getBookingId() %>

</div>

<div class="row">

<span class="label">Customer :</span>

<%= booking.getUserName() %>

</div>

<div class="row">

<span class="label">Event :</span>

<%= booking.getEventName() %>

</div>

<div class="row">

<span class="label">Ticket Type :</span>

<%
if("VIP".equalsIgnoreCase(booking.getTicketType())){
%>

<span class="vip">VIP</span>

<%
}else{
%>

<span class="regular">REGULAR</span>

<%
}
%>

</div>

<div class="row">

<span class="label">Tickets :</span>

<%= booking.getSeatsBooked() %>

</div>

<div class="row">

<span class="label">Amount :</span>

₹ <%= booking.getTotalAmount() %>

</div>

<div class="row">

<span class="label">Status :</span>

<span class="status">

<%= booking.getStatus() %>

</span>

</div>

<div class="row">

<span class="label">Booking Date :</span>

<%= booking.getBookingDate() %>

</div>

</div>

<div class="footer">

VERIFIED EVENT TICKET

</div>

</div>

</div>

</body>

</html>