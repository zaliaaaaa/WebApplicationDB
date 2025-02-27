package com.ust.database.webapplicationdb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FollowServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/WebApplicationDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "jazcute2104";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String followUsername = request.getParameter("followUsername");

        if (username == null || followUsername == null || followUsername.trim().isEmpty()) {
            response.sendRedirect("users.jsp?error=Invalid username");
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD)) {
            // Check if the user exists
            String checkUserSQL = "SELECT user_name FROM account WHERE user_name=?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkUserSQL)) {
                checkStmt.setString(1, followUsername);
                ResultSet userExists = checkStmt.executeQuery();

                if (!userExists.next()) {
                    response.sendRedirect("users.jsp?error=User does not exist");
                    return;
                }
            }

            // Retrieve current follows
            String query = "SELECT follow1, follow2, follow3 FROM follows WHERE user_name=?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                String[] follows = new String[3];
                boolean hasRecord = false;

                if (rs.next()) {
                    hasRecord = true;
                    for (int i = 0; i < 3; i++) {
                        follows[i] = rs.getString("follow" + (i + 1));
                    }
                }
                rs.close();

                // Check if already following
                for (String follow : follows) {
                    if (followUsername.equals(follow)) {
                        response.sendRedirect("users.jsp?error=Already following this user");
                        return;
                    }
                }

                // Check if follow limit is reached
                if (follows[2] != null && !follows[2].isEmpty()) {
                    response.sendRedirect("users.jsp?error=Follow limit reached (max 3 users)");
                    return;
                }

                // Add the new follow
                for (int i = 0; i < 3; i++) {
                    if (follows[i] == null || follows[i].isEmpty()) {
                        follows[i] = followUsername;
                        break;
                    }
                }

                // If user has a follow record, update it
                if (hasRecord) {
                    String updateQuery = "UPDATE follows SET follow1=?, follow2=?, follow3=? WHERE user_name=?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        for (int i = 0; i < 3; i++) {
                            updateStmt.setString(i + 1, follows[i]);
                        }
                        updateStmt.setString(4, username);
                        updateStmt.executeUpdate();
                    }
                } else {
                    // If no record exists, insert a new row
                    String insertQuery = "INSERT INTO follows (user_name, follow1) VALUES (?, ?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                        insertStmt.setString(1, username);
                        insertStmt.setString(2, followUsername);
                        insertStmt.executeUpdate();
                    }
                }

                response.sendRedirect("users.jsp?success=User followed successfully");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users.jsp?error=Error following user");
        }
    }
}
