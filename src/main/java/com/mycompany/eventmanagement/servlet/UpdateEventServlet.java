package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.dao.EventDAO;
import com.mycompany.eventmanagement.model.Event;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEventServlet")
public class UpdateEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Event event = new Event();

        event.setEventId(Integer.parseInt(request.getParameter("eventId")));
        event.setEventName(request.getParameter("eventName"));
        event.setDescription(request.getParameter("description"));
        event.setVenue(request.getParameter("venue"));
        event.setEventDate(request.getParameter("eventDate"));
        event.setEventTime(request.getParameter("eventTime"));
        event.setTicketPrice(Double.parseDouble(request.getParameter("ticketPrice")));

        // Organizer can edit both values manually
        event.setTotalSeats(Integer.parseInt(request.getParameter("totalSeats")));
        event.setAvailableSeats(Integer.parseInt(request.getParameter("availableSeats")));

        EventDAO dao = new EventDAO();

        boolean status = dao.updateEvent(event);

        if (status) {
            response.sendRedirect("dashboard.jsp");
        } else {
            response.getWriter().println("<h2>Failed to Update Event!</h2>");
        }
    }
}