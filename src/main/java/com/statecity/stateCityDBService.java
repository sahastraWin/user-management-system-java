package com.statecity;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * stateCityDBService — DAO for StateCity mapping (statecity table)
 * ============================================================
 */
public class stateCityDBService {

    public ArrayList<stateCityDTO> getAllStateCities() {
        ArrayList<stateCityDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM statecity ORDER BY stateCode, cityCode")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public stateCityDTO getStateCity(int id) {
        String sql = "SELECT * FROM statecity WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void insertRecord(stateCityDTO sc) {
        String sql = "INSERT INTO statecity (stateCode, cityCode) VALUES (?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sc.getStateCode()); ps.setString(2, sc.getCityCode());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRecord(stateCityDTO sc) {
        String sql = "UPDATE statecity SET stateCode=?, cityCode=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sc.getStateCode()); ps.setString(2, sc.getCityCode()); ps.setInt(3, sc.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRecord(int id) {
        String sql = "DELETE FROM statecity WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void closeConnection() {}

    private stateCityDTO map(ResultSet rs) throws SQLException {
        stateCityDTO sc = new stateCityDTO();
        sc.setId(rs.getInt("id")); sc.setStateCode(rs.getString("stateCode")); sc.setCityCode(rs.getString("cityCode"));
        return sc;
    }
}
