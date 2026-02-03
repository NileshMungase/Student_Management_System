package com.student.config;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Singleton class for Database Connection.
 * Ensures only one instance of the connection pool/factory exists.
 */
public class DBConnection {

    private static DBConnection instance;
    private Connection connection;
    private Properties properties;

    private DBConnection() {
        try {
            properties = new Properties();
            InputStream inputStream = getClass().getClassLoader().getResourceAsStream("db.properties");
            if (inputStream != null) {
                properties.load(inputStream);
                Class.forName(properties.getProperty("db.driver"));
            } else {
                throw new RuntimeException("db.properties file not found in classpath");
            }
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Error loading database configuration", e);
        }
    }

    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(
                    properties.getProperty("db.url"),
                    properties.getProperty("db.username"),
                    properties.getProperty("db.password"));
        }
        return connection;
    }
}
