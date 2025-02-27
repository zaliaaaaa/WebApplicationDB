<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Profile - AJA Social</title>
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
        .container {
            width: 60%;
            margin: 20px auto;
            background-color: #1e1e1e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }
        .post-box {
            background-color: #282828;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 10px;
            text-align: left;
        }
        .delete-btn {
            background-color: #ff1a6b;
            border: none;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            float: right;
        }
        .delete-btn:hover {
            background-color: #d1175a;
        }
        textarea {
            width: 90%;
            height: 60px;
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-top: 10px;
            background-color: #1e1e1e;
            color: white;
        }
        .nav-container {
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
            transition: 0.3s ease;
        }
        .nav-button:hover {
            background-color: #ff1a6b;
        }
    </style>
</head>
<body>

    <h1>Your Profile, <%= session.getAttribute("username") %> 👤</h1>

    <div class="nav-container">
        <a href="landing.jsp" class="nav-button">Home</a>
        <a href="users.jsp" class="nav-button">Manage Follows</a>
        <a href="help.jsp" class="nav-button">Help</a>
        <a href="LogoutServlet" class="nav-button">Logout</a>
    </div>

    <h2>Your Posts</h2>
    <div class="container">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String currentUser = (String) session.getAttribute("username");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/WebApplicationDB", "root", "jazcute2104");

                String sql = "SELECT post1, post2, post3, post4, post5 FROM posts WHERE user_name = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, currentUser);
                rs = stmt.executeQuery();

                boolean hasPosts = false;
                if (rs.next()) {
                    for (int i = 1; i <= 5; i++) {
                        String post = rs.getString("post" + i);
                        if (post != null && !post.trim().isEmpty()) {
                            hasPosts = true;
        %>
        <div class="post-box">
            <p><%= post %></p>
            <form action="DeletePostServlet" method="POST">
                <input type="hidden" name="postNumber" value="<%= i %>">
                <button type="submit" class="delete-btn">Delete</button>
            </form>
        </div>
        <%
                        }
                    }
                }
                if (!hasPosts) {
                    out.println("<p>You haven't posted anything yet. 🚀</p>");
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

    <h2>Create a New Post</h2>
    <div class="container">
       <form action="PostServlet" method="POST">
            <textarea name="postContent" placeholder="What's on your mind? (max 200 characters)"></textarea>
            <button type="submit" class="nav-button">Post</button>
        </form>
        <%
            if (request.getParameter("error") != null) {
                out.println("<p style='color:red;'>⚠️ " + request.getParameter("error") + "</p>");
            }
        %>
    </div>

</body>
</html>
