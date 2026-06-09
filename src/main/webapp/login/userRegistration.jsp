<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UMS &mdash; New User Registration</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif; }
body {
    min-height:100vh;
    background:linear-gradient(135deg,#1a3faa 0%,#3f6fdf 60%,#6a9fd8 100%);
    display:flex; align-items:flex-start; justify-content:center; padding:30px 20px;
}
.card {
    width:100%; max-width:480px; background:#fff;
    border-radius:20px; box-shadow:0 25px 60px rgba(0,0,0,0.25);
    padding:36px 36px 28px; animation:fadeUp .4s ease;
}
@keyframes fadeUp {
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}
.card-header{text-align:center;margin-bottom:24px;}
.card-header h1{font-size:21px;font-weight:700;color:#1a1a2e;}
.card-header p{font-size:13px;color:#888;margin-top:3px;}

.alert{padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;font-weight:500;}
.alert-error{background:#fef2f2;color:#dc2626;border:1px solid #fecaca;}

.form-group{margin-bottom:14px;}
.form-group label {
    display:block;font-size:12px;font-weight:600;
    color:#555;margin-bottom:5px;text-transform:uppercase;letter-spacing:.5px;
}
.form-group input, .form-group select {
    width:100%;height:44px;padding:0 14px;
    border:1.5px solid #d6dff7;border-radius:10px;
    font-size:14px;color:#333;background:#f8faff;outline:none;
    transition:border-color .25s,box-shadow .25s;
    -webkit-appearance:none; appearance:none;
}
.form-group input:focus,.form-group select:focus {
    border-color:#4070f4;
    box-shadow:0 0 0 4px rgba(64,112,244,.12);
    background:#fff;
}
.form-group select {
    background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234070f4' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
    background-repeat:no-repeat;background-position:right 14px center;
}

.divider{border:none;border-top:1px solid #eef0f6;margin:14px 0;}
.section-label{font-size:12px;font-weight:600;color:#555;text-transform:uppercase;letter-spacing:.5px;margin-bottom:8px;display:block;}

.file-upload-area {
    border:2px dashed #d6dff7;border-radius:10px;
    padding:16px;text-align:center;background:#f8faff;
    transition:border-color .2s;
}
.file-upload-area:hover{border-color:#4070f4;}
.file-upload-area input[type="file"]{display:none;}
.file-upload-area label {
    cursor:pointer;font-size:13px;color:#4070f4;font-weight:500;
    display:block;text-transform:none;letter-spacing:0;
}

.btn-submit {
    width:100%;height:48px;border:none;border-radius:12px;
    background:linear-gradient(135deg,#4070f4,#2952d4);
    color:#fff;font-size:16px;font-weight:600;cursor:pointer;
    transition:all .3s ease;box-shadow:0 4px 14px rgba(64,112,244,.35);
    margin-top:8px;
}
.btn-submit:hover {
    background:linear-gradient(135deg,#2952d4,#1a3ab8);
    box-shadow:0 6px 20px rgba(64,112,244,.45);
    transform:translateY(-1px);
}

.back-link{display:block;text-align:center;margin-top:16px;font-size:13px;color:#4070f4;text-decoration:none;font-weight:500;}
.back-link:hover{text-decoration:underline;}
</style>
</head>
<body>
<div class="card">
    <div class="card-header">
        <h1>&#128100; New User Registration</h1>
        <p>Create your UMS account</p>
    </div>

    <% String err = (String) request.getAttribute("errorMessage");
       if (err != null) { %>
        <div class="alert alert-error">&#9888; <%=err%></div>
    <% } %>

    <%-- enctype multipart needed for file upload --%>
    <form method="post" action="<%=request.getContextPath()%>/login/LoginController" enctype="multipart/form-data">
        <input type="hidden" name="opr" value="save">

        <div class="form-group">
            <label>User ID</label>
            <input type="text" name="userId" placeholder="Choose a unique username" required>
        </div>
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="userName" placeholder="Enter your full name" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="pwd" placeholder="Create a password" required minlength="4">
        </div>
        <div class="form-group">
            <label>OTP (Security Code)</label>
            <input type="text" name="otp" placeholder="Set a 4-digit OTP for password reset" required>
        </div>

        <hr class="divider">

        <div class="form-group">
            <label>Updated By</label>
            <input type="text" name="updateBy" placeholder="Your name or admin">
        </div>

        <hr class="divider">

        <span class="section-label">Profile Picture (optional)</span>
        <div class="file-upload-area" id="dropArea">
            <input type="file" name="profileImg" id="profileImg" accept="image/*"
                   onchange="document.getElementById('fileLabel').textContent = this.files[0].name">
            <label for="profileImg" id="fileLabel">&#128247; Click to choose an image</label>
        </div>

        <br>
        <button type="submit" class="btn-submit">Create Account</button>
    </form>

    <a href="signIn.jsp" class="back-link">&#8592; Already have an account? Sign In</a>
</div>
</body>
</html>
