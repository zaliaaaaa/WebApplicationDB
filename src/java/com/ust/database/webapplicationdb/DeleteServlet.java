package com.ust.database.webapplicationdb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/WebApplicationDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&requireSSL=false&useSSL=false";

    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "jazcute2104";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] usersToDelete = request.getParameterValues("usersToDelete");

        if (usersToDelete != null && usersToDelete.length > 0) {
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM account WHERE user_name = ?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    for (String user : usersToDelete) {
                        pstmt.setString(1, user);
                        pstmt.executeUpdate();
                    }
                }
                response.sendRedirect("admin.jsp?success=deleted");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin.jsp?error=delete_failed");
            }
        } else {
            response.sendRedirect("admin.jsp?error=no_selection");
        }
    }

    // Redirect GET requests to POST
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
