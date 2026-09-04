<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>
<%@page import="com.mycompany.eventmanagement.dao.UserDAO"%>
<%@page import="com.mycompany.eventmanagement.dao.EventDAO"%>
<%@page import="com.mycompany.eventmanagement.dao.BookingDAO"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}

// Allow only Admin
if(!user.getRole().equalsIgnoreCase("ADMIN")){
    response.sendRedirect("dashboard.jsp");
    return;
}

UserDAO userDAO = new UserDAO();
EventDAO eventDAO = new EventDAO();
BookingDAO bookingDAO = new BookingDAO();

int totalUsers = userDAO.getTotalUsers();
int totalEvents = eventDAO.getTotalEvents();
int totalBookings = bookingDAO.getTotalBookings();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

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
    background:#343a40;
    color:white;
    text-align:center;
    padding:20px;
}

.container{
    width:90%;
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
    margin-top:25px;
}

.btn{
    display:inline-block;
    background:#007bff;
    color:white;
    text-decoration:none;
    padding:10px 20px;
    border-radius:5px;
    font-weight:bold;
    margin-right:10px;
}

.btn:hover{
    background:#0056b3;
}

</style>

</head>

<body>

<div class="header">

<h2>Admin Dashboard</h2>

</div>

<div class="container">

<div class="card">

<h2>Welcome Admin, <%= user.getName() %></h2>

<p><strong>Email :</strong> <%= user.getEmail() %></p>

<p><strong>Role :</strong> <%= user.getRole() %></p>

<div class="btn-group">

<a href="dashboard.jsp" class="btn">Event Dashboard</a>

<a href="LogoutServlet" class="btn">Logout</a>

</div>

</div>

</div>

</body>

</html>