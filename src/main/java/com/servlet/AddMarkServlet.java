package com.servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import com.dao.MarkDAO;
import com.model.StudentMark;

@WebServlet("/AddMarkServlet")  // ← URL pattern
public class AddMarkServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String name = request.getParameter("name");
            String subject = request.getParameter("subject");
            int marks = Integer.parseInt(request.getParameter("marks"));
            Date examDate = Date.valueOf(request.getParameter("date"));
            
            StudentMark s = new StudentMark();
            s.setStudentName(name);
            s.setSubject(subject);
            s.setMarks(marks);
            s.setExamDate(examDate);
            
            MarkDAO dao = new MarkDAO();
            dao.addMark(s);
            
            response.sendRedirect("index.jsp?message=Record added successfully!&msgType=success");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?message=Error: " + e.getMessage() + "&msgType=error");
        }
    }
}