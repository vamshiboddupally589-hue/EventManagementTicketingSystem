<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.dao.EventDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Event"%>

<%
String id = request.getParameter("eventId");

EventDAO dao = new EventDAO();
Event event = dao.getEventById(Integer.parseInt(id));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Ticket</title>

<style>

body{
    font-family:Arial;
    background:#f4f4f4;
}

.container{
    width:500px;
    margin:50px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,.2);
}

h2{
    color:#007bff;
    margin-bottom:20px;
}

p{
    margin:10px 0;
    font-size:18px;
}

input[type=number]{
    width:100%;
    padding:10px;
    margin-top:15px;
    margin-bottom:20px;
    font-size:16px;
}

button{
    background:#28a745;
    color:white;
    border:none;
    padding:12px 20px;
    border-radius:5px;
    font-size:16px;
    cursor:pointer;
}

button:hover{
    background:#1e7e34;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>Book Ticket</h2>

<p><b>Event:</b> <%= event.getEventName() %></p>

<p><b>Venue:</b> <%= event.getVenue() %></p>

<p><b>Date:</b> <%= event.getEventDate() %></p>

<p><b>Regular Ticket Price:</b> ₹ <%= event.getTicketPrice() %></p>

<p><b>VIP Ticket Price:</b> ₹ <%= event.getVipPrice() %></p>

<%
if(event.getAvailableSeats() > 0){
%>

<form action="BookTicketServlet" method="post">

<input type="hidden"
name="eventId"
value="<%= event.getEventId() %>">

<label>Ticket Type</label>

<select name="ticketType" required>
    <option value="Regular">Regular</option>
    <option value="VIP">VIP</option>
</select>

<br><br>

<label>Number of Tickets</label>

<input
type="number"
name="quantity"
min="1"
max="<%= event.getAvailableSeats() %>"
required>

<button type="submit">
Book Ticket
</button>

</form>

<%
}else{
%>

<div style="
background:#ffe5e5;
border:2px solid red;
padding:20px;
border-radius:10px;
text-align:center;
margin-top:20px;">

<h2 style="color:red;">
❌ SOLD OUT
</h2>

<p style="font-size:18px;">
No seats are available for this event.
</p>

</div>

<%
}
%>

</div>

</div>

</body>
</html>