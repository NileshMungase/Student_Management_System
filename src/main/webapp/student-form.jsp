<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Student Form</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>

            <div class="container mt-5">
                <div class="card col-md-6 offset-md-3">
                    <div class="card-header bg-primary text-white">
                        <h3>
                            <c:if test="${student != null}">Edit Student</c:if>
                            <c:if test="${student == null}">Add New Student</c:if>
                        </h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${student != null}">
                            <form action="students" method="post">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="id" value="<c:out value='${student.id}' />" />
                        </c:if>
                        <c:if test="${student == null}">
                            <form action="students" method="post">
                                <input type="hidden" name="action" value="insert" />
                        </c:if>

                        <div class="mb-3">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" name="firstName"
                                value="<c:out value='${student.firstName}' />" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" name="lastName"
                                value="<c:out value='${student.lastName}' />" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email"
                                value="<c:out value='${student.email}' />" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input type="date" class="form-control" name="dob" value="<c:out value='${student.dob}' />"
                                required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address"
                                required><c:out value='${student.address}' /></textarea>
                        </div>

                        <button type="submit" class="btn btn-success">Save</button>
                        <a href="students" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>

        </body>

        </html>