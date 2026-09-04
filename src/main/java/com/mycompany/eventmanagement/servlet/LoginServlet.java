package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.dao.UserDAO;
import com.mycompany.eventmanagement.model.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Email = " + email);
        System.out.println("Password = " + password);

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {

            System.out.println("LOGIN SUCCESS");
            System.out.println("Role = " + user.getRole());

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if(user.getRole().equalsIgnoreCase("ADMIN")){
                response.sendRedirect("admin.jsp");
             }else{
                response.sendRedirect("dashboard.jsp");
}

        } else {

            System.out.println("LOGIN FAILED");

            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}