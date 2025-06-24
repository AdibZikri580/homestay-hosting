package controller;

import dao.ImageDAO;
import model.Image;
import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;

@WebServlet("/FileServeServlet")
public class FileServeServlet extends HttpServlet {

    // ✅ Lokasi fallback untuk fail lama (jika image_data tiada)
    private static final String FILE_DIRECTORY = "C:/Users/TUF/Documents/NetBeansProjects/HomestayFinder/upload";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String imageIdParam = request.getParameter("id");

        if (imageIdParam != null) {
            try {
                int imageId = Integer.parseInt(imageIdParam);

                try (Connection conn = DBUtil.getConnection()) {
                    ImageDAO imageDAO = new ImageDAO(conn);
                    Image image = imageDAO.getImageById(imageId);

                    if (image != null && image.getImageData() != null) {
                        // ✅ Serve image dari database (BLOB)
                        response.setContentType(image.getFileType());
                        response.setContentLength(image.getImageData().length);

                        try (OutputStream out = response.getOutputStream()) {
                            out.write(image.getImageData());
                        }
                        return;
                    } else if (image != null && image.getFileName() != null) {
                        // 🔁 Fallback jika hanya ada file name (dari fail lama)
                        serveFromFile(image.getFileName(), response);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ❌ Jika gagal, hantar error
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found.");
    }

    private void serveFromFile(String fileName, HttpServletResponse response) throws IOException {
        if (fileName.contains("..")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file name.");
            return;
        }

        File file = new File(FILE_DIRECTORY, fileName);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            return;
        }

        String mime = getServletContext().getMimeType(file.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }

        response.setContentType(mime);
        response.setContentLengthLong(file.length());

        try (InputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}
