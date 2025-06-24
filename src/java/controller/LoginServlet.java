package controller;

import dao.UserDAO;
import model.User;
import util.DBUtil;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Ambil input borang
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()){
            /* 2. Guna DAO */
            UserDAO userDao = new UserDAO(conn);
            User user = userDao.checkLogin(email, password);

            if (user != null) {
                // 3. Simpan ke session
                HttpSession session = request.getSession();
                session.setAttribute("user_id",   user.getUserId());
                session.setAttribute("full_name", user.getFullName());
                session.setAttribute("user_type", user.getUserType());
                session.setAttribute("phone", user.getPhone());
                session.setAttribute("email", user.getEmail());


                // 4. Hantar mesej popup ke JSP
                request.setAttribute("loginSuccess", true);
                request.setAttribute("userRole", user.getUserType());

            } else {
                // Login gagal
                response.sendRedirect("login.jsp?login=fail");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("login.jsp?login=fail");
        }
        
        // Forward ke login.jsp dengan mesej
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
