package com.ust.database.webapplicationdb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HelpServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/WebApplicationDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&requireSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "jazcute2104";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("username") : "Anonymous";
        String message = request.getParameter("message");

        if (message == null || message.trim().isEmpty()) {
            request.setAttribute("message", "❌ Message cannot be empty.");
            request.getRequestDispatcher("result.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO messages (user_name, message) VALUES (?, ?)")) {

            stmt.setString(1, username);
            stmt.setString(2, message);
            stmt.executeUpdate();

            request.setAttribute("message", "✅ Message sent successfully!");
        } catch (Exception e) {
            request.setAttribute("message", "❌ Error sending message.");
            e.printStackTrace();
        }

        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    // Redirect GET requests to POST
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
