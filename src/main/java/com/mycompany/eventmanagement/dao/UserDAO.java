package com.mycompany.eventmanagement.dao;

import com.mycompany.eventmanagement.db.DBConnection;
import com.mycompany.eventmanagement.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Login
    public User login(String email, String password) {

        User user = null;

        try {

            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("Connection is NULL");
                return null;
            }

            String sql = "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            System.out.println("Email = " + email);
            System.out.println("Password = " + password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                System.out.println("User Found!");

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getString("created_at"));

            } else {

                System.out.println("No User Found");
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get All Users
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users ORDER BY user_id DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getString("created_at"));

                list.add(user);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
// Total Users
public int getTotalUsers() {

    int total = 0;

    try {

        Connection con = DBConnection.getConnection();

        String sql = "SELECT COUNT(*) FROM users";

        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            total = rs.getInt(1);
        }

        rs.close();
        ps.close();
        con.close();

    } catch(Exception e){
        e.printStackTrace();
    }

    return total;
}
}