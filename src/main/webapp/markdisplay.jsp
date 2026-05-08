<%@ page import="java.util.*, com.model.StudentMark" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Display Marks</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Poppins', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); padding: 40px 20px; }
  .container { max-width: 900px; margin: 0 auto; }
  .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; }
  h2 { color: #fff; font-size: 1.8rem; font-weight: 700; }
  .count-badge { background: rgba(71,118,230,0.3); border: 1px solid rgba(71,118,230,0.5); color: #8eb4ff; padding: 6px 16px; border-radius: 20px; font-size: 0.85rem; }
  .table-card { background: rgba(255,255,255,0.06); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.12); border-radius: 20px; overflow: hidden; box-shadow: 0 25px 60px rgba(0,0,0,0.4); }
  table { width: 100%; border-collapse: collapse; }
  thead tr { background: linear-gradient(90deg, #4776e6, #8e54e9); }
  th { color: white; padding: 16px 20px; font-weight: 600; font-size: 0.85rem; text-align: left; text-transform: uppercase; letter-spacing: 0.5px; }
  td { padding: 14px 20px; color: rgba(255,255,255,0.85); font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.06); }
  tbody tr:hover td { background: rgba(71,118,230,0.15); }
  tbody tr:last-child td { border-bottom: none; }
  .marks-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-weight: 600; font-size: 0.85rem; }
  .marks-high { background: rgba(56,239,125,0.2); color: #38ef7d; }
  .marks-mid  { background: rgba(247,183,51,0.2); color: #f7b733; }
  .marks-low  { background: rgba(252,74,26,0.2); color: #fc6a3a; }
  .no-data { text-align: center; padding: 60px; color: rgba(255,255,255,0.4); font-size: 1rem; }
  .back-link { display: inline-block; margin-top: 24px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.9rem; }
  .back-link:hover { color: #8e54e9; }
</style>
</head>
<body>
<div class="container">
  <%
    List<StudentMark> list = (List<StudentMark>) request.getAttribute("marksList");
    int count = (list != null) ? list.size() : 0;
  %>
  <div class="header">
    <h2>📊 Student Marks</h2>
    <span class="count-badge"><%= count %> Records</span>
  </div>
  <div class="table-card">
    <table>
      <thead>
        <tr><th>ID</th><th>Name</th><th>Subject</th><th>Marks</th><th>Exam Date</th></tr>
      </thead>
      <tbody>
      <%
        if (list != null && !list.isEmpty()) {
          for (StudentMark s : list) {
            String marksClass = s.getMarks() >= 75 ? "marks-high" : (s.getMarks() >= 50 ? "marks-mid" : "marks-low");
      %>
        <tr>
          <td><%= s.getStudentId() %></td>
          <td><%= s.getStudentName() %></td>
          <td><%= s.getSubject() %></td>
          <td><span class="marks-badge <%= marksClass %>"><%= s.getMarks() %></span></td>
          <td><%= s.getExamDate() %></td>
        </tr>
      <% } } else { %>
        <tr><td colspan="5" class="no-data">📭 No records found. Add some marks first!</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
  <a href="index.jsp" class="back-link">⬅ Back to Home</a>
</div>
</body>
</html>