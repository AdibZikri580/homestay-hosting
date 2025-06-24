package controller;

import dao.HomestayDAO;
import dao.ImageDAO;
import model.Homestay;
import model.Image;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/SearchHomestayServlet")
public class SearchHomestayServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("SearchHomestayServlet triggered...");

        String search = request.getParameter("search");
        String wifi   = request.getParameter("wifi");
        String aircond = request.getParameter("aircond");
        String kitchen = request.getParameter("kitchen");

        try (Connection conn = DBUtil.getConnection()) {
            HomestayDAO homestayDAO = new HomestayDAO(conn);
            ImageDAO imageDAO = new ImageDAO(conn);

            List<Homestay> homestays;

            boolean adaFilter = search != null || wifi != null || aircond != null || kitchen != null;

            if (adaFilter) {
                homestays = homestayDAO.searchHomestays(search, wifi, aircond, kitchen);
            } else {
                homestays = homestayDAO.getAllHomestays();
            }

            // Tambah imageId ke setiap homestay
            for (Homestay h : homestays) {
                Image img = imageDAO.getFirstImage(h.getHomestayId());
                if (img != null) {
                    h.setImageId(img.getImageId());
                }
            }

            request.setAttribute("homestays", homestays);
            request.setAttribute("search", search);
            request.getRequestDispatcher("searchHomestay.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Something went wrong. Please try again later.</h3>");
        }
    }
}
