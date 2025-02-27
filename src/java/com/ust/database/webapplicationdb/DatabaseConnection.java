package com.ust.database.webapplicationdb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DatabaseConnection {
    public static void main(String[] args) {
        String jdbcUrl = "jdbc:mysql://localhost:3306/WebApplicationDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String password = "jazcute2104";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, user, password);
            System.out.println("✅ Connection successful!");

            // Test fetching posts
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM posts");
            ResultSet rs = stmt.executeQuery();

            System.out.println("🔍 Checking posts:");
            while (rs.next()) {
                System.out.println(rs.getString("user_name") + " - " + rs.getString("post1"));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Connection failed!");
            e.printStackTrace();
        }
    }
}
