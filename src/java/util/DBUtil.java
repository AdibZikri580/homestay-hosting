package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "mysql://root:imsdAgIUZwcdPfXZlfPXuxfnHffdyblU@mainline.proxy.rlwy.net:31869/railway", "root", "imsdAgIUZwcdPfXZlfPXuxfnHffdyblU");
    }
}
