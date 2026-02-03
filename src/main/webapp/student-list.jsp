<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .container { margin-top: 50px; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; }
        .table-hover tbody tr:hover { background-color: #f1f1f1; }
        .btn-primary { background-color: #4e73df; border-color: #4e73df; }
        .btn-danger { background-color: #e74a3b; border-color: #e74a3b; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">SMS v1.0</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link active" href="students">Students</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Courses</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Attendance</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h2 class="text-center mb-4">Student Management</h2>
    
    <div class="row mb-3">
        <div class="col-md-6">
            <a href="students?action=new" class="btn btn-success"><i class="fas fa-plus"></i> Add New Student</a>
        </div>
        <div class="col-md-6">
            <form action="students" method="get" class="d-flex">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" class="form-control me-2" placeholder="Search by name or email">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>
    </div>

    <c:if test="${not empty param.message}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            ${param.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-body">
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>DOB</th>
                        <th>Address</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${listStudent}">
                        <tr>
                            <td><c:out value="${student.id}" /></td>
                            <td><c:out value="${student.firstName}" /></td>
                            <td><c:out value="${student.lastName}" /></td>
                            <td><c:out value="${student.email}" /></td>
                            <td><c:out value="${student.dob}" /></td>
                            <td><c:out value="${student.address}" /></td>
                            <td>
                                <a href="students?action=edit&id=<c:out value='${student.id}' />" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                <a href="students?action=delete&id=<c:out value='${student.id}' />" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')"><i class="fas fa-trash"></i></a>
                                <a href="students?action=report&id=<c:out value='${student.id}' />" class="btn btn-info btn-sm" title="Generate Report"><i class="fas fa-file-pdf"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
