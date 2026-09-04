<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.dao.EventDAO"%>
<%@page import="com.mycompany.eventmanagement.model.Event"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

EventDAO dao = new EventDAO();

Event event = dao.getEventById(id);
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Event</title>

<style>

body{
    font-family:Arial;
    background:#f4f4f4;
}

.container{
    width:500px;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px gray;
}

input,textarea{
    width:100%;
    padding:10px;
    margin-bottom:15px;
    border:1px solid #ccc;
    border-radius:5px;
}

label{
    font-weight:bold;
}

.info-box{
    background:#eef5ff;
    border-left:5px solid #0d6efd;
    padding:12px;
    margin-top:-8px;
    margin-bottom:20px;
    border-radius:5px;
    font-size:15px;
}

button{
    background:#007bff;
    color:white;
    border:none;
    padding:12px 20px;
    border-radius:5px;
    cursor:pointer;
    width:100%;
    font-size:16px;
}

button:hover{
    background:#0056b3;
}

</style>

</head>

<body>

<div class="container">

<h2>Edit Event</h2>

<form action="UpdateEventServlet" method="post">

<input
type="hidden"
name="eventId"
value="<%= event.getEventId() %>">

<label>Event Name</label>

<input
type="text"
name="eventName"
value="<%= event.getEventName() %>"
required>

<label>Description</label>

<textarea
name="description"
required><%= event.getDescription() %></textarea>

<label>Venue</label>

<input
type="text"
name="venue"
value="<%= event.getVenue() %>"
required>

<label>Date</label>

<input
type="date"
name="eventDate"
value="<%= event.getEventDate() %>"
required>

<label>Time</label>

<input
type="time"
name="eventTime"
value="<%= event.getEventTime() %>"
required>

<label>Ticket Price</label>

<input
type="number"
step="0.01"
name="ticketPrice"
value="<%= event.getTicketPrice() %>"
required>

<label>Total Seats</label>

<input
type="number"
name="totalSeats"
value="<%= event.getTotalSeats() %>"
min="<%= event.getTotalSeats() - event.getAvailableSeats() %>"
required>

<label>Available Seats</label>

<input
type="number"
name="availableSeats"
value="<%= event.getAvailableSeats() %>"
required>

<div class="info-box">

<b>Sold Seats :</b>
<%= event.getTotalSeats() - event.getAvailableSeats() %>

<br><br>

<b>Available Seats :</b>
<%= event.getAvailableSeats() %>

<br><br>

<b>Current Capacity :</b>
<%= event.getAvailableSeats() %> / <%= event.getTotalSeats() %>

</div>

<button type="submit">
Update Event
</button>

</form>

</div>

</body>

</html>