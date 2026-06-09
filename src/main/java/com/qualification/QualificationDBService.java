package com.qualification;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * QualificationDBService — DAO for Qualification module (dd_qualification)
 * ============================================================
 */
public class QualificationDBService {

    public ArrayList<QualificationDTO> getAllQualifications() {
        ArrayList<QualificationDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM dd_qualification ORDER BY value")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public QualificationDTO getQualification(int id) {
        String sql = "SELECT * FROM dd_qualification WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /* Used by PersonDBService to resolve qualification code → display value */
    public String getValue(String code) {
        String sql = "SELECT value FROM dd_qualification WHERE code=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("value");
        } catch (SQLException e) { e.printStackTrace(); }
        return code; // fallback: return the code itself
    }

    public void insertRecord(QualificationDTO q) {
        String sql = "INSERT INTO dd_qualification (code, value) VALUES (?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, q.getCode()); ps.setString(2, q.getValue());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRecord(QualificationDTO q) {
        String sql = "UPDATE dd_qualification SET code=?, value=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, q.getCode()); ps.setString(2, q.getValue()); ps.setInt(3, q.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRecord(int id) {
        String sql = "DELETE FROM dd_qualification WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void closeConnection() {}

    private QualificationDTO map(ResultSet rs) throws SQLException {
        QualificationDTO q = new QualificationDTO();
        q.setId(rs.getInt("id")); q.setCode(rs.getString("code")); q.setValue(rs.getString("value"));
        return q;
    }
}
