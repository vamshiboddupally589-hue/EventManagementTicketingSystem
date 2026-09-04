<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Add Event</title>

    <style>

        body{
            font-family:Arial;
            background:#f2f2f2;
        }

        .container{

            width:500px;
            margin:30px auto;
            background:white;
            padding:25px;
            border-radius:10px;
            box-shadow:0px 0px 10px gray;
        }

        h2{
            text-align:center;
        }

        input, textarea{

            width:100%;
            padding:10px;
            margin-top:10px;
            margin-bottom:15px;
            box-sizing:border-box;
        }

        button{

            width:100%;
            padding:12px;
            background:green;
            color:white;
            border:none;
            cursor:pointer;
            font-size:16px;
        }

        button:hover{

            background:darkgreen;
        }

    </style>

</head>

<body>

<div class="container">

<h2>Add New Event</h2>

<form action="AddEventServlet" method="post">

<input
type="text"
name="eventName"
placeholder="Event Name"
required>

<textarea
name="description"
placeholder="Description"
required>
</textarea>

<input
type="text"
name="venue"
placeholder="Venue"
required>

<input
type="date"
name="eventDate"
required>

<input
type="time"
name="eventTime"
required>

<input
type="number"
name="ticketPrice"
placeholder="Ticket Price"
required>

<input
type="number"
name="totalSeats"
placeholder="Total Seats"
required>

<button type="submit">
Add Event
</button>

</form>

</div>

</body>
</html>