package com.dao;

import java.sql.*;
import java.util.*;

import com.model.StudentMark;

public class MarkDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/marksmanagement", "root", "password");
    }

    public void addMark(StudentMark s) throws Exception {
        String sql = "INSERT INTO StudentMarks (StudentName, Subject, Marks, ExamDate) VALUES (?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = getConnection();
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getSubject());
            ps.setInt(3, s.getMarks());
            ps.setDate(4, s.getExamDate());
            
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                s.setStudentId(rs.getInt(1));
            }
            rs.close();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public List<StudentMark> getAllMarks() throws Exception {
        List<StudentMark> list = new ArrayList<>();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            con = getConnection();
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM StudentMarks ORDER BY StudentID");
            
            while (rs.next()) {
                StudentMark s = new StudentMark();
                s.setStudentId(rs.getInt("StudentID"));
                s.setStudentName(rs.getString("StudentName"));
                s.setSubject(rs.getString("Subject"));
                s.setMarks(rs.getInt("Marks"));
                s.setExamDate(rs.getDate("ExamDate"));
                list.add(s);
            }
        } finally {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        }
        return list;
    }

    public void deleteMark(int id) throws Exception {
        String sql = "DELETE FROM StudentMarks WHERE StudentID=?";
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public void updateMark(StudentMark s) throws Exception {
        String sql = "UPDATE StudentMarks SET StudentName=?, Subject=?, Marks=?, ExamDate=? WHERE StudentID=?";
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, s.getStudentName());
            ps.setString(2, s.getSubject());
            ps.setInt(3, s.getMarks());
            ps.setDate(4, s.getExamDate());
            ps.setInt(5, s.getStudentId());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
    
    public StudentMark getMarkById(int id) throws Exception {
        String sql = "SELECT * FROM StudentMarks WHERE StudentID=?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                StudentMark s = new StudentMark();
                s.setStudentId(rs.getInt("StudentID"));
                s.setStudentName(rs.getString("StudentName"));
                s.setSubject(rs.getString("Subject"));
                s.setMarks(rs.getInt("Marks"));
                s.setExamDate(rs.getDate("ExamDate"));
                return s;
            }
            return null;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
}