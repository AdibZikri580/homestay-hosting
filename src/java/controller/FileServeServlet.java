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

    // Lokasi fail lama (gambar yang disimpan sebagai file biasa)
    private static final String FILE_DIRECTORY = "C:/Users/TUF/Documents/NetBeansProjects/HomestayFinder/upload";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String imageIdParam = request.getParameter("id");    // untuk BLOB
        String fileNameParam = request.getParameter("name"); // untuk fail biasa

        try (Connection conn = DBUtil.getConnection()) {

            // ✅ Jika ID gambar diberikan (guna BLOB)
            if (imageIdParam != null) {
                try {
                    int imageId = Integer.parseInt(imageIdParam);
                    ImageDAO imageDAO = new ImageDAO(conn);
                    Image image = imageDAO.getImageById(imageId);

                    if (image != null && image.getImageData() != null) {
                        response.setContentType(image.getFileType());
                        response.setContentLength(image.getImageData().length);

                        try (OutputStream out = response.getOutputStream()) {
                            out.write(image.getImageData());
                        }
                        return;
                    } else if (image != null && image.getFileName() != null) {
                        serveFromFile(image.getFileName(), response);
                        return;
                    } else {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image data not found.");
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image ID.");
                    return;
                }
            }

            // ✅ Jika nama fail diberikan (fallback lama)
            if (fileNameParam != null) {
                serveFromFile(fileNameParam, response);
                return;
            }

            // ❌ Tiada parameter langsung
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No image ID or name provided.");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error.");
        }
    }

    private void serveFromFile(String fileName, HttpServletResponse response) throws IOException {
        if (fileName.contains("..")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file name.");
            return;
        }

        File file = new File(FILE_DIRECTORY, fileName);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found: " + fileName);
            return;
        }

        String mime = getServletContext().getMimeType(file.getName());
        if (mime == null) mime = "application/octet-stream";

        response.setContentType(mime);
        response.setContentLengthLong(file.length());

        try (InputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int len;
            while ((len = in.read(buffer)) > 0) {
                out.write(buffer, 0, len);
            }
        }
    }
}
