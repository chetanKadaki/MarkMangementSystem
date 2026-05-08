<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Delete Marks</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Poppins', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); display: flex; justify-content: center; align-items: center; }
  .card { background: rgba(255,255,255,0.07); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.15); border-radius: 24px; padding: 40px 36px; width: 380px; box-shadow: 0 25px 60px rgba(0,0,0,0.5); text-align: center; }
  .warning-icon { font-size: 56px; margin-bottom: 12px; }
  h2 { color: #fff; font-size: 1.6rem; font-weight: 700; margin-bottom: 8px; }
  .warning-text { color: rgba(255,180,0,0.8); font-size: 0.85rem; margin-bottom: 28px; }
  .form-group { margin-bottom: 20px; text-align: left; }
  label { display: block; color: rgba(255,255,255,0.6); font-size: 0.8rem; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.5px; }
  input { width: 100%; padding: 12px 16px; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); border-radius: 10px; color: #fff; font-family: 'Poppins', sans-serif; font-size: 0.95rem; outline: none; transition: border-color 0.2s; }
  input:focus { border-color: #fc4a1a; background: rgba(255,255,255,0.15); }
  input::placeholder { color: rgba(255,255,255,0.3); }
  .btn-delete { width: 100%; padding: 14px; background: linear-gradient(135deg, #fc4a1a, #f7b733); border: none; border-radius: 12px; color: white; font-weight: 700; font-size: 1rem; cursor: pointer; transition: transform 0.2s; font-family: 'Poppins', sans-serif; }
  .btn-delete:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(252,74,26,0.5); }
  .back-link { display: block; text-align: center; margin-top: 18px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.9rem; }
  .back-link:hover { color: #f7b733; }
  .error { background: rgba(255,80,80,0.2); border: 1px solid rgba(255,80,80,0.4); color: #ff8080; padding: 10px 14px; border-radius: 10px; font-size: 0.85rem; margin-bottom: 16px; }
</style>
</head>
<body>
<div class="card">
  <div class="warning-icon">🗑️</div>
  <h2>Delete Record</h2>
  <p class="warning-text">⚠️ This action cannot be undone!</p>
  <% String error = (String) request.getAttribute("error");
     if (error != null) { %><div class="error"><%= error %></div><% } %>
  <form action="deleteMark" method="post">
    <div class="form-group"><label>Student ID to Delete</label><input type="number" name="studentId" placeholder="Enter Student ID" required></div>
    <button type="submit" class="btn-delete">Delete Record</button>
  </form>
  <a href="index.jsp" class="back-link">⬅ Back to Home</a>
</div>
</body>
</html>