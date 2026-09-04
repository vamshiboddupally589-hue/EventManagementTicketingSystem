package com.mycompany.eventmanagement.dao;

import com.mycompany.eventmanagement.db.DBConnection;
import com.mycompany.eventmanagement.model.Event;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // Add Event
    public boolean addEvent(Event event) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO events(event_name, description, venue, event_date, event_time, ticket_price, total_seats, available_seats) VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getVenue());
            ps.setString(4, event.getEventDate());
            ps.setString(5, event.getEventTime());
            ps.setDouble(6, event.getTicketPrice());
            ps.setInt(7, event.getTotalSeats());
            ps.setInt(8, event.getAvailableSeats());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Events
    public List<Event> getAllEvents() {

        List<Event> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM events ORDER BY event_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Event event = new Event();

                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setDescription(rs.getString("description"));
                event.setVenue(rs.getString("venue"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setTicketPrice(rs.getDouble("ticket_price"));
                event.setTotalSeats(rs.getInt("total_seats"));
                event.setAvailableSeats(rs.getInt("available_seats"));

                list.add(event);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get Event By ID
    public Event getEventById(int eventId) {

        Event event = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM events WHERE event_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, eventId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                event = new Event();

                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setDescription(rs.getString("description"));
                event.setVenue(rs.getString("venue"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setTicketPrice(rs.getDouble("ticket_price"));
                event.setTotalSeats(rs.getInt("total_seats"));
                event.setAvailableSeats(rs.getInt("available_seats"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return event;
    }

    // Update Event
    public boolean updateEvent(Event event) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "UPDATE events SET event_name=?, description=?, venue=?, event_date=?, event_time=?, ticket_price=?, total_seats=?, available_seats=? WHERE event_id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, event.getEventName());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getVenue());
            ps.setString(4, event.getEventDate());
            ps.setString(5, event.getEventTime());
            ps.setDouble(6, event.getTicketPrice());
            ps.setInt(7, event.getTotalSeats());
            ps.setInt(8, event.getAvailableSeats());
            ps.setInt(9, event.getEventId());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Event
    public boolean deleteEvent(int eventId) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM events WHERE event_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, eventId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return status;
    }

    // Search Events
    public List<Event> searchEvents(String keyword) {

        List<Event> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM events WHERE event_name LIKE ? OR venue LIKE ? ORDER BY event_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Event event = new Event();

                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setDescription(rs.getString("description"));
                event.setVenue(rs.getString("venue"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setTicketPrice(rs.getDouble("ticket_price"));
                event.setTotalSeats(rs.getInt("total_seats"));
                event.setAvailableSeats(rs.getInt("available_seats"));

                list.add(event);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Sort Events
    public List<Event> sortEvents(String sortBy) {

        List<Event> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql;

            if ("priceLow".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY ticket_price ASC";

} else if ("priceHigh".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY ticket_price DESC";

} else if ("dateNew".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY event_date DESC";

} else if ("dateOld".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY event_date ASC";

} else if ("seatHigh".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY available_seats DESC";

} else if ("seatLow".equals(sortBy)) {

    sql = "SELECT * FROM events ORDER BY available_seats ASC";

} else {

    sql = "SELECT * FROM events ORDER BY event_id DESC";

}

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Event event = new Event();

                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setDescription(rs.getString("description"));
                event.setVenue(rs.getString("venue"));
                event.setEventDate(rs.getString("event_date"));
                event.setEventTime(rs.getString("event_time"));
                event.setTicketPrice(rs.getDouble("ticket_price"));
                event.setTotalSeats(rs.getInt("total_seats"));
                event.setAvailableSeats(rs.getInt("available_seats"));

                list.add(event);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
// Total Events
public int getTotalEvents() {

    int count = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT COUNT(*) FROM events";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            count = rs.getInt(1);
        }

        rs.close();
        ps.close();
        con.close();

    } catch(Exception e){
        e.printStackTrace();
    }

    return count;
}

// Total Available Seats
public int getTotalAvailableSeats() {

    int count = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT SUM(available_seats) FROM events";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            count = rs.getInt(1);
        }

       rs.close();
    ps.close();
    con.close();

} catch(Exception e){
    e.printStackTrace();
}

return count;

}

/* ================= TOTAL BOOKINGS ================= */

public int getTotalBookings() {

    int total = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT SUM(quantity) FROM bookings";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            total = rs.getInt(1);
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return total;
}
}