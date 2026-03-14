<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String user=(String)session.getAttribute("user");

if(user==null){
response.sendRedirect("index.jsp");
return;
}

int totalHabits=0;
int totalCompletions=0;
int todayCompletions=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/habit_tracker","root","pass@123");

/* TOTAL HABITS */

PreparedStatement ps1=conn.prepareStatement(
"SELECT COUNT(*) FROM habits WHERE user_email=?");

ps1.setString(1,user);

ResultSet rs1=ps1.executeQuery();

if(rs1.next()){
totalHabits=rs1.getInt(1);
}

/* TOTAL COMPLETIONS */

PreparedStatement ps2=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs l JOIN habits h ON l.habit_id=h.id WHERE h.user_email=?");

ps2.setString(1,user);

ResultSet rs2=ps2.executeQuery();

if(rs2.next()){
totalCompletions=rs2.getInt(1);
}

/* COMPLETED TODAY */

PreparedStatement ps3=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs l JOIN habits h ON l.habit_id=h.id WHERE h.user_email=? AND l.log_date=CURDATE()");

ps3.setString(1,user);

ResultSet rs3=ps3.executeQuery();

if(rs3.next()){
todayCompletions=rs3.getInt(1);
}

conn.close();

}catch(Exception e){
out.println(e);
}

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>User Profile</title>

<style>

body{
margin:0;
font-family:'Segoe UI';
background:linear-gradient(120deg,#667eea,#764ba2);
color:white;
min-height:100vh;
padding:40px;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:30px;
}

.card{
background:white;
color:black;
padding:25px;
border-radius:12px;
margin-bottom:20px;
box-shadow:0 10px 20px rgba(0,0,0,0.2);
}

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
gap:20px;
}

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

</style>

</head>

<body>

<div class="header">

<h1>👤 User Profile</h1>

<a href="dashboard.jsp">
<button>⬅ Back to Dashboard</button>
</a>

</div>

<div class="card">

<h2>Email</h2>
<p><%=user%></p>

</div>

<div class="grid">

<div class="card">

<h3>Total Habits</h3>
<p><%=totalHabits%></p>

</div>

<div class="card">

<h3>Total Completions</h3>
<p><%=totalCompletions%></p>

</div>

<div class="card">

<h3>Completed Today</h3>
<p><%=todayCompletions%></p>

</div>

</div>

</body>
</html>