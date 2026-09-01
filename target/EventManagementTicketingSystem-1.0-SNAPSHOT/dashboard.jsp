<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
            margin:0;
            padding:0;
        }

        .header{

            background:#007bff;
            color:white;
            padding:20px;
        }

        .container{

            width:80%;
            margin:30px auto;
        }

        .card{

            background:white;
            padding:20px;
            border-radius:8px;
            box-shadow:0px 0px 8px gray;
        }

        a{

            text-decoration:none;
            color:white;
            background:red;
            padding:10px 20px;
            border-radius:5px;
        }

    </style>

</head>

<body>

<div class="header">

<h2>Event Management Ticketing System</h2>

</div>

<div class="container">

<div class="card">

<h3>Welcome, <%= user.getName() %></h3>

<p>Email : <%= user.getEmail() %></p>

<p>Role : <%= user.getRole() %></p>

<br>

<a href="LogoutServlet">Logout</a>

</div>

</div>

</body>
</html>