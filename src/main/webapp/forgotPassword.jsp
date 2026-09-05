<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Forgot Password</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f4f6f9;
}

.container{
    width:400px;
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

.error{
    color:red;
    text-align:center;
    font-weight:bold;
    margin-bottom:15px;
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
    border:none;
    background:#007bff;
    color:white;
    font-size:16px;
    cursor:pointer;
    border-radius:5px;
}

button:hover{
    background:#0056b3;
}

.back{
    text-align:center;
    margin-top:20px;
}

.back a{
    text-decoration:none;
    color:#007bff;
}

</style>

</head>

<body>

<div class="container">

<div class="card">

<h2>Forgot Password</h2>

<%
String error = request.getParameter("error");

if("notfound".equals(error)){
%>

<div class="error">
    Email not found!
</div>

<%
}
%>

<form action="ForgotPasswordServlet" method="post">

<input
type="email"
name="email"
placeholder="Enter Registered Email"
required>

<button type="submit">
Continue
</button>

</form>

<div class="back">

<a href="login.jsp">
Back to Login
</a>

</div>

</div>

</div>

</body>

</html>