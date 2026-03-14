<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.time.*,java.time.temporal.ChronoUnit" %>

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
<title>Habit Streaks</title>

<style>

/* PAGE */

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

.header h1{
font-size:34px;
}

/* GRID */

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
gap:20px;
}

/* CARD */

.card{
background:white;
color:black;
padding:20px;
border-radius:14px;
box-shadow:0 10px 20px rgba(0,0,0,0.2);
transition:0.3s;
}

.card:hover{
transform:translateY(-5px);
}

/* PROGRESS BAR */

.progress-bar{
height:12px;
background:#ddd;
border-radius:20px;
overflow:hidden;
margin-top:10px;
}

.progress{
height:12px;
background:linear-gradient(45deg,#22c55e,#3b82f6);
}

/* BUTTON */

button{
padding:10px 16px;
border:none;
border-radius:20px;
background:#3b82f6;
color:white;
cursor:pointer;
}

button:hover{
background:#2563eb;
}

/* INFO TEXT */

.info{
margin-top:6px;
font-size:14px;
}

</style>

</head>

<body>

<div class="header">

<h1>🔥 Habit Streak Dashboard</h1>

<a href="dashboard.jsp">
<button>⬅ Back to Dashboard</button>
</a>

</div>

<div class="grid">

<%

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/habit_tracker","root","pass@123");

PreparedStatement ps=conn.prepareStatement(
"SELECT * FROM habits WHERE user_email=?");

ps.setString(1,user);

ResultSet rs=ps.executeQuery();

boolean hasHabit=false;

while(rs.next()){

hasHabit=true;

int habitId=rs.getInt("id");
String habit=rs.getString("habit_name");

/* TOTAL COMPLETIONS */

PreparedStatement totalQ=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs WHERE habit_id=?");

totalQ.setInt(1,habitId);

ResultSet totalRs=totalQ.executeQuery();

int totalCompleted=0;

if(totalRs.next()){
totalCompleted=totalRs.getInt(1);
}

/* LAST COMPLETION */

PreparedStatement lastQ=conn.prepareStatement(
"SELECT log_date FROM habit_logs WHERE habit_id=? ORDER BY log_date DESC LIMIT 1");

lastQ.setInt(1,habitId);

ResultSet lastRs=lastQ.executeQuery();

Date lastDate=null;

if(lastRs.next()){
lastDate=lastRs.getDate(1);
}

/* CURRENT STREAK */

PreparedStatement streakQ=conn.prepareStatement(
"SELECT log_date FROM habit_logs WHERE habit_id=? ORDER BY log_date DESC");

streakQ.setInt(1,habitId);

ResultSet streakRs=streakQ.executeQuery();

int streak=0;

LocalDate today=LocalDate.now();

while(streakRs.next()){

LocalDate logDate=streakRs.getDate(1).toLocalDate();

long diff=ChronoUnit.DAYS.between(logDate,today.minusDays(streak));

if(diff==0){
streak++;
}else{
break;
}

}

/* PROGRESS */

int progress=totalCompleted*10;

if(progress>100){
progress=100;
}

%>

<div class="card">

<h3><%=habit%></h3>

<div class="info">🔥 Current Streak: <b><%=streak%> days</b></div>

<div class="info">📊 Total Completions: <b><%=totalCompleted%></b></div>

<div class="info">📅 Last Completed: <b><%=lastDate%></b></div>

<div class="progress-bar">
<div class="progress" style="width:<%=progress%>%"></div>
</div>

</div>

<%

}

if(!hasHabit){
%>

<div class="card">

<h3>No habits found</h3>
<p>Add habits from the dashboard to start tracking streaks.</p>

</div>

<%
}

conn.close();

}catch(Exception e){
out.println(e);
}

%>

</div>

</body>
</html>