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
import java.sql.ResultSet;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            Connection con = DBConnection.getConnection();

            // Get booking details
            String selectSql = "SELECT event_id, quantity FROM bookings WHERE booking_id=?";

            PreparedStatement ps1 = con.prepareStatement(selectSql);
            ps1.setInt(1, bookingId);

            ResultSet rs = ps1.executeQuery();

            int eventId = 0;
            int quantity = 0;

            if (rs.next()) {
                eventId = rs.getInt("event_id");
                quantity = rs.getInt("quantity");
            }

            rs.close();
            ps1.close();

            // Update booking status
            String updateBooking =
                    "UPDATE bookings SET status='CANCELLED' WHERE booking_id=?";

            PreparedStatement ps2 = con.prepareStatement(updateBooking);

            ps2.setInt(1, bookingId);

            ps2.executeUpdate();

            ps2.close();

            // Restore seats
            String updateSeats =
                    "UPDATE events SET available_seats = available_seats + ? WHERE event_id=?";

            PreparedStatement ps3 = con.prepareStatement(updateSeats);

            ps3.setInt(1, quantity);
            ps3.setInt(2, eventId);

            ps3.executeUpdate();

            ps3.close();

            con.close();

            response.sendRedirect("myBookings.jsp");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

}