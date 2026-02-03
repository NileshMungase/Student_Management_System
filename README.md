# Student Management System (Java Full Stack)

A complete, real-world Student Management System built using **Core Java, JDBC, JSP, Servlets, and MySQL**. This project demonstrates advanced Java concepts suitable for Full Stack interviews.

## 🚀 Tech Stack
- **Backend**: Java 8+, JDBC, Servlets
- **Frontend**: JSP, JSTL, Bootstrap 5, HTML/CSS
- **Database**: MySQL 8.0
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9+

## 📂 Project Architecture
The project follows the **MVC (Model-View-Controller)** architecture:
- **Model**: POJOs (`Student`, `Course`) representing database entities.
- **View**: JSP pages (`student-list.jsp`, `student-form.jsp`) for UI.
- **Controller**: Servlets (`StudentController`) handling HTTP requests.
- **DAO Layer**: Separates database logic from business logic.
- **Service Layer**: Contains business rules and validations.

## 🛠️ Setup Instructions

### 1. Database Setup
1. Open MySQL Workbench or Command Line.
2. Run the script located at `src/main/resources/db/schema.sql`.
   - This creates the `student_db` database and necessary tables.
   - Inserts sample data.

### 2. Application Configuration
1. Open `src/main/resources/db.properties`.
2. Update `db.username` and `db.password` with your MySQL credentials.

### 3. Build and Run
1. Open the project in your IDE (Eclipse/IntelliJ).
2. Run `mvn clean install` to build the project.
3. Deploy the generated WAR file to Tomcat or run using a Tomcat plugin.
4. Access the application at: `http://localhost:8080/StudentManagementSystem/`

## 🧠 Interview Concepts Used

### 1. Object-Oriented Programming (OOP)
- **Encapsulation**: Used in `Student` class (private fields, public getters/setters).
- **Abstraction**: Used in `StudentDAO` and `StudentService` interfaces to hide implementation details.
- **Polymorphism**: `StudentDAOImpl` overrides methods defined in `StudentDAO`.
- **Inheritance**: Custom exceptions like `StudentNotFoundException` inherit from `Exception`.

### 2. Design Patterns
- **MVC Pattern**: Separates UI (JSP), Logic (Servlet/Service), and Data (DAO/Model).
- **Singleton Pattern**: `DBConnection` class ensures only one database connection instance exists.
- **DAO Pattern**: Decouples business logic from persistence logic.

### 3. Java 8 Features
- **Streams API**: Used for filtering and searching students.
- **Optional**: Used in `StudentDAO` to handle null safety when retrieving students.
- **Date/Time API**: `LocalDate` used for Date of Birth handling instead of legacy `Date`.
- **Lambda Expressions**: Used in `CompletableFuture` for async tasks.

### 4. Advanced Concepts
- **Multithreading**: `CompletableFuture.runAsync()` is used in `StudentService` to simulate background report generation without blocking the UI.
- **Exception Handling**: Custom `StudentNotFoundException` and global try-catch blocks in Controller.
- **JDBC**: Raw SQL queries used (no ORM) to demonstrate core database interaction skills.

## 📝 Functional Modules
1. **Student Management**: CRUD operations (Create, Read, Update, Delete).
2. **Search**: Filter students by name or email.
3. **Soft Delete**: Students are marked as deleted instead of being removed from DB.
4. **Reports**: Background task simulation for report generation.

---
*Built for Java Full Stack Interview Preparation.*
