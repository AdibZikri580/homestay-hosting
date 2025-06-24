package controller;

import dao.HomestayDAO;
import dao.ImageDAO;
import model.Homestay;
import model.Image;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;

@WebServlet("/AddHomestayServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB
public class AddHomestayServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Ambil semua parameter homestay
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        double price = Double.parseDouble(request.getParameter("price"));
        int maxGuests = Integer.parseInt(request.getParameter("maxGuests"));
        int numBedrooms = Integer.parseInt(request.getParameter("numBedrooms"));
        int numBathrooms = Integer.parseInt(request.getParameter("numBathrooms"));

        boolean hasWifi = request.getParameter("hasWifi") != null;
        boolean hasParking = request.getParameter("hasParking") != null;
        boolean hasAircond = request.getParameter("hasAircond") != null;
        boolean hasTv = request.getParameter("hasTv") != null;
        boolean hasKitchen = request.getParameter("hasKitchen") != null;
        boolean hasWashingMachine = request.getParameter("hasWashingMachine") != null;

        try (Connection conn = DBUtil.getConnection()) {
            HomestayDAO homestayDAO = new HomestayDAO(conn);
            ImageDAO imageDAO = new ImageDAO(conn);

            // Simpan homestay
            Homestay h = new Homestay();
            h.setUserId(userId);
            h.setName(name);
            h.setDescription(description);
            h.setAddress(address);
            h.setCity(city);
            h.setState(state);
            h.setPricePerNight(price);
            h.setMaxGuests(maxGuests);
            h.setNumBedrooms(numBedrooms);
            h.setNumBathrooms(numBathrooms);
            h.setHasWifi(hasWifi);
            h.setHasParking(hasParking);
            h.setHasAircond(hasAircond);
            h.setHasTv(hasTv);
            h.setHasKitchen(hasKitchen);
            h.setHasWashingMachine(hasWashingMachine);

            int homestayId = homestayDAO.insert(h);

            // ✅ Simpan semua gambar sebagai BLOB
            Collection<Part> parts = request.getParts();
            for (Part part : parts) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = extractFileName(part);
                    String fileType = part.getContentType();

                    InputStream fileContent = part.getInputStream();
                    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                    byte[] temp = new byte[8192];
                    int bytesRead;
                    while ((bytesRead = fileContent.read(temp)) != -1) {
                        buffer.write(temp, 0, bytesRead);
                    }
                    byte[] imageData = buffer.toByteArray();


                    Image img = new Image();
                    img.setHomestayId(homestayId);
                    img.setFileName(fileName); // optional: boleh simpan nama
                    img.setFileType(fileType);
                    img.setImageData(imageData);

                    imageDAO.insert(img);
                }
            }

            response.sendRedirect("myHomestays.jsp");

        } catch (SQLException |ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
