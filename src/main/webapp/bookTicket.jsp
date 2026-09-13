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
    font-family:Arial, sans-serif;
    background:#f4f6f9;
}

.container{
    width:600px;
    margin:50px auto;
}

.card{
    background:#fff;
    padding:35px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
}

h2{
    color:#0d6efd;
    margin-bottom:25px;
}

p{
    font-size:18px;
    margin:12px 0;
}

.price-box{
    background:#eef5ff;
    padding:15px;
    border-radius:8px;
    margin:20px 0;
}

.price-box h3{
    margin:0;
    color:#0d6efd;
}

.price{
    font-size:30px;
    font-weight:bold;
    color:#28a745;
    margin-top:10px;
}

label{
    font-size:18px;
    font-weight:bold;
}

select,
input[type=number]{

    width:100%;
    padding:12px;
    margin-top:10px;
    margin-bottom:20px;
    font-size:16px;
    border:1px solid #ccc;
    border-radius:6px;

}

button{

    width:100%;
    background:#28a745;
    color:white;
    border:none;
    padding:14px;
    font-size:18px;
    border-radius:8px;
    cursor:pointer;
    transition:.3s;

}

button:hover{

    background:#218838;

}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>🎟 Book Ticket</h2>

<p><b>Event:</b> <%= event.getEventName() %></p>

<p><b>Venue:</b> <%= event.getVenue() %></p>

<p><b>Date:</b> <%= event.getEventDate() %></p>

<p><b>Available Seats:</b> <%= event.getAvailableSeats() %></p>

<%
if(event.getAvailableSeats() > 0){
%>

<form action="BookTicketServlet" method="post">

<input
type="hidden"
name="eventId"
value="<%= event.getEventId() %>">

<label>Ticket Type</label>
<select
name="ticketType"
id="ticketType"
onchange="updatePrice()"
required>

    <option value="Regular">Regular</option>
    <option value="VIP">VIP</option>

</select>

<br><br>

<div class="price-box">

    <h3>Ticket Price</h3>

    <div class="price">
        ₹ <span id="ticketPrice"></span>
    </div>

</div>

<br>

<label>Number of Tickets</label>

<input
type="number"
name="quantity"
min="1"
max="<%= event.getAvailableSeats() %>"
value="1"
required>

<button type="submit">
Book Ticket
</button>

</form>

<%
}else{
%>

<div style="background:#ffe5e5;padding:20px;border-radius:8px;text-align:center;">

<h2 style="color:red;">
❌ SOLD OUT
</h2>

</div>

<%
}
%>

</div>

</div>

<script>

const regularPrice = <%= event.getTicketPrice() %>;
const vipPrice = <%= event.getVipPrice() %>;


console.log("Regular Price =", regularPrice);
console.log("VIP Price =", vipPrice);
function updatePrice(){

    const type = document.getElementById("ticketType").value;

    console.log("Selected Type = " + type);

    if(type === "VIP"){

        console.log("Setting VIP Price = " + vipPrice);

        document.getElementById("ticketPrice").innerHTML = vipPrice;

    }else{

        console.log("Setting Regular Price = " + regularPrice);

        document.getElementById("ticketPrice").innerHTML = regularPrice;

    }

    console.log("Displayed Price = " +
        document.getElementById("ticketPrice").innerHTML);
}
</script>

</body>
</html>