package dao;

import model.Image;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImageDAO {
    private final Connection conn;

    public ImageDAO(Connection conn) {
        this.conn = conn;
    }

    // ✅ Masukkan gambar (dengan BLOB dan metadata)
    public boolean insert(Image img) throws SQLException {
        String sql = "INSERT INTO images (homestay_id, file_name, image_data, file_type) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, img.getHomestayId());
            stmt.setString(2, img.getFileName());
            stmt.setBytes(3, img.getImageData());
            stmt.setString(4, img.getFileType());
            return stmt.executeUpdate() > 0;
        }
    }

    // ✅ Ambil semua gambar untuk homestay tertentu
    public List<Image> getImagesByHomestay(int homestayId) throws SQLException {
        List<Image> list = new ArrayList<>();
        String sql = "SELECT * FROM images WHERE homestay_id = ? ORDER BY uploaded_at ASC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, homestayId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Image img = new Image();
                    img.setImageId(rs.getInt("image_id"));
                    img.setHomestayId(rs.getInt("homestay_id"));
                    img.setFileName(rs.getString("file_name"));
                    img.setImageData(rs.getBytes("image_data"));
                    img.setFileType(rs.getString("file_type"));
                    img.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    list.add(img);
                }
            }
        }
        return list;
    }

    // ✅ Ambil gambar pertama homestay (untuk paparan utama)
    public Image getFirstImage(int homestayId) throws SQLException {
        String sql = "SELECT * FROM images WHERE homestay_id = ? ORDER BY uploaded_at ASC LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, homestayId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Image img = new Image();
                    img.setImageId(rs.getInt("image_id"));
                    img.setHomestayId(rs.getInt("homestay_id"));
                    img.setFileName(rs.getString("file_name"));
                    img.setImageData(rs.getBytes("image_data"));
                    img.setFileType(rs.getString("file_type"));
                    img.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    return img;
                }
            }
        }
        return null;
    }

    // ✅ Ambil satu gambar berdasarkan image_id (digunakan dalam FileServeServlet)
    public Image getImageById(int imageId) throws SQLException {
        String sql = "SELECT * FROM images WHERE image_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, imageId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Image img = new Image();
                    img.setImageId(rs.getInt("image_id"));
                    img.setHomestayId(rs.getInt("homestay_id"));
                    img.setFileName(rs.getString("file_name"));
                    img.setImageData(rs.getBytes("image_data"));
                    img.setFileType(rs.getString("file_type"));
                    img.setUploadedAt(rs.getTimestamp("uploaded_at"));
                    return img;
                }
            }
        }
        return null;
    }

    // ✅ Fallback lama (jika masih perlukan image_path/file_name sahaja)
    public String getFirstImagePath(int homestayId) throws SQLException {
        String sql = "SELECT file_name FROM images WHERE homestay_id = ? ORDER BY uploaded_at ASC LIMIT 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, homestayId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("file_name");
                }
            }
        }
        return null;
    }
}