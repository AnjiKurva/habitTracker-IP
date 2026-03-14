<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String user=(String)session.getAttribute("user");

if(user==null){
response.sendRedirect("index.jsp");
return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Habit Tracker Dashboard</title>

<style>

/* ===== BACKGROUND ANIMATION ===== */

body{
margin:0;
font-family:'Segoe UI',sans-serif;
background:linear-gradient(-45deg,#667eea,#764ba2,#43e97b,#38f9d7);
background-size:400% 400%;
animation:bgMove 12s ease infinite;
min-height:100vh;
}

@keyframes bgMove{
0%{background-position:0% 50%;}
50%{background-position:100% 50%;}
100%{background-position:0% 50%;}
}

/* ===== SIDEBAR ===== */

.sidebar{
width:230px;
height:100vh;
background:rgba(31,41,55,0.95);
position:fixed;
padding:20px;
color:white;
box-shadow:5px 0 15px rgba(0,0,0,0.3);
}

.sidebar h2{
margin-bottom:20px;
transition:0.3s;
}

.sidebar h2:hover{
color:#38f9d7;
}

.sidebar a{
display:block;
padding:10px;
margin-top:10px;
border-radius:8px;
text-decoration:none;
color:white;
transition:0.3s;
}

.sidebar a:hover{
background:linear-gradient(45deg,#6366f1,#00fff2);
transform:translateX(6px);
box-shadow:0 0 10px rgba(0,255,255,0.6);
}

/* ===== MAIN ===== */

.main{
margin-left:250px;
padding:30px;
color:white;
}

/* ===== HEADER ===== */

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:25px;
}

.title{
font-size:32px;
font-weight:bold;
transition:0.3s;
}

.title:hover{
color:#00fff2;
}

/* ===== BUTTONS ===== */

.top-buttons button{
margin-left:10px;
padding:8px 14px;
border:none;
border-radius:20px;
cursor:pointer;
font-weight:bold;
color:white;
transition:0.3s;
}

.top-buttons button:hover{
transform:scale(1.08);
box-shadow:0 0 12px rgba(255,255,255,0.7);
}

/* ===== BUTTON COLORS ===== */

.add{background:linear-gradient(45deg,#22c55e,#4ade80);}
.progress-btn{background:linear-gradient(45deg,#3b82f6,#60a5fa);}
.streak-btn{background:linear-gradient(45deg,#f59e0b,#fbbf24);}
.profile-btn{background:linear-gradient(45deg,#8b5cf6,#a78bfa);}
.calendar-btn{background:linear-gradient(45deg,#14b8a6,#2dd4bf);}
.logout{background:linear-gradient(45deg,#ef4444,#f87171);}

/* ===== HABIT CARD ===== */

.habit{
background:rgba(255,255,255,0.95);
color:black;
padding:18px;
margin-top:15px;
border-radius:12px;
display:flex;
justify-content:space-between;
align-items:flex-start;
box-shadow:0 8px 18px rgba(0,0,0,0.25);
transition:0.3s;
}

.habit:hover{
transform:translateY(-6px) scale(1.02);
box-shadow:0 15px 25px rgba(0,0,0,0.35);
}

/* ===== STATUS ===== */

.status{
font-weight:bold;
margin-top:5px;
}

/* ===== ACTION AREA ===== */

.habit-actions{
display:flex;
flex-direction:column;
align-items:flex-end;
gap:8px;
}

/* ===== NOTE INPUT ===== */

textarea{
width:220px;
height:45px;
border-radius:10px;
border:1px solid #ddd;
padding:8px 10px;
font-size:13px;
font-family:'Segoe UI';
resize:none;
outline:none;
background:#f9fafb;
transition:0.3s;
box-shadow:0 2px 4px rgba(0,0,0,0.08);
}

textarea:hover{
border-color:#6366f1;
box-shadow:0 0 6px rgba(99,102,241,0.4);
}

textarea:focus{
border-color:#00fff2;
box-shadow:0 0 8px rgba(0,255,255,0.5);
background:white;
}

textarea::placeholder{
color:#888;
font-style:italic;
}

/* ===== BUTTON GROUP ===== */

.btn-group{
display:flex;
gap:8px;
}

/* ===== DONE BUTTON ===== */

.done{
background:linear-gradient(45deg,#22c55e,#16a34a);
color:white;
padding:6px 12px;
border:none;
border-radius:8px;
cursor:pointer;
transition:0.3s;
}

.done:hover{
transform:scale(1.1);
box-shadow:0 0 10px #22c55e;
}

/* ===== DELETE BUTTON ===== */

.delete{
background:linear-gradient(45deg,#ef4444,#dc2626);
color:white;
padding:6px 12px;
border:none;
border-radius:8px;
cursor:pointer;
transition:0.3s;
}

.delete:hover{
transform:scale(1.1);
box-shadow:0 0 10px #ef4444;
}

/* ===== MOTIVATION CARD ===== */

.motivation{
background:rgba(255,255,255,0.95);
color:black;
padding:20px;
margin-top:30px;
border-radius:12px;
box-shadow:0 8px 18px rgba(0,0,0,0.25);
text-align:center;
font-style:italic;
transition:0.3s;
}

.motivation:hover{
transform:scale(1.03);
box-shadow:0 0 12px rgba(0,0,0,0.3);
}

</style>

</head>

<body>

<div class="sidebar">

<h2>Habit Tracker</h2>

<a href="dashboard.jsp">Dashboard</a>
<a href="addHabit.jsp">Add Habit</a>
<a href="progress.jsp">Progress</a>
<a href="streak.jsp">Streaks</a>
<a href="calendar.jsp">Calendar</a>
<a href="profile.jsp">Profile</a>
<a href="logout">Logout</a>

</div>

<div class="main">

<div class="header">

<div class="title">Habit Tracker Dashboard</div>

<div class="top-buttons">

<a href="addHabit.jsp"><button class="add">Add Habit</button></a>
<a href="progress.jsp"><button class="progress-btn">Progress</button></a>
<a href="streak.jsp"><button class="streak-btn">Streaks</button></a>
<a href="calendar.jsp"><button class="calendar-btn">Calendar</button></a>
<a href="profile.jsp"><button class="profile-btn">Profile</button></a>
<a href="logout"><button class="logout">Logout</button></a>

</div>

</div>

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/habit_tracker","root","pass@123");

PreparedStatement ps=conn.prepareStatement(
"SELECT * FROM habits WHERE user_email=?");

ps.setString(1,user);

ResultSet rs=ps.executeQuery();

while(rs.next()){

int habitId=rs.getInt("id");

%>

<div class="habit">

<div>

<b><%=rs.getString("habit_name")%></b><br>
<small><%=rs.getString("category")%> • <%=rs.getString("frequency")%></small>

<br>

<%

PreparedStatement checkDone=conn.prepareStatement(
"SELECT * FROM habit_logs WHERE habit_id=? AND log_date=CURDATE()");

checkDone.setInt(1,habitId);

ResultSet doneRs=checkDone.executeQuery();

if(doneRs.next()){
%>

<div class="status" style="color:green;">✔ Completed Today</div>

<%
}else{
%>

<div class="status" style="color:orange;">⏳ Pending</div>

<%
}
%>

</div>

<div class="habit-actions">

<form action="habit" method="post">

<input type="hidden" name="action" value="done">
<input type="hidden" name="habit_id" value="<%=habitId%>">

<textarea name="note" placeholder="📝 Write today's habit note..."></textarea>

<div class="btn-group">

<button class="done">✔ Done</button>

</form>

<form action="habit" method="post">

<input type="hidden" name="action" value="delete">
<input type="hidden" name="habit_id" value="<%=habitId%>">

<button class="delete">🗑 Delete</button>

</form>

</div>

</div>

</div>

<%

}

conn.close();

}catch(Exception e){
out.println(e);
}

%>

<div class="motivation">
“Small habits repeated daily create massive success over time.”
</div>

</div>

</body>
</html>
