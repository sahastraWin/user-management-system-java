package com.config;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * ============================================================
 * DBConfig — Centralized Database Configuration
 *
 * Single source of truth for all JDBC connection settings.
 * Every DBService class calls DBConfig.getConnection() instead
 * of hardcoding credentials — change here and it reflects everywhere.
 *
 * Database : MySQL 8.x
 * Schema   : ums
 * Driver   : com.mysql.cj.jdbc.Driver (mysql-connector-j-9.4.0.jar)
 * ============================================================
 */
public class DBConfig {

    /* ---- Connection parameters — update PASSWORD to match your MySQL setup ---- */
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String URL      = "jdbc:mysql://localhost:3306/ums?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER     = "root";
    private static final String PASSWORD = "nitr@123";   // ← change if needed

    /**
     * Opens and returns a new JDBC Connection.
     * Caller MUST close the connection after use (use try-with-resources).
     *
     * @return Connection object, or null if connection fails
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.err.println("[DBConfig] Failed to connect to database: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
