package com.mycompany.eventmanagement.dao;

import com.mycompany.eventmanagement.db.DBConnection;
import com.mycompany.eventmanagement.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Admin - Show ALL bookings
    public List<Booking> getAllBookings() {

        List<Booking> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT b.booking_id, " +
                    "u.name AS user_name, " +
                    "e.event_name, " +
                    "b.quantity, " +
                    "b.total_amount, " +
                    "b.ticket_type, " +
                    "b.booking_date, " +
                    "b.status " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "JOIN events e ON b.event_id = e.event_id " +
                    "ORDER BY b.booking_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setEventName(rs.getString("event_name"));
                booking.setSeatsBooked(rs.getInt("quantity"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setTicketType(rs.getString("ticket_type"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));

                list.add(booking);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // User - Show ONLY logged-in user's bookings
    public List<Booking> getBookingsByUser(int userId) {

        List<Booking> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT b.booking_id, " +
                    "u.name AS user_name, " +
                    "e.event_name, " +
                    "b.quantity, " +
                    "b.total_amount, " +
                    "b.ticket_type, " +
                    "b.booking_date, " +
                    "b.status " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "JOIN events e ON b.event_id = e.event_id " +
                    "WHERE b.user_id = ? " +
                    "ORDER BY b.booking_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setEventName(rs.getString("event_name"));
                booking.setSeatsBooked(rs.getInt("quantity"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setTicketType(rs.getString("ticket_type"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));

                list.add(booking);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Total Bookings
    public int getTotalBookings() {

        int total = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT COUNT(*) FROM bookings";

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

    // Total Revenue
    public double getTotalRevenue() {

        double revenue = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT SUM(total_amount) FROM bookings WHERE status='CONFIRMED'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                revenue = rs.getDouble(1);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }

    // Get Booking By ID
    public Booking getBookingById(int bookingId) {

        Booking booking = null;

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("Database Connection is NULL");
                return null;
            }

            System.out.println("Database Connected Successfully");
            System.out.println("Searching Booking ID = " + bookingId);

            String sql =
                    "SELECT b.booking_id, " +
                    "u.name AS user_name, " +
                    "e.event_name, " +
                    "b.quantity, " +
                    "b.total_amount, " +
                    "b.ticket_type, " +
                    "b.booking_date, " +
                    "b.status " +
                    "FROM bookings b " +
                    "JOIN users u ON b.user_id = u.user_id " +
                    "JOIN events e ON b.event_id = e.event_id " +
                    "WHERE b.booking_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                System.out.println("BOOKING FOUND!");

                booking = new Booking();

                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserName(rs.getString("user_name"));
                booking.setEventName(rs.getString("event_name"));
                booking.setSeatsBooked(rs.getInt("quantity"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setTicketType(rs.getString("ticket_type"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setStatus(rs.getString("status"));

            } else {

                System.out.println("BOOKING NOT FOUND!");

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            System.out.println("ERROR INSIDE getBookingById()");
            e.printStackTrace();

        }

        return booking;
    }
}