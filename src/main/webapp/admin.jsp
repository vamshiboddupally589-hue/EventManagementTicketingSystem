<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>
<%@page import="com.mycompany.eventmanagement.dao.EventDAO"%>
<%@page import="com.mycompany.eventmanagement.dao.UserDAO"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
EventDAO eventDAO = new EventDAO();

int totalEvents = eventDAO.getTotalEvents();
int totalSeats = eventDAO.getTotalAvailableSeats();
int totalBookings = eventDAO.getTotalBookings();

UserDAO userDAO = new UserDAO();
int totalUsers = userDAO.getTotalUsers();
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
    background:linear-gradient(135deg,#eef2ff,#f8fafc);
    margin:0;
    padding:0;
}

.container{
    width:90%;
    max-width:1000px;
    margin:50px auto;
}
.card{
    background:#fff;
    padding:35px;
    border-radius:15px;
    box-shadow:0 10px 25px rgba(0,0,0,0.12);
}

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}

.header h1{
    margin:0;
    color:#1e3a8a;
    font-size:32px;
    text-align:left;
}

.header h3{
    margin-top:8px;
    margin-bottom:0;
    color:#666;
    font-size:18px;
    font-weight:normal;
    text-align:left;
}


.menu{
    margin-top:30px;
    display:flex;
    gap:20px;
    flex-wrap:wrap;
}

.stats{
    display:flex;
    justify-content:space-between;
    gap:20px;
    margin:30px 0;
    flex-wrap:wrap;
}

.stat-card{
    flex:1;
    min-width:180px;
    background:white;
    border-radius:12px;
    padding:20px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
    transition:0.3s;
}

.stat-card:hover{
    transform:translateY(-5px);
    box-shadow:0 8px 18px rgba(0,0,0,0.15);
}

.stat-card h2{
    font-size:32px;
    margin:0;
}

.stat-card h3{
    margin:10px 0;
    color:#555;
    font-size:18px;
}

.stat-card p{
    font-size:28px;
    font-weight:bold;
    color:#2563eb;
    margin:0;
}
.menu a{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:10px;
    width:220px;
    height:55px;
    text-decoration:none;
    color:white;
    border-radius:8px;
    font-size:17px;
    font-weight:600;
    letter-spacing:0.3px;
    transition:all .3s ease;
}
.menu a:hover{
    background:#0056b3;
    transform:translateY(-3px);
    box-shadow:0 6px 15px rgba(0,0,0,0.2);
}

.events-btn{
    background:#2563eb;
}

.events-btn:hover{
    background:#1d4ed8;
}

.users-btn{
    background:#16a34a;
}

.users-btn:hover{
    background:#15803d;
}

.booking-btn{
    background:#ea580c;
}

.booking-btn:hover{
    background:#c2410c;
}
.logout-btn{
    display:inline-flex;
    align-items:center;
    justify-content:center;
    width:120px;
    height:45px;
    background:#dc2626;
    color:white;
    text-decoration:none;
    border-radius:8px;
    font-size:16px;
    font-weight:600;
    transition:0.3s;
}

.logout-btn:hover{
    background:#b91c1c;
    transform:translateY(-2px);
}
</style>

</head>

<body>

<div class="container">

<div class="card">

<div class="header">

    <div>
        <h1>🎛️ Admin Dashboard</h1>
        <h3>Administrator: <%= user.getName() %></h3>
    </div>

    <a href="LogoutServlet" class="logout-btn">Logout</a>

</div>

<div class="stats">

    <div class="stat-card">
        <h2>🎪</h2>
        <h3>Total Events</h3>
        <p><%= totalEvents %></p>
    </div>

    <div class="stat-card">
        <h2>👥</h2>
        <h3>Total Users</h3>
        <p><%= totalUsers%></p>
    </div>

    <div class="stat-card">
        <h2>🎟️</h2>
        <h3>Total Bookings</h3>
        <p><%= totalBookings%></p>
    </div>

    <div class="stat-card">
        <h2>💺</h2>
        <h3>Available Seats</h3>
        <p><%= totalSeats %></p>
    </div>

</div>

<div class="menu">

<div class="menu">

    <a href="dashboard.jsp?admin=true" class="events-btn">
        🎪 Manage Events
    </a>

    <a href="manageUsers.jsp" class="users-btn">
        👥 Manage Users
    </a>

    <a href="viewBookings.jsp" class="booking-btn">
        🎟️ View Bookings
    </a>

</div>

</div>

</div>

</body>

</html>