package com.student.service;

import com.student.exception.StudentNotFoundException;
import com.student.model.Student;
import java.util.List;

public interface StudentService {
    void registerStudent(Student student) throws Exception;

    void updateStudentDetails(Student student) throws Exception;

    void removeStudent(int id) throws Exception;

    Student findStudentById(int id) throws StudentNotFoundException, Exception;

    List<Student> findAllStudents() throws Exception;

    List<Student> search(String keyword) throws Exception;

    List<Student> filterStudentsByStream(String namePrefix); // Java 8 Streams demo

    void generateStudentReport(int studentId); // Async task
}
