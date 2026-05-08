<%@ page import="java.util.*, com.model.StudentMark" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Report Result</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: 'Poppins', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460); padding: 40px 20px; }
  .container { max-width: 900px; margin: 0 auto; }
  .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; flex-wrap: wrap; gap: 12px; }
  h2 { color: #fff; font-size: 1.8rem; font-weight: 700; }
  .report-title { background: rgba(168,85,247,0.25); border: 1px solid rgba(168,85,247,0.4); color: #d49fff; padding: 6px 16px; border-radius: 20px; font-size: 0.85rem; }
  .table-card { background: rgba(255,255,255,0.06); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.12); border-radius: 20px; overflow: hidden; box-shadow: 0 25px 60px rgba(0,0,0,0.4); }
  table { width: 100%; border-collapse: collapse; }
  thead tr { background: linear-gradient(90deg, #0099f7, #a855f7); }
  th { color: white; padding: 16px 20px; font-weight: 600; font-size: 0.85rem; text-align: left; text-transform: uppercase; letter-spacing: 0.5px; }
  td { padding: 14px 20px; color: rgba(255,255,255,0.85); font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.06); }
  tbody tr:hover td { background: rgba(0,153,247,0.1); }
  tbody tr:last-child td { border-bottom: none; }
  .marks-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-weight: 600; font-size: 0.85rem; }
  .marks-high { background: rgba(56,239,125,0.2); color: #38ef7d; }
  .marks-mid  { background: rgba(247,183,51,0.2); color: #f7b733; }
  .marks-low  { background: rgba(252,74,26,0.2); color: #fc6a3a; }
  .no-data { text-align: center; padding: 60px; color: rgba(255,255,255,0.4); font-size: 1rem; }
  .back-link { display: inline-block; margin-top: 24px; color: rgba(255,255,255,0.5); text-decoration: none; font-size: 0.9rem; }
  .back-link:hover { color: #a855f7; }
  .btn-new { display: inline-block; margin-top: 24px; margin-left: 16px; background: linear-gradient(135deg, #0099f7, #a855f7); color: white; padding: 10px 20px; border-radius: 10px; text-decoration: none; font-size: 0.9rem; font-weight: 600; transition: transform 0.2s; }
  .btn-new:hover { transform: translateY(-2px); }
</style>
</head>
<body>
<div class="container">
  <%
    List<StudentMark> list = (List<StudentMark>) request.getAttribute("results");
    String reportMessage = (String) request.getAttribute("reportMessage");
    int count = (list != null) ? list.size() : 0;
  %>
  <div class="header">
    <h2>📋 Report Result</h2>
    <% if (reportMessage != null) { %><span class="report-title"><%= reportMessage %></span><% } %>
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
        <tr><td colspan="5" class="no-data">📭 No results found for this report criteria.</td></tr>
      <% } %>
      </tbody>
    </table>
  </div>
  <a href="index.jsp" class="back-link">⬅ Back to Home</a>
  <a href="reportCriteria" class="btn-new">🔄 New Report</a>
</div>
</body>
</html>