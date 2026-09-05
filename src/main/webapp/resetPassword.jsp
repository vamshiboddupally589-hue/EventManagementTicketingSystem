<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String email = request.getParameter("email");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Reset Password</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f4f6f9;
}

.container{
    width:420px;
    margin:100px auto;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 5px 15px rgba(0,0,0,.2);
}

h2{
    text-align:center;
    color:#007bff;
    margin-bottom:25px;
}

input{
    width:100%;
    padding:12px;
    margin-bottom:20px;
    box-sizing:border-box;
}

button{
    width:100%;
    padding:12px;
    background:#28a745;
    color:white;
    border:none;
    font-size:16px;
    border-radius:5px;
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

<h2>Reset Password</h2>

<form action="ResetPasswordServlet" method="post">

<label><b>Email</b></label>

<input
type="email"
value="<%= email %>"
readonly>

<input
type="hidden"
name="email"
value="<%= email %>">

<label><b>New Password</b></label>

<input
type="password"
name="password"
placeholder="Enter New Password"
required>

<label><b>Confirm Password</b></label>

<input
type="password"
name="confirmPassword"
placeholder="Confirm Password"
required>

<button type="submit">
Update Password
</button>

</form>

</div>

</div>

</body>

</html>