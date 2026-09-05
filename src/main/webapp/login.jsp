<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Event Management System - Login</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f2f2f2;
}

.login-box{

    width:350px;
    margin:100px auto;
    background:white;
    padding:25px;
    border-radius:8px;
    box-shadow:0 0 10px gray;
}

h2{
    text-align:center;
}

.error{
    color:red;
    text-align:center;
    font-weight:bold;
    margin-bottom:15px;
}

.success{
    color:green;
    text-align:center;
    font-weight:bold;
    margin-bottom:15px;
}

input{

    width:100%;
    padding:10px;
    margin-top:10px;
    margin-bottom:15px;
    box-sizing:border-box;
}

button{

    width:100%;
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    cursor:pointer;
}

button:hover{

    background:#0056b3;
}

.forgot-link{

    margin-top:15px;
    text-align:left;
}

.forgot-link a{

    color:#007bff;
    text-decoration:none;
    font-size:15px;
}

.forgot-link a:hover{

    text-decoration:underline;
}

hr{

    margin:20px 0;
    border:none;
    border-top:1px solid #ddd;
}

.register-link{

    text-align:center;
}

.register-link p{

    margin-bottom:10px;
    color:#444;
    font-size:16px;
}

.register-link a{

    color:#007bff;
    text-decoration:none;
    font-size:18px;
    font-weight:bold;
}

.register-link a:hover{

    text-decoration:underline;
}

</style>

</head>

<body>

<div class="login-box">

<h2>User Login</h2>

<%
String error = request.getParameter("error");

if("invalid".equals(error)){
%>

<div class="error">
Invalid Email or Password!
</div>

<%
}

String reset = request.getParameter("reset");

if("success".equals(reset)){
%>

<div class="success">
Password Updated Successfully!
</div>

<%
}

String register = request.getParameter("register");

if("success".equals(register)){
%>

<div class="success">
Registration Successful! Please Login.
</div>

<%
}
%>

<form action="LoginServlet" method="post">

    <input
        type="email"
        name="email"
        placeholder="Enter Email"
        required>

    <input
        type="password"
        name="password"
        placeholder="Enter Password"
        required>

    <button type="submit">
        Login
    </button>

</form>

<div class="forgot-link">
    <a href="forgotPassword.jsp">Forgot Password?</a>
</div>

<hr>

<div class="register-link">

    <p>Don't have an account?</p>

    <a href="register.jsp">
        Create New Account
    </a>

</div>

</div>

</body>

</html>