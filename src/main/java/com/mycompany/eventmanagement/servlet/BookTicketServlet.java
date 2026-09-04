package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.db.DBConnection;
import com.mycompany.eventmanagement.model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookTicketServlet")
public class BookTicketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String ticketType = request.getParameter("ticketType");

        try {

            Connection con = DBConnection.getConnection();

            // Get Event Details
            String sql1 =
                    "SELECT event_name, ticket_price, vip_price, available_seats FROM events WHERE event_id=?";

            PreparedStatement ps1 = con.prepareStatement(sql1);
            ps1.setInt(1, eventId);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {

                String eventName = rs.getString("event_name");

                double regularPrice = rs.getDouble("ticket_price");
                double vipPrice = rs.getDouble("vip_price");

                int seats = rs.getInt("available_seats");

                if (quantity > seats) {
                    response.getWriter().println("Not enough seats available.");
                    return;
                }

                double price;

                if ("VIP".equalsIgnoreCase(ticketType)) {
                    price = vipPrice;
                } else {
                    price = regularPrice;
                }

                double total = price * quantity;

                // Find Ticket ID
                String ticketSql =
                        "SELECT ticket_id FROM tickets WHERE event_id=?";

                PreparedStatement ticketPs =
                        con.prepareStatement(ticketSql);

                ticketPs.setInt(1, eventId);

                ResultSet ticketRs = ticketPs.executeQuery();

                if (!ticketRs.next()) {

                    response.getWriter().println("No ticket found for this event.");

                    ticketRs.close();
                    ticketPs.close();
                    rs.close();
                    ps1.close();
                    con.close();
                    return;
                }

                int ticketId = ticketRs.getInt("ticket_id");

                ticketRs.close();
                ticketPs.close();

                // Send data to payment.jsp
                request.setAttribute("userId", userId);
                request.setAttribute("eventId", eventId);
                request.setAttribute("ticketId", ticketId);
                request.setAttribute("quantity", quantity);
                request.setAttribute("total", total);
                request.setAttribute("eventName", eventName);
                request.setAttribute("ticketType", ticketType);

                rs.close();
                ps1.close();
                con.close();

                request.getRequestDispatcher("payment.jsp")
                        .forward(request, response);

            }

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println(e.getMessage());

        }

    }
}