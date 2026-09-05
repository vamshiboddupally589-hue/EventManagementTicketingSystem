package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.db.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        String password = request.getParameter("password");

        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {

            response.getWriter().println("Passwords do not match.");

            return;

        }

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE users SET password=? WHERE email=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, password);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            ps.close();
            con.close();

            if (rows > 0) {

                response.sendRedirect("login.jsp?reset=success");

            } else {

                response.getWriter().println("Email not found.");

            }

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println(e.getMessage());

        }

    }
}