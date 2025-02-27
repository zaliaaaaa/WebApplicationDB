<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap');

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #121212;
            color: #FFFFFF;
            text-align: center;
            padding: 20px;
        }
        h2 {
            color: #ff4081;
            font-weight: 600;
        }
        .container {
            width: 85%;
            margin: auto;
            background-color: #181818;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #1e1e1e;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ff4081;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #282828;
            color: #ff4081;
        }
        .button {
            display: inline-block;
            padding: 12px 20px;
            margin: 10px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            background-color: #ff4081;
            color: white;
            border-radius: 25px;
            transition: 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #ff1a6b;
        }
    </style>
</head>
<body>

<%
    HttpSession sessionObj = request.getSession(false);
    String role = (sessionObj != null) ? (String) sessionObj.getAttribute("role") : null;

    if (role == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if no session exists
        return;
    } else if ("super_admin".equals(role)) {
        response.sendRedirect("superadmin.jsp"); // Redirect super_admins to their dashboard
        return;
    }
%>

    <div class="container">
        <h2>Admin Dashboard</h2>

        <h3>List of Users</h3>
        <table>
            <tr>
                <th>Username</th>
                <th>Role</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");
                    String sql = "SELECT user_name, user_role FROM account";
                    stmt = conn.prepareStatement(sql);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("user_name") %></td>
                <td><%= rs.getString("user_role") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr><td colspan="2" style="color: red;">⚠️ Error loading users</td></tr>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>

        <h3>Latest Messages</h3>
        <table>
            <tr>
                <th>User</th>
                <th>Message</th>
                <th>Time</th>
            </tr>
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");
                    stmt = conn.prepareStatement("SELECT user_name, message, created_at FROM messages ORDER BY id DESC LIMIT 5");
                    rs = stmt.executeQuery();
                    if (!rs.isBeforeFirst()) {
            %>
            <tr><td colspan="3">No messages yet 📭</td></tr>
            <%
                    } else {
                        while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("user_name") %></td>
                <td><%= rs.getString("message") %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
            %>
            <tr><td colspan="3">⚠️ Error loading messages</td></tr>
            <%
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>

        <h3>Admin Actions</h3>
        <a href="create.jsp" class="button">Create User</a>
        <a href="update.jsp" class="button">Update User</a>
        <a href="delete.jsp" class="button">Delete User</a>
        <br>
        <a href="LogoutServlet" class="button">Logout</a>
    </div>

</body>
</html>
