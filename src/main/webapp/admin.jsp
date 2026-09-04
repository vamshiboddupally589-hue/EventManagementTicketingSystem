<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

// Only ADMIN can access this page
if(!user.getRole().equalsIgnoreCase("ADMIN")){
    response.sendRedirect("dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Panel</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f4f4f4;
}

.container{
    width:80%;
    margin:40px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,.2);
}

h1{
    color:#007bff;
    margin-bottom:10px;
}

h3{
    margin-bottom:25px;
}

.menu{
    margin-top:20px;
}

.menu a{
    display:block;
    width:260px;
    padding:15px;
    margin-bottom:15px;
    text-decoration:none;
    color:white;
    background:#007bff;
    border-radius:8px;
    text-align:center;
    font-weight:bold;
}

.menu a:hover{
    background:#0056b3;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h1>Admin Panel</h1>

<h3>Welcome, <%= user.getName() %></h3>

<div class="menu">

<a href="dashboard.jsp?admin=true">Manage Events</a>

<a href="manageUsers.jsp">Manage Users</a>

<a href="viewBookings.jsp">View Bookings</a>

<a href="LogoutServlet">Logout</a>

</div>

</div>

</div>

</body>

</html>