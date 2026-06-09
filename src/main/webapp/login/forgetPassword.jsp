<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UMS &mdash; Forgot Password</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif; }
body {
    min-height:100vh;
    background:linear-gradient(135deg,#1a3faa 0%,#3f6fdf 60%,#6a9fd8 100%);
    display:flex; align-items:center; justify-content:center; padding:20px;
}
.card {
    width:100%; max-width:420px; background:#fff;
    border-radius:20px; box-shadow:0 25px 60px rgba(0,0,0,0.25);
    padding:40px 36px 32px; animation:fadeUp .4s ease;
}
@keyframes fadeUp {
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}
.logo-area{text-align:center;margin-bottom:24px;}
.logo-icon {
    width:60px;height:60px;
    background:linear-gradient(135deg,#f59e0b,#d97706);
    border-radius:16px;display:inline-flex;align-items:center;
    justify-content:center;font-size:28px;margin-bottom:12px;
}
.logo-area h1{font-size:20px;font-weight:700;color:#1a1a2e;}
.logo-area p{font-size:13px;color:#888;margin-top:4px;}

.info-box {
    background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;
    padding:12px 14px;font-size:13px;color:#1d4ed8;margin-bottom:20px;
    line-height:1.6;
}

.alert {
    padding:10px 14px;border-radius:8px;font-size:13px;
    margin-bottom:16px;font-weight:500;
}
.alert-error   {background:#fef2f2;color:#dc2626;border:1px solid #fecaca;}
.alert-success {background:#f0fdf4;color:#16a34a;border:1px solid #bbf7d0;}

.form-group{margin-bottom:16px;}
.form-group label {
    display:block;font-size:12px;font-weight:600;
    color:#555;margin-bottom:6px;text-transform:uppercase;letter-spacing:.5px;
}
.form-group input {
    width:100%;height:46px;padding:0 16px;
    border:1.5px solid #d6dff7;border-radius:10px;
    font-size:15px;color:#333;background:#f8faff;outline:none;
    transition:border-color .25s,box-shadow .25s;
}
.form-group input:focus {
    border-color:#4070f4;
    box-shadow:0 0 0 4px rgba(64,112,244,.12);
    background:#fff;
}

.btn-reset {
    width:100%;height:48px;border:none;border-radius:12px;
    background:linear-gradient(135deg,#f59e0b,#d97706);
    color:#fff;font-size:16px;font-weight:600;cursor:pointer;
    transition:all .3s ease;box-shadow:0 4px 14px rgba(245,158,11,.35);
}
.btn-reset:hover {
    background:linear-gradient(135deg,#d97706,#b45309);
    box-shadow:0 6px 20px rgba(245,158,11,.45);
    transform:translateY(-1px);
}

.back-link {
    display:block;text-align:center;margin-top:18px;
    font-size:13px;color:#4070f4;text-decoration:none;font-weight:500;
}
.back-link:hover{text-decoration:underline;}
</style>
</head>
<body>
<div class="card">
    <div class="logo-area">
        <div class="logo-icon">&#128274;</div>
        <h1>Forgot Password</h1>
        <p>Reset your account password</p>
    </div>

    <div class="info-box">
        &#8505; Enter your <strong>User ID</strong> and the <strong>OTP</strong> 
        (stored in your profile), then set a new password.
        <br>Contact admin if you don't know your OTP.
    </div>

    <% String err = (String) request.getAttribute("errorMessage");
       if (err != null) { %>
        <div class="alert alert-error">&#9888; <%=err%></div>
    <% } %>

    <%-- Posts to LoginController with opr=resetPwd --%>
    <form method="post" action="<%=request.getContextPath()%>/login/LoginController">
        <input type="hidden" name="opr" value="resetPwd">

        <div class="form-group">
            <label for="userId">User ID</label>
            <input type="text" id="userId" name="userId" placeholder="Enter your user ID" required>
        </div>

        <div class="form-group">
            <label for="otp">OTP</label>
            <input type="text" id="otp" name="otp" placeholder="Enter your OTP" required>
        </div>

        <div class="form-group">
            <label for="newPwd">New Password</label>
            <input type="password" id="newPwd" name="newPwd" 
                   placeholder="Enter new password" minlength="4" required>
        </div>

        <button type="submit" class="btn-reset">Reset Password</button>
    </form>

    <a href="signIn.jsp" class="back-link">&#8592; Back to Sign In</a>
</div>
</body>
</html>
