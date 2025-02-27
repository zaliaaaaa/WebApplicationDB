<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Users</title>
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
        .form-container {
            background-color: #181818;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            width: 80%;
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ff4081;
            text-align: left;
        }
        th {
            background-color: #282828;
        }
        input[type="checkbox"] {
            transform: scale(1.2);
        }
        .button {
            padding: 12px 20px;
            background-color: #ff4081;
            color: white;
            font-weight: 600;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            margin-top: 15px;
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

    <h2>Delete Users</h2>

    <div class="form-container">
        <form action="DeleteServlet" method="POST">  <!-- Updated to use DeleteServlet -->
            <table>
                <tr>
                    <th>Username</th>
                    <th>Select</th>
                </tr>
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");
                        String sql = "SELECT user_name FROM account";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            String username = rs.getString("user_name");
                %>
                <tr>
                    <td><%= username %></td>
                    <td><input type="checkbox" name="usersToDelete" value="<%= username %>"></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='2'>⚠️ Error loading users.</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                    }
                %>
            </table>
            <br>
            <input type="submit" class="button" value="Delete Selected Users">
        </form>
        <br>
        <a href="admin.jsp" class="button">Back to Admin</a>
    </div>

</body>
</html>
