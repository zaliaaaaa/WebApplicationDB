<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create User</title>
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
            width: 40%;
            margin: auto;
        }
        input, select {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            background-color: #282828;
            color: white;
            font-size: 14px;
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

    <h2>Create a New User</h2>

    <div class="form-container">
        <form action="create.jsp" method="POST">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <select name="role">
                <option value="user">User</option>
                <option value="admin">Admin</option>
                <option value="super_admin">Super Admin</option>
            </select><br>
            <input type="submit" class="button" value="Create User">
        </form>
        <br>
        <a href="admin.jsp" class="button">Back to Admin</a>
    </div>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");
            String sql = "INSERT INTO account (user_name, password, user_role) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, request.getParameter("username"));
            stmt.setString(2, request.getParameter("password"));
            stmt.setString(3, request.getParameter("role"));
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("<p style='color: #ff4081; font-weight: bold;'>✔️ User Created Successfully!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>⚠️ Error creating user!</p>");
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>

</body>
</html>
