package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
   protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String name=request.getParameter("name");
        String email=request.getParameter("email");
        String phone=request.getParameter("phone");
        String password=request.getParameter("password");
        String confirmPassword=request.getParameter("confirmPassword");

        if(!password.equals(confirmPassword)){

            response.sendRedirect("register.jsp?error=password");
            return;

        }

        try{

            Connection con=DBConnection.getConnection();

            String check="SELECT * FROM users WHERE email=?";

            PreparedStatement ps1=con.prepareStatement(check);

            ps1.setString(1,email);

            ResultSet rs=ps1.executeQuery();

            if(rs.next()){

                response.sendRedirect("register.jsp?error=exists");

                rs.close();
                ps1.close();
                con.close();

                return;

            }

            rs.close();
            ps1.close();

            String sql="INSERT INTO users(name,email,password,phone,role) VALUES(?,?,?,?,?)";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setString(1,name);
            ps.setString(2,email);
            ps.setString(3,password);
            ps.setString(4,phone);
            ps.setString(5,"CUSTOMER");

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("login.jsp?register=success");

        }

        catch(Exception e){

            e.printStackTrace();

            response.getWriter().println(e.getMessage());

        }

    }

}