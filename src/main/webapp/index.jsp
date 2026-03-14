<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Habit Tracker Login</title>

<style>

/* BACKGROUND */

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:linear-gradient(-45deg,#ff6ec4,#7873f5,#43e97b,#38f9d7);
background-size:600% 600%;
animation:gradientMove 15s ease infinite;
display:flex;
flex-direction:column;
justify-content:center;
align-items:center;
height:100vh;
}

@keyframes gradientMove{
0%{background-position:0% 50%;}
50%{background-position:100% 50%;}
100%{background-position:0% 50%;}
}

/* MAIN HEADING */

.main-title{
font-size:50px;
font-weight:bold;
color:white;
margin-bottom:30px;
background:linear-gradient(45deg,#ffffff,#00fff2,#ff6ec4);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
text-shadow:0 0 20px rgba(0,0,0,0.4);
animation:glowTitle 3s infinite alternate;
}

@keyframes glowTitle{
0%{text-shadow:0 0 10px #fff;}
100%{text-shadow:0 0 25px #00fff2;}
}

/* LOGIN CARD */

.card{
background:rgba(255,255,255,0.25);
backdrop-filter:blur(12px);
padding:40px;
border-radius:18px;
width:340px;
box-shadow:0 15px 35px rgba(0,0,0,0.3);
text-align:center;
}

/* LOGIN HEADING */

.login-title{
font-size:28px;
font-weight:bold;
color:#fff;
margin-bottom:10px;
}

/* LABEL */

label{
display:block;
text-align:left;
font-weight:bold;
margin-top:15px;
color:#fff;
}

/* INPUT */

input{
width:100%;
padding:10px;
margin-top:5px;
border-radius:8px;
border:none;
outline:none;
font-size:14px;
transition:0.3s;
}

input:hover{
box-shadow:0 0 10px #00fff2;
}

/* LOGIN BUTTON */

.login-btn{
margin-top:20px;
padding:12px;
width:100%;
border:none;
border-radius:30px;
background:linear-gradient(45deg,#ff6ec4,#7873f5);
color:white;
font-size:16px;
font-weight:bold;
cursor:pointer;
position:relative;
overflow:hidden;
transition:0.3s;
}

/* WATER DROP EFFECT */

.login-btn::after{
content:"";
position:absolute;
width:0;
height:0;
background:rgba(255,255,255,0.5);
border-radius:50%;
top:50%;
left:50%;
transform:translate(-50%,-50%);
transition:0.6s;
}

.login-btn:hover::after{
width:300px;
height:300px;
}

.login-btn:hover{
transform:scale(1.05);
box-shadow:0 0 15px white;
}

/* CREATE ACCOUNT BUTTON */

.create{
margin-top:15px;
display:inline-block;
padding:10px 20px;
border-radius:20px;
background:linear-gradient(45deg,#43e97b,#38f9d7);
color:white;
text-decoration:none;
font-weight:bold;
transition:0.3s;
}

.create:hover{
transform:scale(1.05);
box-shadow:0 0 10px white;
}

/* ERROR MESSAGE */

.error{
margin-top:10px;
color:#ffdddd;
font-weight:bold;
}

</style>

</head>

<body>

<h1 class="main-title">Habit Tracker</h1>

<div class="card">

<div class="login-title">Login</div>

<form action="login" method="post">

<label>Gmail</label>
<input type="email" name="email" placeholder="Enter your gmail" required>

<label>Password</label>
<input type="password" name="password" placeholder="Enter your password" required>

<button type="submit" class="login-btn">Login</button>

</form>

<%
if(error != null){
%>
<div class="error">Invalid email or password</div>
<%
}
%>

<a class="create" href="register.jsp">Create Account</a>

</div>

</body>
</html>