<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>

<html>
<head>
    <title>Home - AJA Social</title>
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
        h1 {
            color: #ff4081;
            font-weight: 600;
        }
        .nav-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        .nav-button {
            padding: 12px 20px;
            background-color: #ff4081;
            color: white;
            font-weight: 600;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .nav-button:hover {
            background-color: #ff1a6b;
        }
        .post-container {
            width: 60%;
            margin: 20px auto;
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }
        .post {
            padding: 15px;
            border-bottom: 1px solid #ff4081;
            text-align: left;
        }
        .post:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>

    <h1>Welcome, <%= session.getAttribute("username") %> 👋</h1>

    <div class="nav-container">
        <a href="profile.jsp" class="nav-button">Go to Profile</a>
        <a href="users.jsp" class="nav-button">Manage Follows</a>
        <a href="help.jsp" class="nav-button">Help</a>
        <a href="LogoutServlet" class="nav-button">Logout</a>
    </div>

    <h2>Your Feed</h2>
    <div class="post-container">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String currentUser = (String) session.getAttribute("username");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");

                String sql = "SELECT posts.user_name, posts.post1, posts.post2, posts.post3, posts.post4, posts.post5 " +
                             "FROM posts " +
                             "INNER JOIN follows ON posts.user_name = follows.follow1 OR posts.user_name = follows.follow2 OR posts.user_name = follows.follow3 " +
                             "WHERE follows.user_name = ?";
                
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, currentUser);
                rs = stmt.executeQuery();

                boolean hasPosts = false;
                while (rs.next()) {
                    hasPosts = true;
                    out.println("<div class='post'><strong>" + rs.getString("user_name") + "</strong>: " + rs.getString("post1") + "</div>");
                    if (rs.getString("post2") != null) out.println("<div class='post'>" + rs.getString("post2") + "</div>");
                    if (rs.getString("post3") != null) out.println("<div class='post'>" + rs.getString("post3") + "</div>");
                    if (rs.getString("post4") != null) out.println("<div class='post'>" + rs.getString("post4") + "</div>");
                    if (rs.getString("post5") != null) out.println("<div class='post'>" + rs.getString("post5") + "</div>");
                }

                if (!hasPosts) {
                    out.println("<p>No posts from followed users yet. 🌱</p>");
                }

            } catch (Exception e) {
                out.println("<p style='color:red;'>⚠️ Error loading posts!</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        %>
    </div>

</body>
</html>
