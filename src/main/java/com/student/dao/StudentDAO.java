package com.student.dao;

import com.student.model.Student;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object Interface for Student operations.
 * Demonstrates Abstraction.
 */
public interface StudentDAO {
    void addStudent(Student student) throws Exception;

    void updateStudent(Student student) throws Exception;

    void deleteStudent(int id) throws Exception; // Soft delete

    Optional<Student> getStudentById(int id) throws Exception;

    List<Student> getAllStudents() throws Exception;

    List<Student> searchStudents(String keyword) throws Exception;
}
