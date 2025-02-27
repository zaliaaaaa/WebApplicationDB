<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Follows</title>
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
            width: 60%;
            margin: 20px auto;
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #1e1e1e;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ff4081;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #282828;
            color: #ff4081;
        }
        .nav-button {
            padding: 12px 20px;
            background-color: #ff4081;
            color: white;
            font-weight: 600;
            border-radius: 25px;
            text-decoration: none;
            transition: 0.3s ease;
        }
        .nav-button:hover {
            background-color: #ff1a6b;
        }
    </style>
</head>
<body>

    <h2>Manage Followed Users</h2>

    <div class="container">
        <h3>Your Followed Users</h3>
        <table>
            <tr>
                <th>Username</th>
                <th>Action</th>
            </tr>
            <%
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");
                     PreparedStatement stmt = conn.prepareStatement("SELECT follow1, follow2, follow3 FROM follows WHERE user_name = ?")) {

                    stmt.setString(1, (String) session.getAttribute("username"));
                    ResultSet rs = stmt.executeQuery();
                    
                    boolean hasFollows = false;
                    if (rs.next()) {
                        for (int i = 1; i <= 3; i++) {
                            String followedUser = rs.getString("follow" + i);
                            if (followedUser != null && !followedUser.isEmpty()) {
                                hasFollows = true;
            %>
            <tr>
                <td><%= followedUser %></td>
                <td>
                    <form action="UnfollowServlet" method="post">
                        <input type="hidden" name="unfollow" value="<%= followedUser %>">
                        <button type="submit" class="nav-button">Unfollow</button>
                    </form>
                </td>
            </tr>
            <%
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
</html>
