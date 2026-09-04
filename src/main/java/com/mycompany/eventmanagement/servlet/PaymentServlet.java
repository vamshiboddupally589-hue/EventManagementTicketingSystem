package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            System.out.println("userId = " + request.getParameter("userId"));
            System.out.println("eventId = " + request.getParameter("eventId"));
            System.out.println("ticketId = " + request.getParameter("ticketId"));
            System.out.println("quantity = " + request.getParameter("quantity"));
            System.out.println("total = " + request.getParameter("total"));

            int userId = Integer.parseInt(request.getParameter("userId"));
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double total = Double.parseDouble(request.getParameter("total"));

            String paymentMethod = request.getParameter("paymentMethod");
            String ticketType = request.getParameter("ticketType");

            Connection con = DBConnection.getConnection();

            // Insert Booking
            String sql = "INSERT INTO bookings(user_id,event_id,ticket_id,quantity,total_amount,ticket_type,status) VALUES(?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, eventId);
            ps.setInt(3, ticketId);
            ps.setInt(4, quantity);
            ps.setDouble(5, total);
            ps.setString(6, ticketType);
            ps.setString(7, "CONFIRMED");   // Fixed

            ps.executeUpdate();

            ps.close();

            // Reduce Available Seats
            String update = "UPDATE events SET available_seats = available_seats - ? WHERE event_id=?";

            PreparedStatement ps2 = con.prepareStatement(update);

            ps2.setInt(1, quantity);
            ps2.setInt(2, eventId);

            ps2.executeUpdate();

            ps2.close();

            con.close();

            response.sendRedirect("myBookings.jsp");

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println(e.getMessage());

        }

    }
}