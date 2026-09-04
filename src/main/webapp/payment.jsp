<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String userId = String.valueOf(request.getAttribute("userId"));
String ticketId = String.valueOf(request.getAttribute("ticketId"));

String eventId = String.valueOf(request.getAttribute("eventId"));
String quantity = String.valueOf(request.getAttribute("quantity"));
String total = String.valueOf(request.getAttribute("total"));
String eventName = String.valueOf(request.getAttribute("eventName"));
String ticketType = String.valueOf(request.getAttribute("ticketType"));
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Payment</title>

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
    width:500px;
    margin:50px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,.2);
}

h2{
    text-align:center;
    color:#0d6efd;
    margin-bottom:25px;
}

.info{
    margin-bottom:15px;
    font-size:17px;
}

select{
    width:100%;
    padding:12px;
    margin-top:10px;
    margin-bottom:25px;
}

button{
    width:100%;
    padding:14px;
    border:none;
    background:#28a745;
    color:white;
    font-size:16px;
    border-radius:6px;
    cursor:pointer;
}

button:hover{
    background:#218838;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>Payment</h2>

<div class="info">
<b>Event :</b>
<%= eventName %>
</div>

<div class="info">
<b>Ticket Type :</b>
<%= ticketType %>
</div>

<div class="info">
<b>Tickets :</b>
<%= quantity %>
</div>

<form action="PaymentServlet" method="post">

<!-- Hidden values -->

<input type="hidden" name="userId" value="<%= userId %>">

<input type="hidden" name="ticketId" value="<%= ticketId %>">

<input type="hidden" name="eventId" value="<%= eventId %>">

<input type="hidden" name="eventName" value="<%= eventName %>">

<input type="hidden" name="ticketType" value="<%= ticketType %>">

<input type="hidden" name="quantity" value="<%= quantity %>">

<input type="hidden" name="total" value="<%= total %>">

<label><b>Payment Method</b></label>

<select name="paymentMethod" required>

<option value="">Select Payment</option>

<option value="UPI">UPI</option>

<option value="Credit Card">Credit Card</option>

<option value="Debit Card">Debit Card</option>

<option value="Net Banking">Net Banking</option>

<option value="Cash">Cash on Entry</option>

</select>

<button type="submit">
Proceed Payment
</button>

</form>

</div>

</div>

</body>
</html>