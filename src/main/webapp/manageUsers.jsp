<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eventmanagement.dao.UserDAO"%>
<%@page import="com.mycompany.eventmanagement.model.User"%>

<%
User admin = (User) session.getAttribute("user");

if(admin == null){
    response.sendRedirect("login.jsp");
    return;
}

if(!admin.getRole().equalsIgnoreCase("ADMIN")){
    response.sendRedirect("dashboard.jsp");
    return;
}

UserDAO dao = new UserDAO();
List<User> users = dao.getAllUsers();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Manage Users</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f4f4f4;
}

.container{
    width:90%;
    margin:40px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,.2);
}

h2{
    margin-bottom:20px;
    color:#007bff;
}

table{
    width:100%;
    border-collapse:collapse;
}

table th{
    background:#007bff;
    color:white;
    padding:12px;
}

table td{
    border:1px solid #ddd;
    padding:10px;
    text-align:center;
}

table tr:nth-child(even){
    background:#f8f8f8;
}

.back-btn{
    display:inline-block;
    margin-top:20px;
    padding:10px 20px;
    background:#28a745;
    color:white;
    text-decoration:none;
    border-radius:5px;
    font-weight:bold;
}

.back-btn:hover{
    background:#218838;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>Manage Users</h2>

<table>

<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Role</th>
    <th>Status</th>
</tr>

<%
for(User u : users){
%>

<tr>

<td><%= u.getUserId() %></td>
<td><%= u.getName() %></td>
<td><%= u.getEmail() %></td>
<td><%= u.getPhone() %></td>
<td><%= u.getRole() %></td>
<td><%= u.getStatus() %></td>

</tr>

<%
}
%>

</table>

<a href="admin.jsp" class="back-btn">← Back to Admin Panel</a>

</div>

</div>

</body>

</html>