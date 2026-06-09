package com.person;

import com.config.DBConfig;
import com.qualification.QualificationDBService;
import com.qualification.QualificationDTO;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;

/**
 * ============================================================
 * PersonDBService — DAO for the Person module
 *
 * Handles CRUD on the `person` table and the many-to-many
 * `person_qualification` junction table.
 *
 * All methods open their own connection via DBConfig and close
 * it via try-with-resources to avoid connection leaks.
 * ============================================================
 */
public class PersonDBService {

    /* ---- Insert a new person and resolve auto-generated ID ---- */
    public void insertRecord(PersonDTO p) {
        /*
         * We use RETURN_GENERATED_KEYS to get the auto-increment id
         * so we can immediately link qualifications to this person.
         */
        String sql = "INSERT INTO person (name, dob, mobileNumber, emailId, gender, state, city) " +
                     "VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            ps.setString(1, p.getName());
            ps.setString(2, p.getDob() != null ? fmt.format(p.getDob()) : null);
            ps.setString(3, p.getMobileNumber());
            ps.setString(4, p.getEmailId());
            ps.setString(5, p.getGender());
            ps.setString(6, p.getState());
            ps.setString(7, p.getCity());
            ps.executeUpdate();

            /* Retrieve the generated primary key */
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) p.setId(keys.getInt(1));
            keys.close();

        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Insert one qualification link for a person ---- */
    public void insertQualification(PersonQualification pq) {
        String sql = "INSERT INTO person_qualification (personId, qualificationCode) VALUES (?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt   (1, pq.getPersonId());
            ps.setString(2, pq.getQualificationCode());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Update all person fields ---- */
    public void updateRecord(PersonDTO p) {
        String sql = "UPDATE person SET name=?, dob=?, mobileNumber=?, emailId=?, " +
                     "gender=?, state=?, city=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            ps.setString(1, p.getName());
            ps.setString(2, p.getDob() != null ? fmt.format(p.getDob()) : null);
            ps.setString(3, p.getMobileNumber());
            ps.setString(4, p.getEmailId());
            ps.setString(5, p.getGender());
            ps.setString(6, p.getState());
            ps.setString(7, p.getCity());
            ps.setInt   (8, p.getId());
            ps.executeUpdate();

        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Delete person and their qualification links ---- */
    public void deleteRecord(int id) {
        /* Delete qualifications first due to FK consideration */
        String delQual = "DELETE FROM person_qualification WHERE personId=?";
        String delPerson = "DELETE FROM person WHERE id=?";
        try (Connection conn = DBConfig.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(delQual)) {
                ps.setInt(1, id); ps.executeUpdate();
            }
            try (PreparedStatement ps = conn.prepareStatement(delPerson)) {
                ps.setInt(1, id); ps.executeUpdate();
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Fetch all persons ---- */
    public ArrayList<PersonDTO> getAllPersons() {
        ArrayList<PersonDTO> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM person ORDER BY name")) {
            while (rs.next()) list.add(mapBasic(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /* ---- Fetch one person by id ---- */
    public PersonDTO getPerson(int id) {
        String sql = "SELECT * FROM person WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBasic(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /*
     * ---- Fetch all qualifications for a person ----
     * Joins person_qualification with dd_qualification to get display values.
     * Uses a fresh connection each call to avoid ResultSet conflicts.
     */
    public ArrayList<QualificationDTO> getPersonQualificationList(int personId) {
        ArrayList<QualificationDTO> list = new ArrayList<>();
        QualificationDBService qService = new QualificationDBService();
        String sql = "SELECT qualificationCode FROM person_qualification WHERE personId=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, personId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String code = rs.getString("qualificationCode");
                QualificationDTO q = new QualificationDTO();
                q.setCode(code);
                q.setValue(qService.getValue(code));  // resolve code → full name
                list.add(q);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /* Kept for controller compatibility — no-op with try-with-resources pattern */
    public void closeConnection() {}

    /* ---- Map ResultSet row to PersonDTO (without qualifications) ---- */
    private PersonDTO mapBasic(ResultSet rs) throws SQLException {
        PersonDTO p = new PersonDTO();
        p.setId           (rs.getInt   ("id"));
        p.setName         (rs.getString("name"));
        p.setMobileNumber (rs.getString("mobileNumber"));
        p.setEmailId      (rs.getString("emailId"));
        p.setDob          (rs.getDate  ("dob"));
        p.setGender       (rs.getString("gender"));
        p.setState        (rs.getString("state"));
        p.setCity         (rs.getString("city"));
        return p;
    }
}
