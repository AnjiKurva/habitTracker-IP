<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Add Habit</title>

<style>

/* BACKGROUND */

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:linear-gradient(-45deg,#ff6ec4,#7873f5,#43e97b,#38f9d7);
background-size:400% 400%;
animation:gradientBG 15s ease infinite;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
overflow:hidden;
}

@keyframes gradientBG{
0%{background-position:0% 50%;}
50%{background-position:100% 50%;}
100%{background-position:0% 50%;}
}

/* FLOATING BUBBLES */

.bubble{
position:absolute;
bottom:-100px;
width:40px;
height:40px;
background:rgba(255,255,255,0.3);
border-radius:50%;
animation:float 12s infinite;
}

@keyframes float{
0%{
transform:translateY(0);
opacity:1;
}
100%{
transform:translateY(-120vh);
opacity:0;
}
}

/* CARD */

.card{
background:rgba(255,255,255,0.2);
backdrop-filter:blur(10px);
padding:40px;
border-radius:16px;
width:340px;
box-shadow:0 10px 30px rgba(0,0,0,0.3);
text-align:center;
}

/* TITLE */

.title{
font-size:30px;
font-weight:bold;
color:white;
margin-bottom:15px;
}

/* INPUT */

input,select{
width:100%;
padding:10px;
margin-top:10px;
border-radius:10px;
border:none;
outline:none;
font-size:14px;
transition:0.3s;
}

input:hover,select:hover{
box-shadow:0 0 10px #fff;
}

/* LIQUID BUTTON */

.btn{
margin-top:15px;
padding:12px;
width:100%;
border:none;
border-radius:25px;
background:linear-gradient(45deg,#22c55e,#3b82f6);
color:white;
font-weight:bold;
cursor:pointer;
transition:0.4s;
position:relative;
overflow:hidden;
}

.btn:hover{
transform:scale(1.05);
box-shadow:0 0 12px white;
}

/* BACK BUTTON */

.back{
margin-top:10px;
padding:10px;
border:none;
border-radius:20px;
background:#ef4444;
color:white;
cursor:pointer;
}

.back:hover{
transform:scale(1.05);
}

</style>

</head>

<body>

<!-- Floating bubbles -->

<div class="bubble" style="left:10%;animation-delay:0s"></div>
<div class="bubble" style="left:25%;animation-delay:2s"></div>
<div class="bubble" style="left:40%;animation-delay:4s"></div>
<div class="bubble" style="left:60%;animation-delay:6s"></div>
<div class="bubble" style="left:75%;animation-delay:8s"></div>
<div class="bubble" style="left:90%;animation-delay:10s"></div>

<div class="card">

<div class="title">Add New Habit</div>

<form action="habit" method="post">

<input type="hidden" name="action" value="add">

<input type="text" name="habit_name" placeholder="Habit Name" required>

<input type="text" name="category" placeholder="Category" required>

<select name="frequency">

<option value="Daily">Daily</option>
<option value="Weekly">Weekly</option>

</select>

<button class="btn">Add Habit</button>

</form>

<a href="dashboard.jsp">
<button class="back">Back to Dashboard</button>
</a>

</div>

</body>
</html>