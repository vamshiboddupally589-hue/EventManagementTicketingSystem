package com.mycompany.eventmanagement.servlet;

import com.mycompany.eventmanagement.dao.EventDAO;
import com.mycompany.eventmanagement.model.Event;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddEventServlet")
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Event event = new Event();

        event.setEventName(request.getParameter("eventName"));
        event.setDescription(request.getParameter("description"));
        event.setVenue(request.getParameter("venue"));
        event.setEventDate(request.getParameter("eventDate"));
        event.setEventTime(request.getParameter("eventTime"));
        event.setTicketPrice(Double.parseDouble(request.getParameter("ticketPrice")));

        int seats = Integer.parseInt(request.getParameter("totalSeats"));
        event.setTotalSeats(seats);
        event.setAvailableSeats(seats);

        EventDAO dao = new EventDAO();

        boolean status = dao.addEvent(event);

        if (status) {

            response.sendRedirect("dashboard.jsp");

        } else {

             System.out.println("Event insertion failed.");
             response.getWriter().println("<h2>Failed to Add Event!</h2>");

        }
    }
}