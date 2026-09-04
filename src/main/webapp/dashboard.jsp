<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eventmanagement.dao.EventDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Event"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Booking"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

EventDAO dao = new EventDAO();
int totalBookings = dao.getTotalBookings();
BookingDAO bookingDAO = new BookingDAO();
List<Booking> bookings = bookingDAO.getBookingsByUser(user.getUserId());

String keyword = request.getParameter("keyword");
String sort = request.getParameter("sort");

List<Event> events;

if(keyword != null && !keyword.trim().isEmpty()){

    events = dao.searchEvents(keyword);

}else if(sort != null && !sort.equals("")){

    events = dao.sortEvents(sort);

}else{

    events = dao.getAllEvents();

}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Arial,sans-serif;
    background:#f4f4f4;
}

.header{
    background:#007bff;
    color:white;
    text-align:center;
    padding:20px;
}

.container{
    width:92%;
    margin:30px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,.2);
}

h2{
    margin-bottom:15px;
}

p{
    margin-bottom:10px;
    font-size:17px;
}

.btn-group{
    margin:25px 0;
}

/* My Bookings Button */

.booking-btn{
    display:inline-block;
    background:#0d6efd;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:5px;
    margin-right:10px;
    font-weight:bold;
    transition:.3s;
}

.booking-btn:hover{
    background:#0b5ed7;
    color:white;
}

/* Logout Button */

.logout-btn{
    display:inline-block;
    background:#dc3545;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:5px;
    margin-right:10px;
    font-weight:bold;
}

.logout-btn:hover{
    background:#b52b3a;
}

/* Add Event Button */

.add-btn{
    display:inline-block;
    background:#28a745;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:5px;
    font-weight:bold;
}

.add-btn:hover{
    background:#218838;
}

/* Search */

.search-box{
    margin:20px 0;
}

.search-box input[type=text]{
    width:260px;
    padding:10px;
    border:1px solid #ccc;
    border-radius:5px;
    font-size:15px;
}

.search-box select{
    padding:10px;
    border:1px solid #ccc;
    border-radius:5px;
    font-size:15px;
    margin-left:8px;
    margin-right:8px;
}

.search-btn{
    padding:10px 18px;
    background:#007bff;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
    font-weight:bold;
}

.search-btn:hover{
    background:#0056b3;
}

.clear-btn{
    display:inline-block;
    padding:10px 18px;
    background:#6c757d;
    color:white;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
    margin-left:8px;
}

.clear-btn:hover{
    background:#5a6268;
}

/* Table */

table{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
    table-layout:fixed;
}

table th{
    background:#007bff;
    color:white;
    padding:12px;
    text-align:center;
}

table td{
    border:1px solid #ddd;
    padding:12px;
    text-align:center;
    vertical-align:middle;
    word-wrap:break-word;
    overflow-wrap:break-word;
}

table tr:nth-child(even){
    background:#f8f8f8;
}

table tr:hover{
    background:#eef6ff;
}

/* Action Buttons */

.action-buttons{
    display:flex;
    justify-content:center;
    gap:8px;
}

.edit-btn,
.delete-btn{
    width:75px;
    padding:8px 0;
    text-align:center;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

.edit-btn{
    background:#ffc107;
    color:black;
}

.edit-btn:hover{
    background:#e0a800;
}

.delete-btn{
    background:#dc3545;
    color:white;
}

.delete-btn:hover{
    background:#b52b3a;
}

/* Dashboard Cards */

.dashboard-cards{
    display:flex;
    gap:20px;
    margin-top:30px;
    flex-wrap:wrap;
}

.stat-card{
    flex:1;
    min-width:220px;
    background:#007bff;
    color:white;
    padding:25px;
    border-radius:10px;
    text-align:center;
    box-shadow:0 4px 10px rgba(0,0,0,.2);
}

.stat-card h3{
    font-size:20px;
    margin-bottom:10px;
}

.stat-card h1{
    font-size:40px;
}

/* Book Button */

.action-cell{
    text-align:center;
    vertical-align:middle;
    width:140px;
}

.book-btn{
    display:inline-block;
    width:100px;
    padding:10px 0;
    background:#28a745;
    color:white;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
    text-align:center;
    white-space:nowrap;
}

.book-btn:hover{
    background:#1e7e34;
}

</style>
</head>

<body>

<div class="header">
    <h2>Event Management Ticketing System</h2>
</div>

<div class="container">
<div class="card">

<h2>Welcome, <%= user.getName() %></h2>

<p><strong>Email:</strong> <%= user.getEmail() %></p>
<p><strong>Role:</strong> <%= user.getRole() %></p>

<div class="btn-group">

<a href="myBookings.jsp" class="booking-btn">📖 My Bookings</a>

<a href="LogoutServlet" class="logout-btn">Logout</a>

<%
if(user.getRole().equalsIgnoreCase("ADMIN") ||
   user.getRole().equalsIgnoreCase("ORGANIZER")){
%>

<a href="addEvent.jsp" class="add-btn">Add New Event</a>

<%
}
%>

</div>

<h2>Available Events</h2>

<div class="search-box">

<form action="dashboard.jsp" method="get">

<input
type="text"
name="keyword"
placeholder="Search Event Name..."
value="<%= keyword==null ? "" : keyword %>">

<select name="sort">

<option value="">Sort By</option>
<option value="priceLow">Price: Low to High</option>
<option value="priceHigh">Price: High to Low</option>
<option value="dateNew">Newest Date</option>
<option value="dateOld">Oldest Date</option>
<option value="seatHigh">Seats: High to Low</option>
<option value="seatLow">Seats: Low to High</option>

</select>

<input
type="submit"
value="Apply"
class="search-btn">

<a href="dashboard.jsp" class="clear-btn">
Clear
</a>

</form>

</div>

<table>

<tr>
    <th>ID</th>
    <th>Event Name</th>
    <th>Description</th>
    <th>Venue</th>
    <th>Date</th>
    <th>Time</th>
    <th>Price</th>
    <th>Seats</th>
    <th>Action</th>
</tr>

<%
for(Event e : events){
%>

<tr>

<td><%= e.getEventId() %></td>

<td><%= e.getEventName() %></td>

<td><%= e.getDescription() %></td>

<td><%= e.getVenue() %></td>

<td><%= e.getEventDate() %></td>

<td><%= e.getEventTime() %></td>

<td>Rs. <%= e.getTicketPrice() %></td>

<td><%= e.getAvailableSeats() %> / <%= e.getTotalSeats() %></td>

<td>

<%
if(user.getRole().equalsIgnoreCase("ADMIN") ||
   user.getRole().equalsIgnoreCase("ORGANIZER")){
%>

<div class="action-buttons">

<a href="editEvent.jsp?id=<%= e.getEventId() %>" class="edit-btn">
Edit
</a>

<a href="DeleteEventServlet?id=<%= e.getEventId() %>"
class="delete-btn"
onclick="return confirm('Are you sure you want to delete this event?');">
Delete
</a>

</div>

<%
}
else{

    if(e.getAvailableSeats() == 0){
%>

<span style="
display:inline-block;
background:#dc3545;
color:white;
padding:10px 18px;
border-radius:5px;
font-weight:bold;
">
SOLD OUT
</span>

<%
    }
    else if(e.getAvailableSeats() < 10){
%>

<div>

<a href="bookTicket.jsp?eventId=<%= e.getEventId() %>"
class="book-btn">
Book Now
</a>

<br><br>

<span style="
color:#dc3545;
font-weight:bold;
font-size:14px;
">
⚠ Only <%= e.getAvailableSeats() %> seats left!
</span>

</div>

<%
    }
    else{
%>

<a href="bookTicket.jsp?eventId=<%= e.getEventId() %>"
class="book-btn">
Book Now
</a>

<%
    }
}
%>

</td>

</tr>

<%
}
%>

</table>
<!-- Dashboard Statistics -->

<div class="dashboard-cards">

    <div class="stat-card">
        <h3>Total Events</h3>
        <h1><%= events.size() %></h1>
    </div>

    <div class="stat-card">
        <h3>Total Available Seats</h3>
        <h1>
            <%
                int seats = 0;
                for(Event e : events){
                    seats += e.getAvailableSeats();
                }
                out.print(seats);
            %>
        </h1>
    </div>

    <div class="stat-card">
        <h3>Total Revenue</h3>
        <h1>
            Rs.
            <%
                double revenue = 0;
                for(Event e : events){
                    revenue += e.getTicketPrice();
                }
                out.print(revenue);
            %>
        </h1>
    </div>

    <div class="stat-card">
        <h3>Total Bookings</h3>
        <h1><%= totalBookings %></h1>
    </div>

</div>

<!-- ================= CONFIRMED BOOKINGS ================= -->

<h2 style="margin-top:40px;color:#007bff;">
    Confirmed Bookings
</h2>

<table>

    <tr>
        <th>Booking ID</th>
        <th>User</th>
        <th>Event</th>
        <th>Seats</th>
        <th>Total Amount</th>
        <th>Booking Date</th>
    </tr>

    <% for(Booking booking : bookings){ %>

    <tr>
        <td><%= booking.getBookingId() %></td>
        <td><%= booking.getUserName() %></td>
        <td><%= booking.getEventName() %></td>
        <td><%= booking.getSeatsBooked() %></td>
        <td>Rs. <%= booking.getTotalAmount() %></td>
        <td><%= booking.getBookingDate() %></td>
    </tr>

    <% } %>

</table>

</div>

</div>

</body>

</html>