package com.habittracker.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/habit")
public class HabitServlet extends HttpServlet {

    private static final String URL="jdbc:mysql://localhost:3306/habit_tracker";
    private static final String USER="root";
    private static final String PASSWORD="pass@123";

    protected void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException, IOException {

        String action=request.getParameter("action");

        try{

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn=DriverManager.getConnection(URL,USER,PASSWORD);

            /* ADD HABIT */

            if("add".equals(action)){

                String habit=request.getParameter("habit_name");
                String category=request.getParameter("category");
                String frequency=request.getParameter("frequency");

                HttpSession session=request.getSession();
                String email=(String)session.getAttribute("user");

                String sql="INSERT INTO habits(user_email,habit_name,category,frequency) VALUES(?,?,?,?)";

                PreparedStatement ps=conn.prepareStatement(sql);

                ps.setString(1,email);
                ps.setString(2,habit);
                ps.setString(3,category);
                ps.setString(4,frequency);

                ps.executeUpdate();
            }

            /* MARK HABIT DONE */

            if("done".equals(action)){

                int habitId=Integer.parseInt(request.getParameter("habit_id"));

                String sql="INSERT INTO habit_logs(habit_id,log_date,status) VALUES(?,CURDATE(),'done')";

                PreparedStatement ps=conn.prepareStatement(sql);

                ps.setInt(1,habitId);

                ps.executeUpdate();
            }

            /* DELETE HABIT */

            if("delete".equals(action)){

                int habitId=Integer.parseInt(request.getParameter("habit_id"));

                String sql="DELETE FROM habits WHERE id=?";

                PreparedStatement ps=conn.prepareStatement(sql);

                ps.setInt(1,habitId);

                ps.executeUpdate();
            }

            conn.close();

            response.sendRedirect("dashboard.jsp");

        }catch(Exception e){
            e.printStackTrace();
        }

    }
}
