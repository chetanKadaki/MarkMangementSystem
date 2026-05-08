<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Generate Report</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Poppins', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); display: flex; justify-content: center; align-items: center; }
  .card { background: rgba(255,255,255,0.07); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.15); border-radius: 24px; padding: 40px 36px; width: 440px; box-shadow: 0 25px 60px rgba(0,0,0,0.5); }
  h2 { color: #fff; font-size: 1.6rem; font-weight: 700; margin-bottom: 24px; text-align: center; }
  .form-group { margin-bottom: 18px; }
  label { display: block; color: rgba(255,255,255,0.6); font-size: 0.8rem; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.5px; }
  select, input { width: 100%; padding: 12px 16px; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); border-radius: 10px; color: #fff; font-family: 'Poppins', sans-serif; font-size: 0.95rem; outline: none; transition: border-color 0.2s; appearance: none; }
  select option { background: #16213e; color: #fff; }
  select:focus, input:focus { border-color: #0099f7; background: rgba(255,255,255,0.15); }
  input::placeholder { color: rgba(255,255,255,0.3); }
  .dynamic-field { display: none; }
  .dynamic-field.visible { display: block; }
  .btn-submit { width: 100%; padding: 14px; background: linear-gradient(135deg, #0099f7, #a855f7); border: none; border-radius: 12px; color: white; font-weight: 700; font-size: 1rem; cursor: pointer; margin-top: 8px; transition: transform 0.2s; font-family: 'Poppins', sans-serif; }
  .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 10px 30px rgba(0,153,247,0.4); }
  .back-link { display: block; text-align: center; margin-top: 18px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.9rem; }
  .back-link:hover { color: #0099f7; }
  .error { background: rgba(255,80,80,0.2); border: 1px solid rgba(255,80,80,0.4); color: #ff8080; padding: 10px 14px; border-radius: 10px; font-size: 0.85rem; margin-bottom: 16px; }
</style>
<script>
function toggleFields() {
  var type = document.getElementById("reportType").value;
  document.getElementById("thresholdField").className = "form-group dynamic-field" + (type === "threshold" ? " visible" : "");
  document.getElementById("subjectField").className   = "form-group dynamic-field" + (type === "subject"   ? " visible" : "");
  document.getElementById("topField").className       = "form-group dynamic-field" + (type === "top"       ? " visible" : "");
  document.querySelector("[name='threshold']").required = (type === "threshold");
  document.querySelector("[name='subject']").required   = (type === "subject");
  document.querySelector("[name='topN']").required      = (type === "top");
}
window.onload = toggleFields;
</script>
</head>
<body>
<div class="card">
  <h2>📋 Generate Report</h2>
  <% String error = (String) request.getAttribute("error");
     if (error != null) { %><div class="error"><%= error %></div><% } %>
  <form action="reportCriteria" method="post">
    <div class="form-group">
      <label>Report Type</label>
      <select name="reportType" id="reportType" onchange="toggleFields()" required>
        <option value="">-- Select Report Type --</option>
        <option value="threshold">Marks Above Threshold</option>
        <option value="subject">Marks by Subject</option>
        <option value="top">Top N Students</option>
      </select>
    </div>
    <div class="form-group dynamic-field" id="thresholdField">
      <label>Minimum Marks</label>
      <input type="number" name="threshold" placeholder="e.g. 70">
    </div>
    <div class="form-group dynamic-field" id="subjectField">
      <label>Subject Name</label>
      <input type="text" name="subject" placeholder="e.g. Mathematics">
    </div>
    <div class="form-group dynamic-field" id="topField">
      <label>Top N Students</label>
      <input type="number" name="topN" placeholder="e.g. 5" min="1">
    </div>
    <button type="submit" class="btn-submit">Generate Report</button>
  </form>
  <a href="index.jsp" class="back-link">⬅ Back to Home</a>
</div>
</body>
</html>