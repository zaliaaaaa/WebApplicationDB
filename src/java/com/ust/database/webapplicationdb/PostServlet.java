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

public class PostServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/WebApplicationDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "jazcute2104";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String postContent = request.getParameter("postContent");

        if (username == null || postContent == null || postContent.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?error=Post cannot be empty");
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD)) {
            String query = "SELECT post1, post2, post3, post4, post5 FROM posts WHERE user_name=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            String[] posts = new String[5];
            boolean hasRecord = false;
            if (rs.next()) {
                hasRecord = true;
                for (int i = 0; i < 5; i++) {
                    posts[i] = rs.getString("post" + (i + 1));
                }
            }
            rs.close();
            stmt.close();

            if (posts[4] != null && !posts[4].isEmpty()) {
                response.sendRedirect("profile.jsp?error=Post limit reached. Delete an old post first.");
                return;
            }

            for (int i = 4; i > 0; i--) {
                posts[i] = posts[i - 1];
            }
            posts[0] = postContent;

            if (hasRecord) {
                String updateQuery = "UPDATE posts SET post1=?, post2=?, post3=?, post4=?, post5=? WHERE user_name=?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                for (int i = 0; i < 5; i++) {
                    updateStmt.setString(i + 1, posts[i]);
                }
                updateStmt.setString(6, username);
                updateStmt.executeUpdate();
                updateStmt.close();
            } else {
                String insertQuery = "INSERT INTO posts (user_name, post1) VALUES (?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, username);
                insertStmt.setString(2, postContent);
                insertStmt.executeUpdate();
                insertStmt.close();
            }

            response.sendRedirect("profile.jsp?success=Post created");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Failed to create post");
        }
    }
}
