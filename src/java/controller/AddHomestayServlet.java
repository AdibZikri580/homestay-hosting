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
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/AddHomestayServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
    maxFileSize       = 1024 * 1024 * 10,  // 10MB
    maxRequestSize    = 1024 * 1024 * 50   // 50MB
)
public class AddHomestayServlet extends HttpServlet {

    private static final String ABSOLUTE_UPLOAD_DIR = "C:/Users/TUF/Documents/NetBeansProjects/HomestayFinder/upload";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer ownerId = (session != null) ? (Integer) session.getAttribute("user_id") : null;
        if (ownerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Ambil maklumat homestay
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            double price = Double.parseDouble(request.getParameter("price_per_night"));
            int maxGuests = Integer.parseInt(request.getParameter("max_guests"));
            int numBedrooms = Integer.parseInt(request.getParameter("num_bedrooms"));
            int numBathrooms = Integer.parseInt(request.getParameter("num_bathrooms"));

            boolean hasWifi = request.getParameter("has_wifi") != null;
            boolean hasParking = request.getParameter("has_parking") != null;
            boolean hasAircond = request.getParameter("has_aircond") != null;
            boolean hasTv = request.getParameter("has_tv") != null;
            boolean hasKitchen = request.getParameter("has_kitchen") != null;
            boolean hasWashingMachine = request.getParameter("has_washing_machine") != null;

            // Ambil fail gambar
            Part filePart = request.getPart("image");
            String originalFileName = extractFileName(filePart);
            String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
            String uniqueFileName = UUID.randomUUID().toString() + extension;
            String fileType = filePart.getContentType();

            // Simpan gambar ke filesystem (fallback)
            File uploadDir = new File(ABSOLUTE_UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            File savedFile = new File(uploadDir, uniqueFileName);
            filePart.write(savedFile.getAbsolutePath());

            // Baca semula gambar untuk BLOB
            byte[] imageBytes;
            try (InputStream inputStream = new FileInputStream(savedFile);
                 ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {

                byte[] temp = new byte[8192];
                int bytesRead;
                while ((bytesRead = inputStream.read(temp)) != -1) {
                    buffer.write(temp, 0, bytesRead);
                }
                imageBytes = buffer.toByteArray();
            }

            try (Connection conn = DBUtil.getConnection()) {
                // Simpan homestay
                Homestay homestay = new Homestay();
                homestay.setUserId(ownerId);
                homestay.setName(name);
                homestay.setDescription(description);
                homestay.setAddress(address);
                homestay.setCity(city);
                homestay.setState(state);
                homestay.setPricePerNight(price);
                homestay.setMaxGuests(maxGuests);
                homestay.setNumBedrooms(numBedrooms);
                homestay.setNumBathrooms(numBathrooms);
                homestay.setHasWifi(hasWifi);
                homestay.setHasParking(hasParking);
                homestay.setHasAircond(hasAircond);
                homestay.setHasTv(hasTv);
                homestay.setHasKitchen(hasKitchen);
                homestay.setHasWashingMachine(hasWashingMachine);

                HomestayDAO homestayDAO = new HomestayDAO(conn);
                int newHomestayId = homestayDAO.insert(homestay);

                // Simpan gambar (metadata + blob)
                Image img = new Image();
                img.setHomestayId(newHomestayId);
                img.setFileName(uniqueFileName); // fallback file name
                img.setImageData(imageBytes);    // BLOB
                img.setFileType(fileType);
                img.setUploadedAt(Timestamp.valueOf(LocalDateTime.now()));

                ImageDAO imageDAO = new ImageDAO(conn);
                imageDAO.insert(img);

                response.sendRedirect("MyHomestayServlet");

            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private String extractFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown.jpg";
    }
}
