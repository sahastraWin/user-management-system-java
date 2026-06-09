<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>UMS &mdash; Registration Successful</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:linear-gradient(135deg,#1a3faa,#3f6fdf,#6a9fd8);display:flex;align-items:center;justify-content:center;}
.card{background:#fff;border-radius:20px;padding:50px 40px;text-align:center;max-width:400px;box-shadow:0 25px 60px rgba(0,0,0,0.25);animation:pop .5s ease;}
@keyframes pop{from{opacity:0;transform:scale(.9);}to{opacity:1;transform:scale(1);}}
.check-icon{font-size:64px;margin-bottom:20px;}
h1{font-size:22px;font-weight:700;color:#1a1a2e;margin-bottom:10px;}
p{font-size:14px;color:#666;line-height:1.6;margin-bottom:28px;}
.btn{display:inline-block;padding:12px 28px;background:linear-gradient(135deg,#4070f4,#2952d4);color:#fff;border-radius:10px;text-decoration:none;font-weight:600;font-size:15px;transition:all .3s;}
.btn:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(64,112,244,.4);}
</style>
</head>
<body>
<div class="card">
    <div class="check-icon">&#10003;</div>
    <h1>Registration Successful!</h1>
    <p>Your account has been created. You can now sign in with your credentials.</p>
    <a href="signIn.jsp" class="btn">Go to Sign In</a>
</div>
</body>
</html>
