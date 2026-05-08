<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Add Marks</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Poppins', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); display: flex; justify-content: center; align-items: center; }
  .card { background: rgba(255,255,255,0.07); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.15); border-radius: 24px; padding: 40px 36px; width: 420px; box-shadow: 0 25px 60px rgba(0,0,0,0.5); }
  h2 { color: #fff; font-size: 1.6rem; font-weight: 700; margin-bottom: 24px; text-align: center; }
  .form-group { margin-bottom: 16px; }
  label { display: block; color: rgba(255,255,255,0.6); font-size: 0.8rem; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.5px; }
  input { width: 100%; padding: 12px 16px; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); border-radius: 10px; color: #fff; font-family: 'Poppins', sans-serif; font-size: 0.95rem; outline: none; transition: border-color 0.2s; }
  input:focus { border-color: #38ef7d; background: rgba(255,255,255,0.15); }
  input::placeholder { color: rgba(255,255,255,0.3); }
  .btn-submit { width: 100%; padding: 14px; background: linear-gradient(135deg, #11998e, #38ef7d); border: none; border-radius: 12px; color: #1a1a2e; font-weight: 700; font-size: 1rem; cursor: pointer; margin-top: 8px; transition: transform 0.2s; font-family: 'Poppins', sans-serif; }
  .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(56,239,125,0.4); }
  .back-link { display: block; text-align: center; margin-top: 18px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.9rem; }
  .back-link:hover { color: #38ef7d; }
  .error { background: rgba(255,80,80,0.2); border: 1px solid rgba(255,80,80,0.4); color: #ff8080; padding: 10px 14px; border-radius: 10px; font-size: 0.85rem; margin-bottom: 16px; }
</style>
</head>
<body>
<div class="card">
  <h2>➕ Add Marks</h2>
  <% String error = (String) request.getAttribute("error");
     if (error != null) { %><div class="error"><%= error %></div><% } %>
  <form action="addMark" method="post">
    <div class="form-group"><label>Student ID</label><input type="number" name="studentId" placeholder="e.g. 101" required></div>
    <div class="form-group"><label>Student Name</label><input type="text" name="studentName" placeholder="e.g. Rahul Sharma" required></div>
    <div class="form-group"><label>Subject</label><input type="text" name="subject" placeholder="e.g. Mathematics" required></div>
    <div class="form-group"><label>Marks</label><input type="number" name="marks" placeholder="e.g. 85" min="0" max="100" required></div>
    <div class="form-group"><label>Exam Date</label><input type="date" name="examDate" required></div>
    <button type="submit" class="btn-submit">Add Student Mark</button>
  </form>
  <a href="index.jsp" class="back-link">⬅ Back to Home</a>
</div>
</body>
</html>