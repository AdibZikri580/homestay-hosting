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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBUtil.getConnection()) {
            // 2. Check login melalui DAO
            UserDAO userDao = new UserDAO(conn);
            User user = userDao.checkLogin(email, password);

            if (user != null) {
                // 3. Simpan maklumat user dalam session
                HttpSession session = request.getSession();
                session.setAttribute("user_id", user.getUserId());
                session.setAttribute("full_name", user.getFullName());
                session.setAttribute("user_type", user.getUserType());
                session.setAttribute("phone", user.getPhone());
                session.setAttribute("email", user.getEmail());

                // 4. Hantar status login dan jenis user ke login.jsp
                request.setAttribute("login", "success");
                request.setAttribute("role", user.getUserType());

            } else {
                // Login gagal
                request.setAttribute("login", "fail");
            }

            // 5. Hantar semula ke login.jsp untuk tunjuk popup
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            // 6. Ralat sistem
            request.setAttribute("login", "fail");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
