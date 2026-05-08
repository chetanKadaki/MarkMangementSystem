package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

@WebServlet("/GenerateReportServlet")  // ← This is the correct URL pattern
public class GenerateReportServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            MarkDAO dao = new MarkDAO();
            List<StudentMark> records = dao.getAllMarks();
            
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Student Marks Report</title>");
            out.println("<style>");
            out.println("body { font-family: Arial; margin: 20px; }");
            out.println("h1 { color: #667eea; }");
            out.println("table { border-collapse: collapse; width: 100%; margin-top: 20px; }");
            out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
            out.println("th { background-color: #667eea; color: white; }");
            out.println(".stats { background: #f0f0f0; padding: 15px; margin: 20px 0; border-radius: 5px; }");
            out.println(".btn { background: #667eea; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin-top: 20px; }");
            out.println("</style></head><body>");
            out.println("<h1>📊 Student Marks Report</h1>");
            
            if(records.isEmpty()) {
                out.println("<p>No records found.</p>");
            } else {
                int total = records.size();
                int high = 0, average = 0, below = 0;
                int totalMarks = 0;
                int highest = 0, lowest = 100;
                
                for(StudentMark m : records) {
                    int marks = m.getMarks();
                    totalMarks += marks;
                    if(marks >= 75) high++;
                    else if(marks >= 50) average++;
                    else below++;
                    
                    if(marks > highest) highest = marks;
                    if(marks < lowest) lowest = marks;
                }
                
                double avgMarks = (double) totalMarks / total;
                
                out.println("<div class='stats'>");
                out.println("<h3>Statistics Summary</h3>");
                out.println("<p><strong>Total Students:</strong> " + total + "</p>");
                out.println("<p><strong>High Achievers (≥75):</strong> " + high + "</p>");
                out.println("<p><strong>Average (50-74):</strong> " + average + "</p>");
                out.println("<p><strong>Below Average (<50):</strong> " + below + "</p>");
                out.println("<p><strong>Highest Marks:</strong> " + highest + "</p>");
                out.println("<p><strong>Lowest Marks:</strong> " + lowest + "</p>");
                out.println("<p><strong>Average Marks:</strong> " + String.format("%.2f", avgMarks) + "</p>");
                out.println("</div>");
                
                out.println("<h3>Detailed List</h3>");
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>Name</th><th>Subject</th><th>Marks</th><th>Exam Date</th></tr>");
                
                for(StudentMark m : records) {
                    out.println("<tr>");
                    out.println("<td>" + m.getStudentId() + "</td>");
                    out.println("<td>" + m.getStudentName() + "</td>");
                    out.println("<td>" + m.getSubject() + "</td>");
                    out.println("<td>" + m.getMarks() + "</td>");
                    out.println("<td>" + m.getExamDate() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
            out.println("<br><a href='index.jsp' class='btn'>← Back to Dashboard</a>");
            out.println("</body></html>");
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            out.println("<a href='index.jsp'>Back to Dashboard</a>");
        }
    }
}