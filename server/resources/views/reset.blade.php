<!DOCTYPE html>
<html>

<head>
    <title>Password Reset</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;

        }

        .container {
            text-align: center;
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 25px;
            border: 2px solid #eee;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .button {
            background-color: rgb(50, 103, 137);
            color: white;
            padding: 10px 25px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
            margin: 20px 0;
            cursor: pointer;
        }

        .button:hover {
            background-color: rgb(50, 90, 120);
        }

        p {
            color: #333;
        }

        a {
            text-decoration: none;
            color: white;
            cursor: pointer;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2>Password Reset Request</h2>
        <p>If you requested a password reset for your account, click the button below. If you did not make this request, please ignore this email.</p>
        <a href='http://reset-password?token={{$token}}'>Reset Password</a>
        <p>This password reset link will expire in 60 minutes.</p>
        <p>If you're unable to click the button, please copy and paste the following link into your browser: myapp://reset-password?token={{$token}}
        </p>

    </div>
</body>

</html>