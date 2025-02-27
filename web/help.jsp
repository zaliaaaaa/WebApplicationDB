<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Help & Support</title>
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
        .form-container {
            background-color: #1e1e1e;
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border-radius: 10px;
        }
        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 5px;
            background-color: #282828;
            color: white;
            border: 1px solid #ff4081;
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
    <h2>Need Help? Send a Message</h2>
    <div class="form-container">
        <form action="HelpServlet" method="POST">
            <textarea name="message" placeholder="Type your message here..." required></textarea><br>
            <input type="submit" class="button" value="Send Message">
        </form>
    </div>
    <br>
    <a href="landing.jsp" class="button">Back to Home</a>
</body>
</html>
