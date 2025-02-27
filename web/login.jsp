<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Circular', sans-serif;
            background-color: #121212;
            color: white;
            text-align: center;
            padding: 20px;
        }
        h2 {
            color: #ff4081;
        }
        form {
            background-color: #1e1e1e;
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
        }
        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ff4081;
            background-color: #282828;
            color: white;
        }
        button {
            padding: 10px 20px;
            background-color: #ff4081;
            color: white;
            border-radius: 20px;
            text-decoration: none;
            display: inline-block;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #ff1a6b;
        }
    </style>
</head>
<body>
    <h2>Welcome to the AJA Social Media Platform!</h2>
    <form action="LoginServlet" method="post">
        <label>Username:</label>
        <input type="text" name="username" required>
        
        <label>Password:</label>
        <input type="password" name="password" required>
        
        <button type="submit">Login</button>
    </form>
</body>
</html>
