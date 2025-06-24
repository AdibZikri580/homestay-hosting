package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://mainline.proxy.rlwy.net:31869/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "imsdAgIUZwcdPfXZlfPXuxfnHffdyblU";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        try {
            System.out.println("⏳ [DBUtil] Loading MySQL JDBC driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ [DBUtil] Driver loaded. Connecting to DB...");

            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ [DBUtil] Connected to DB successfully.");
            return conn;

        } catch (ClassNotFoundException e) {
            System.out.println("❌ [DBUtil] MySQL JDBC Driver not found. Please ensure the JAR is included.");
            throw e;
        } catch (SQLException e) {
            System.out.println("❌ [DBUtil] Database connection failed: " + e.getMessage());
            throw e;
        }
    }
}
