package com.student.dao;

import com.student.config.DBConnection;
import com.student.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class StudentDAOImpl implements StudentDAO {

    private Connection getConnection() throws SQLException {
        return DBConnection.getInstance().getConnection();
    }

    @Override
    public void addStudent(Student student) throws Exception {
        String sql = "INSERT INTO students (first_name, last_name, email, dob, address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getFirstName());
            pstmt.setString(2, student.getLastName());
            pstmt.setString(3, student.getEmail());
            pstmt.setDate(4, Date.valueOf(student.getDob()));
            pstmt.setString(5, student.getAddress());
            pstmt.executeUpdate();
        }
    }

    @Override
    public void updateStudent(Student student) throws Exception {
        String sql = "UPDATE students SET first_name=?, last_name=?, email=?, dob=?, address=? WHERE id=?";
        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getFirstName());
            pstmt.setString(2, student.getLastName());
            pstmt.setString(3, student.getEmail());
            pstmt.setDate(4, Date.valueOf(student.getDob()));
            pstmt.setString(5, student.getAddress());
            pstmt.setInt(6, student.getId());
            pstmt.executeUpdate();
        }
    }

    @Override
    public void deleteStudent(int id) throws Exception {
        // Soft delete
        String sql = "UPDATE students SET is_deleted=TRUE WHERE id=?";
        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    @Override
    public Optional<Student> getStudentById(int id) throws Exception {
        String sql = "SELECT * FROM students WHERE id=? AND is_deleted=FALSE";
        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return Optional.of(mapResultSetToStudent(rs));
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Student> getAllStudents() throws Exception {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE is_deleted=FALSE";
        try (Connection conn = getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        }
        return students;
    }

    @Override
    public List<Student> searchStudents(String keyword) throws Exception {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE is_deleted=FALSE AND (first_name LIKE ? OR last_name LIKE ? OR email LIKE ?)";
        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setString(3, searchPattern);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        }
        return students;
    }

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setUserId(rs.getInt("user_id"));
        student.setFirstName(rs.getString("first_name"));
        student.setLastName(rs.getString("last_name"));
        student.setEmail(rs.getString("email"));
        student.setDob(rs.getDate("dob").toLocalDate());
        student.setAddress(rs.getString("address"));
        student.setDeleted(rs.getBoolean("is_deleted"));
        return student;
    }
}
