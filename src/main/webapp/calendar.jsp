<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String user=(String)session.getAttribute("user");

if(user==null){
response.sendRedirect("index.jsp");
return;
}

int completedDays=0;
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Habit Calendar</title>

<style>

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:linear-gradient(120deg,#667eea,#764ba2);
min-height:100vh;
padding:40px;
color:white;
}

/* HEADER */

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:30px;
}

.title{
font-size:34px;
font-weight:bold;
}

/* BUTTON */

button{
padding:10px 20px;
border:none;
border-radius:25px;
cursor:pointer;
font-weight:bold;
background:linear-gradient(45deg,#3b82f6,#60a5fa);
color:white;
transition:0.3s;
}

button:hover{
transform:scale(1.08);
box-shadow:0 0 10px #60a5fa;
}

/* CARD */

.card{
background:rgba(255,255,255,0.15);
backdrop-filter:blur(10px);
padding:25px;
border-radius:15px;
box-shadow:0 8px 20px rgba(0,0,0,0.3);
}

/* STATS */

.stats{
display:flex;
gap:30px;
margin-bottom:25px;
}

.stat-box{
background:white;
color:black;
padding:15px 20px;
border-radius:10px;
font-weight:bold;
box-shadow:0 5px 10px rgba(0,0,0,0.2);
}

/* CALENDAR GRID */

.calendar{
display:grid;
grid-template-columns:repeat(7,60px);
gap:12px;
margin-top:20px;
}

/* DAY BOX */

.day{
width:60px;
height:60px;
background:#e5e7eb;
border-radius:10px;
display:flex;
align-items:center;
justify-content:center;
font-weight:bold;
color:#333;
transition:0.3s;
}

.day:hover{
transform:scale(1.1);
}

/* ACTIVE */

.active{
background:linear-gradient(45deg,#22c55e,#4ade80);
color:white;
box-shadow:0 0 10px #22c55e;
}

/* LEGEND */

.legend{
margin-top:30px;
display:flex;
align-items:center;
gap:20px;
}

.box{
width:20px;
height:20px;
border-radius:4px;
}

.empty{background:#e5e7eb;}
.done{background:#22c55e;}

</style>

</head>

<body>

<div class="header">

<div class="title">📅 Habit Activity Calendar</div>

<a href="dashboard.jsp">
<button>⬅ Back to Dashboard</button>
</a>

</div>

<div class="card">

<div class="stats">

<div class="stat-box">
Completed Days
</div>

<div class="stat-box">
Last 30 Days Activity
</div>

</div>

<div class="calendar">

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/habit_tracker","root","pass@123");

/* SHOW LAST 30 DAYS */

for(int i=1;i<=30;i++){

PreparedStatement ps=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs l JOIN habits h ON l.habit_id=h.id WHERE h.user_email=? AND DAY(l.log_date)=?");

ps.setString(1,user);
ps.setInt(2,i);

ResultSet rs=ps.executeQuery();

boolean completed=false;

if(rs.next()){
if(rs.getInt(1)>0){
completed=true;
completedDays++;
}
}

if(completed){
%>

<div class="day active"><%=i%></div>

<%
}else{
%>

<div class="day"><%=i%></div>

<%
}

}

conn.close();

}catch(Exception e){
out.println(e);
}

%>

</div>

<div class="legend">

<div class="box empty"></div> No Habit

<div class="box done"></div> Completed

</div>

</div>

</body>
</html>