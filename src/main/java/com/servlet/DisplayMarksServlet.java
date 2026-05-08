package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/displayMarks")
public class DisplayMarksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<StudentMark> list = new MarkDAO().getAllMarks();
            req.setAttribute("marksList", list);
            req.getRequestDispatcher("markdisplay.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load marks: " + e.getMessage());
            req.getRequestDispatcher("markdisplay.jsp").forward(req, resp);
        }
    }
}