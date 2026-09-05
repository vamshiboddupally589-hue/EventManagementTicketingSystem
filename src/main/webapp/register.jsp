<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>User Registration</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f2f2f2;
}

.container{
    width:420px;
    margin:60px auto;
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

.error{
    color:red;
    text-align:center;
    font-weight:bold;
    margin-bottom:15px;
}

input{
    width:100%;
    padding:12px;
    margin-bottom:15px;
    box-sizing:border-box;
}

button{
    width:100%;
    padding:12px;
    border:none;
    background:#28a745;
    color:white;
    font-size:16px;
    border-radius:5px;
    cursor:pointer;
}

button:hover{
    background:#218838;
}

.login{
    text-align:center;
    margin-top:20px;
}

.login a{
    text-decoration:none;
    color:#007bff;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>Create Account</h2>

<%
String error=request.getParameter("error");

if("exists".equals(error)){
%>

<div class="error">
Email already registered!
</div>

<%
}

if("password".equals(error)){
%>

<div class="error">
Passwords do not match!
</div>

<%
}
%>

<form action="RegisterServlet" method="post">

<input
type="text"
name="name"
placeholder="Full Name"
required>

<input
type="email"
name="email"
placeholder="Email Address"
required>

<input
type="text"
name="phone"
placeholder="Phone Number"
required>

<input
type="password"
name="password"
placeholder="Password"
required>

<input
type="password"
name="confirmPassword"
placeholder="Confirm Password"
required>

<button type="submit">
Register
</button>

</form>

<div class="login">

Already have an account?

<br><br>

<a href="login.jsp">

Login Here

</a>

</div>

</div>

</div>

</body>

</html>