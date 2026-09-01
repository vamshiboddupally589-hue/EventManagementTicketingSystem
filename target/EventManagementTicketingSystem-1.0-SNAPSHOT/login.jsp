<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Management System - Login</title>

    <style>

        body{
            font-family: Arial, sans-serif;
            background:#f2f2f2;
        }

        .login-box{

            width:350px;
            margin:100px auto;
            background:white;
            padding:25px;
            border-radius:8px;
            box-shadow:0px 0px 10px gray;
        }

        h2{
            text-align:center;
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

    </style>

</head>

<body>

    <div class="login-box">

        <h2>User Login</h2>

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

    </div>

</body>
</html>