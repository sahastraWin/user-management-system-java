package com.state;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * StateDBService — DAO for the State module (dd_state table)
 * ============================================================
 */
public class StateDBService {

    public ArrayList<StateDTO> getAllStates() {
        ArrayList<StateDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM dd_state ORDER BY value")) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public StateDTO getState(int id) {
        String sql = "SELECT * FROM dd_state WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public void insertRecord(StateDTO s) {
        String sql = "INSERT INTO dd_state (code, value) VALUES (?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getCode()); ps.setString(2, s.getValue());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRecord(StateDTO s) {
        String sql = "UPDATE dd_state SET code=?, value=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getCode()); ps.setString(2, s.getValue()); ps.setInt(3, s.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRecord(int id) {
        String sql = "DELETE FROM dd_state WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id); ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void closeConnection() {}

    private StateDTO map(ResultSet rs) throws SQLException {
        StateDTO s = new StateDTO();
        s.setId(rs.getInt("id")); s.setCode(rs.getString("code")); s.setValue(rs.getString("value"));
        return s;
    }
}
