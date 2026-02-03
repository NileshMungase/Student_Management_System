package com.student.service;

import com.student.dao.StudentDAO;
import com.student.dao.StudentDAOImpl;
import com.student.exception.StudentNotFoundException;
import com.student.model.Student;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

public class StudentServiceImpl implements StudentService {

    private StudentDAO studentDAO;

    public StudentServiceImpl() {
        this.studentDAO = new StudentDAOImpl(); // In Spring, this would be @Autowired
    }

    @Override
    public void registerStudent(Student student) throws Exception {
        // Business validation
        if (student.getEmail() == null || !student.getEmail().contains("@")) {
            throw new IllegalArgumentException("Invalid Email Address");
        }
        studentDAO.addStudent(student);
    }

    @Override
    public void updateStudentDetails(Student student) throws Exception {
        if (studentDAO.getStudentById(student.getId()).isPresent()) {
            studentDAO.updateStudent(student);
        } else {
            throw new StudentNotFoundException("Student with ID " + student.getId() + " not found for update.");
        }
    }

    @Override
    public void removeStudent(int id) throws Exception {
        if (studentDAO.getStudentById(id).isPresent()) {
            studentDAO.deleteStudent(id);
        } else {
            throw new StudentNotFoundException("Cannot delete. Student with ID " + id + " not found.");
        }
    }

    @Override
    public Student findStudentById(int id) throws StudentNotFoundException, Exception {
        return studentDAO.getStudentById(id)
                .orElseThrow(() -> new StudentNotFoundException("Student with ID " + id + " not found."));
    }

    @Override
    public List<Student> findAllStudents() throws Exception {
        return studentDAO.getAllStudents();
    }

    @Override
    public List<Student> search(String keyword) throws Exception {
        return studentDAO.searchStudents(keyword);
    }

    @Override
    public List<Student> filterStudentsByStream(String namePrefix) {
        try {
            List<Student> allStudents = studentDAO.getAllStudents();
            return allStudents.stream()
                    .filter(s -> s.getFirstName().toLowerCase().startsWith(namePrefix.toLowerCase())
                            || s.getLastName().toLowerCase().startsWith(namePrefix.toLowerCase()))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public void generateStudentReport(int studentId) {
        // Multithreading using CompletableFuture
        CompletableFuture.runAsync(() -> {
            try {
                System.out.println("Starting report generation for student ID: " + studentId + " on thread: "
                        + Thread.currentThread().getName());
                // Simulate heavy processing
                Thread.sleep(3000);
                System.out.println("Report generated successfully for student ID: " + studentId);
                // Here you would typically save a file or send an email
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
    }
}
