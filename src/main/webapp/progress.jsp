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
<title>Habit Progress</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

body{
margin:0;
font-family:'Segoe UI';
background:linear-gradient(120deg,#667eea,#764ba2);
color:white;
padding:40px;
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
grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
gap:20px;
}

/* CARD */

.card{
background:white;
color:black;
padding:20px;
border-radius:12px;
box-shadow:0 8px 18px rgba(0,0,0,0.2);
}

.card h3{
margin-bottom:10px;
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

/* CALENDAR */

.calendar{
display:grid;
grid-template-columns:repeat(7,30px);
gap:5px;
margin-top:10px;
}

.day{
width:30px;
height:30px;
background:#ddd;
border-radius:4px;
}

.active{
background:#22c55e;
}

/* QUOTE */

.quote{
margin-top:30px;
background:white;
color:black;
padding:20px;
border-radius:12px;
text-align:center;
font-style:italic;
}

</style>

</head>

<body>

<div class="header">

<h1>📊 Habit Progress Dashboard</h1>

<a href="dashboard.jsp">
<button>⬅ Back to Dashboard</button>
</a>

</div>

<%

int totalHabits=0;
int completedToday=0;
int percent=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection conn=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/habit_tracker","root","pass@123");

/* TOTAL HABITS */

PreparedStatement total=conn.prepareStatement(
"SELECT COUNT(*) FROM habits WHERE user_email=?");

total.setString(1,user);

ResultSet totalRs=total.executeQuery();

if(totalRs.next()){
totalHabits=totalRs.getInt(1);
}

/* COMPLETED TODAY */

PreparedStatement done=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs l JOIN habits h ON l.habit_id=h.id WHERE h.user_email=? AND l.log_date=CURDATE()");

done.setString(1,user);

ResultSet doneRs=done.executeQuery();

if(doneRs.next()){
completedToday=doneRs.getInt(1);
}

if(totalHabits>0){
percent=(completedToday*100)/totalHabits;
}

%>

<div class="grid">

<div class="card">

<h3>Total Habits</h3>
<p><%=totalHabits%></p>

</div>

<div class="card">

<h3>Completed Today</h3>
<p><%=completedToday%></p>

</div>

<div class="card">

<h3>Completion Rate</h3>
<p><%=percent%>%</p>

</div>

</div>

<br>

<div class="card">

<h3>Weekly Habit Activity</h3>

<canvas id="habitChart"></canvas>

</div>

<br>

<div class="card">

<h3>Habit Activity Calendar</h3>

<div class="calendar">

<%

for(int i=1;i<=28;i++){

PreparedStatement dayCheck=conn.prepareStatement(
"SELECT COUNT(*) FROM habit_logs WHERE DAY(log_date)=?");

dayCheck.setInt(1,i);

ResultSet dayRs=dayCheck.executeQuery();

boolean active=false;

if(dayRs.next()){
if(dayRs.getInt(1)>0){
active=true;
}
}

if(active){
%>

<div class="day active"></div>

<%
}else{
%>

<div class="day"></div>

<%
}

}

conn.close();

}catch(Exception e){
out.println(e);
}

%>

</div>

</div>

<div class="quote">

<p id="quoteText"></p>

</div>

<script>

/* WEEKLY CHART */

const data={
labels:["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
datasets:[{
label:"Completed Habits",
data:[2,3,1,4,2,3,5],
backgroundColor:"#6366f1"
}]
};

new Chart(document.getElementById("habitChart"),{
type:"bar",
data:data
});

/* RANDOM QUOTES */

const quotes=[
"Consistency beats motivation.",
"Small daily habits create big results.",
"Discipline creates freedom.",
"Your habits shape your future.",
"Success comes from daily actions."
];

const random=quotes[Math.floor(Math.random()*quotes.length)];

document.getElementById("quoteText").innerText=random;

</script>

</body>
</html>
