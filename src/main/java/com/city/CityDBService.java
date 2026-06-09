package com.city;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * CityDBService — DAO for the City module (dd_city table)
 * Uses DBConfig.getConnection() for centralized DB management.
 * ============================================================
 */
public class CityDBService {

    public ArrayList<CityDTO> getAllCities() {
        ArrayList<CityDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM dd_city ORDER BY value")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public CityDTO getCity(int id) {
        String sql = "SELECT * FROM dd_city WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void insertRecord(CityDTO city) {
        String sql = "INSERT INTO dd_city (code, value, pincode) VALUES (?,?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city.getCode());
            ps.setString(2, city.getValue());
            ps.setInt   (3, city.getPincode());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRecord(CityDTO city) {
        String sql = "UPDATE dd_city SET code=?, value=?, pincode=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, city.getCode());
            ps.setString(2, city.getValue());
            ps.setInt   (3, city.getPincode());
            ps.setInt   (4, city.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRecord(int id) {
        String sql = "DELETE FROM dd_city WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* Keep for backward compatibility — no-op since we use try-with-resources */
    public void closeConnection() {}

    private CityDTO map(ResultSet rs) throws SQLException {
        CityDTO c = new CityDTO();
        c.setId     (rs.getInt   ("id"));
        c.setCode   (rs.getString("code"));
        c.setValue  (rs.getString("value"));
        c.setPincode(rs.getInt   ("pincode"));
        return c;
    }
}
