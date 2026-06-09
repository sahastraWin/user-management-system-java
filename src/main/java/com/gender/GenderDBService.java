package com.gender;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * GenderDBService — DAO for the Gender module (dd_gender table)
 * ============================================================
 */
public class GenderDBService {

    public ArrayList<GenderDTO> getAllGenders() {
        ArrayList<GenderDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM dd_gender ORDER BY value")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public GenderDTO getGender(int id) {
        String sql = "SELECT * FROM dd_gender WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void insertRecord(GenderDTO g) {
        String sql = "INSERT INTO dd_gender (code, value) VALUES (?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, g.getCode()); ps.setString(2, g.getValue());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRecord(GenderDTO g) {
        String sql = "UPDATE dd_gender SET code=?, value=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, g.getCode()); ps.setString(2, g.getValue()); ps.setInt(3, g.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRecord(int id) {
        String sql = "DELETE FROM dd_gender WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void closeConnection() {}

    private GenderDTO map(ResultSet rs) throws SQLException {
        GenderDTO g = new GenderDTO();
        g.setId(rs.getInt("id")); g.setCode(rs.getString("code")); g.setValue(rs.getString("value"));
        return g;
    }
}
