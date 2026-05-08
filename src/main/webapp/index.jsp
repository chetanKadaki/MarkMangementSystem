<%@ page import="java.util.*,com.dao.*,com.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Marks Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .dashboard {
            padding: 30px;
            background: #f8f9fa;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
        }
        
        .stat-card.high .stat-number { color: #28a745; }
        .stat-card.average .stat-number { color: #ffc107; }
        .stat-card.low .stat-number { color: #dc3545; }
        
        .actions {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-add { background: #28a745; color: white; }
        .btn-update { background: #ffc107; color: #333; }
        .btn-delete { background: #dc3545; color: white; }
        .btn-report { background: #17a2b8; color: white; }
        
        .form-container {
            background: white;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 10px;
            display: none;
            border: 2px solid #667eea;
        }
        
        .form-container.active {
            display: block;
        }
        
        .form-container h3 {
            margin-bottom: 20px;
            color: #667eea;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        
        .form-group input {
            padding: 8px;
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .btn-submit {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            margin-left: 125px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .btn-submit:hover {
            background: #5a67d8;
        }
        
        .records-section {
            padding: 30px;
            background: white;
            border-top: 1px solid #f0f0f0;
        }
        
        .records-section h2 {
            margin-bottom: 20px;
            color: #333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #667eea;
            color: white;
            padding: 12px;
            text-align: left;
        }
        
        td {
            padding: 12px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            display: none;
        }
        
        .message.success {
            background: #d4edda;
            color: #155724;
            display: block;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background: #f8d7da;
            color: #721c24;
            display: block;
            border: 1px solid #f5c6cb;
        }
        
        .no-records {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>📚 Marks Management System</h1>
        <p>Student Portal Dashboard</p>
    </div>
    
    <div class="dashboard">
        <%
            // Get all records and calculate statistics
            MarkDAO dao = new MarkDAO();
            List<StudentMark> allRecords = dao.getAllMarks();
            int total = allRecords.size();
            int high = 0, average = 0, below = 0;
            int highestMarks = 0, lowestMarks = 100, totalMarks = 0;
            
            for(StudentMark m : allRecords) {
                int marks = m.getMarks();
                totalMarks += marks;
                
                if(marks >= 75) high++;
                else if(marks >= 50) average++;
                else below++;
                
                if(marks > highestMarks) highestMarks = marks;
                if(marks < lowestMarks) lowestMarks = marks;
            }
            
            double avgMarks = total > 0 ? (double) totalMarks / total : 0;
        %>
        
        <div class="stats">
            <div class="stat-card">
                <h3>TOTAL STUDENTS</h3>
                <div class="stat-number"><%= total %></div>
            </div>
            <div class="stat-card high">
                <h3>HIGH (≥75)</h3>
                <div class="stat-number"><%= high %></div>
            </div>
            <div class="stat-card average">
                <h3>AVERAGE (50-74)</h3>
                <div class="stat-number"><%= average %></div>
            </div>
            <div class="stat-card low">
                <h3>BELOW (50)</h3>
                <div class="stat-number"><%= below %></div>
            </div>
        </div>
        
        <div class="actions">
            <button class="btn btn-add" onclick="showForm('add')">➕ Add Marks</button>
            <button class="btn btn-update" onclick="showForm('update')">✏️ Update Marks</button>
            <button class="btn btn-delete" onclick="showForm('delete')">🗑️ Delete Marks</button>
            <button class="btn btn-report" onclick="window.location.href='GenerateReportServlet'">📊 Generate Report</button>
        </div>
        
        <%
            String message = request.getParameter("message");
            String msgType = request.getParameter("msgType");
            if(message != null && msgType != null && !message.isEmpty()) {
        %>
            <div class="message <%= msgType %>">
                <%= message %>
            </div>
        <%
            }
        %>
        
        <!-- Add Form - CORRECTED ACTION -->
        <div id="addForm" class="form-container">
            <h3>➕ Add New Student Marks</h3>
            <form action="AddMarkServlet" method="post">
                <div class="form-group">
                    <label>Student Name:</label>
                    <input type="text" name="name" required>
                </div>
                <div class="form-group">
                    <label>Subject:</label>
                    <input type="text" name="subject" required>
                </div>
                <div class="form-group">
                    <label>Marks (0-100):</label>
                    <input type="number" name="marks" min="0" max="100" required>
                </div>
                <div class="form-group">
                    <label>Exam Date:</label>
                    <input type="date" name="date" required>
                </div>
                <button type="submit" class="btn-submit">Add Record</button>
            </form>
        </div>
        
        <!-- Update Form - CORRECTED ACTION -->
        <div id="updateForm" class="form-container">
            <h3>✏️ Update Student Marks</h3>
            <form action="UpdateMarkServlet" method="post">
                <div class="form-group">
                    <label>Student ID:</label>
                    <input type="number" name="id" required>
                </div>
                <div class="form-group">
                    <label>Student Name:</label>
                    <input type="text" name="name" required>
                </div>
                <div class="form-group">
                    <label>Subject:</label>
                    <input type="text" name="subject" required>
                </div>
                <div class="form-group">
                    <label>Marks (0-100):</label>
                    <input type="number" name="marks" min="0" max="100" required>
                </div>
                <div class="form-group">
                    <label>Exam Date:</label>
                    <input type="date" name="date" required>
                </div>
                <button type="submit" class="btn-submit">Update Record</button>
            </form>
        </div>
        
        <!-- Delete Form - CORRECTED ACTION -->
        <div id="deleteForm" class="form-container">
            <h3>🗑️ Delete Student Marks</h3>
            <form action="DeleteMarkServlet" method="post">
                <div class="form-group">
                    <label>Student ID:</label>
                    <input type="number" name="id" required>
                </div>
                <button type="submit" class="btn-submit">Delete Record</button>
            </form>
        </div>
    </div>
    
    <div class="records-section">
        <h2>📋 All Student Records</h2>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>STUDENT ID</th>
                    <th>NAME</th>
                    <th>SUBJECT</th>
                    <th>MARKS</th>
                    <th>EXAM DATE</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if(allRecords.isEmpty()) {
                %>
                <tr>
                    <td colspan="6" class="no-records">No records found. Click Add Marks to get started!</td>
                </tr>
                <%
                    } else {
                        int count = 1;
                        for(StudentMark mark : allRecords) {
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= mark.getStudentId() %></td>
                    <td><%= mark.getStudentName() %></td>
                    <td><%= mark.getSubject() %></td>
                    <td><%= mark.getMarks() %></td>
                    <td><%= mark.getExamDate() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showForm(type) {
        // Hide all forms
        document.getElementById('addForm').classList.remove('active');
        document.getElementById('updateForm').classList.remove('active');
        document.getElementById('deleteForm').classList.remove('active');
        
        // Show selected form
        if(type === 'add') {
            document.getElementById('addForm').classList.add('active');
        } else if(type === 'update') {
            document.getElementById('updateForm').classList.add('active');
        } else if(type === 'delete') {
            document.getElementById('deleteForm').classList.add('active');
        }
    }
    
    // Auto-hide message after 3 seconds
    setTimeout(function() {
        var msg = document.querySelector('.message');
        if(msg) {
            setTimeout(function() {
                msg.style.display = 'none';
            }, 3000);
        }
    }, 100);
</script>
</body>
</html>