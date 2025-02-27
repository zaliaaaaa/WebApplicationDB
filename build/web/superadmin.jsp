<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Super Admin Dashboard</title>
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
            width: 80%;
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
    <div class="container">
        <h2>Super Admin Dashboard</h2>

        <h3>List of Admins</h3>
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
                    String sql = "SELECT user_name, user_role FROM account WHERE user_role = 'admin'";
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
            <tr><td colspan="2" style="color: red;">⚠️ Error loading admins</td></tr>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>

        <h3>Super Admin Actions</h3>
        <a href="create.jsp" class="button">Create Admin</a>
        <a href="update.jsp" class="button">Update Admin</a>
        <a href="delete.jsp" class="button">Delete Admin</a>
        <br>
        <a href="LogoutServlet" class="button">Logout</a>
    </div>
</body>
</html>
