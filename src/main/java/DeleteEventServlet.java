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

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;

        try {

            int eventId = Integer.parseInt(request.getParameter("id"));

            con = DBConnection.getConnection();

            // Delete all bookings of this event
            ps1 = con.prepareStatement(
                    "DELETE FROM bookings WHERE event_id=?");
            ps1.setInt(1, eventId);
            ps1.executeUpdate();

            // Delete all tickets of this event
            ps2 = con.prepareStatement(
                    "DELETE FROM tickets WHERE event_id=?");
            ps2.setInt(1, eventId);
            ps2.executeUpdate();

            // Delete the event
            ps3 = con.prepareStatement(
                    "DELETE FROM events WHERE event_id=?");
            ps3.setInt(1, eventId);

            int rows = ps3.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("dashboard.jsp?msg=deleted");
            } else {
                response.sendRedirect("dashboard.jsp?msg=notfound");
            }

        } catch (Exception e) {

            System.out.println("DELETE ERROR");
            e.printStackTrace();

            response.sendRedirect("dashboard.jsp?msg=error");

        } finally {

            try {
                if (ps1 != null) ps1.close();
            } catch (Exception e) {}

            try {
                if (ps2 != null) ps2.close();
            } catch (Exception e) {}

            try {
                if (ps3 != null) ps3.close();
            } catch (Exception e) {}

            try {
                if (con != null) con.close();
            } catch (Exception e) {}
        }
    }
}