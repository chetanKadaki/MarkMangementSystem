package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/reportCriteria")
public class ReportCriteriaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("report_form.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            MarkDAO dao = new MarkDAO();
            List<StudentMark> results = new ArrayList<>();
            String type = req.getParameter("reportType");
            String reportMessage = "";

            if ("threshold".equals(type)) {
                int t = Integer.parseInt(req.getParameter("threshold"));
                results = dao.getMarksAboveThreshold(t);
                reportMessage = "Students with Marks Above " + t;
            } else if ("subject".equals(type)) {
                String subject = req.getParameter("subject");
                results = dao.getMarksBySubject(subject);
                reportMessage = "Students in Subject: " + subject;
            } else if ("top".equals(type)) {
                int n = Integer.parseInt(req.getParameter("topN"));
                results = dao.getTopNStudents(n);
                reportMessage = "Top " + n + " Students";
            } else {
                results = dao.getAllMarks();
                reportMessage = "All Students";
            }

            req.setAttribute("results", results);
            req.setAttribute("reportMessage", reportMessage);
            req.getRequestDispatcher("report_result.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Report Failed: " + e.getMessage());
            req.getRequestDispatcher("report_form.jsp").forward(req, resp);
        }
    }
}