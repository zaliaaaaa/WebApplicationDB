 <%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Operation Result</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            font-family: 'Circular', sans-serif;
            background-color: #121212;
            color: #FFFFFF;
            text-align: center;
            padding: 20px;
        }
        h2 {
            color: #ff4081;
        }
        .result-box {
            background-color: #1e1e1e;
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border-radius: 10px;
        }
        .button {
            display: inline-block;
            padding: 12px 20px;
            margin: 10px;
            font-size: 16px;
            text-decoration: none;
            background-color: #ff4081;
            color: white;
            border-radius: 20px;
            transition: 0.3s;
        }
        .button:hover {
            background-color: #ff1a6b;
        }
    </style>
</head>
<body>
    <h2>Operation Result</h2>
    <div class="result-box">
        <p><%= request.getAttribute("message") %></p>
    </div>

    <br>
    <%
        HttpSession sessionObj = request.getSession(false);
        String userRole = (sessionObj != null) ? (String) sessionObj.getAttribute("role") : "user";
        String redirectPage = "landing.jsp";

        if ("admin".equals(userRole)) {
            redirectPage = "admin.jsp";
        } else if ("super_admin".equals(userRole)) {
            redirectPage = "superadmin.jsp";
        }
    %>

    <a href="<%= session.getAttribute("role").equals("admin") ? "admin.jsp" : "landing.jsp" %>" class="button">Back</a>

</body>
</html>
