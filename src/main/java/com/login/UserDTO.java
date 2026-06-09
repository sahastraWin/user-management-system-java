package com.login;

import java.io.Serializable;
import java.sql.Date;

/**
 * ============================================================
 * UserDTO — Data Transfer Object for the Login / User module
 *
 * Implements Serializable so it can be safely stored in HttpSession.
 *
 * Maps to the `user` table:
 *   id | userId | user_name | user_pwd | encrypt_pwd |
 *   user_otp | user_status | update_date | update_time | update_by | profileImg
 * ============================================================
 */
public class UserDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    id;
    private String userId;
    private String userName;
    private String pwd;
    private String encryptPwd;
    private String otp;
    private String status;
    private Date   updateDate;
    private String time;
    private String updateBy;
    private String profileImg;   // filename only (e.g. "photo.jpg"), not full path

    /* ---- Getters & Setters ---- */
    public int    getId()                        { return id; }
    public void   setId(int id)                  { this.id = id; }

    public String getUserId()                    { return userId; }
    public void   setUserId(String userId)       { this.userId = userId; }

    public String getUserName()                  { return userName; }
    public void   setUserName(String userName)   { this.userName = userName; }

    public String getPwd()                       { return pwd; }
    public void   setPwd(String pwd)             { this.pwd = pwd; }

    public String getEncryptPwd()                { return encryptPwd; }
    public void   setEncryptPwd(String e)        { this.encryptPwd = e; }

    public String getOtp()                       { return otp; }
    public void   setOtp(String otp)             { this.otp = otp; }

    public String getStatus()                    { return status; }
    public void   setStatus(String status)       { this.status = status; }

    public Date   getUpdateDate()                { return updateDate; }
    public void   setUpdateDate(Date updateDate) { this.updateDate = updateDate; }

    public String getTime()                      { return time; }
    public void   setTime(String time)           { this.time = time; }

    public String getUpdateBy()                  { return updateBy; }
    public void   setUpdateBy(String updateBy)   { this.updateBy = updateBy; }

    public String getProfileImg()                { return profileImg; }
    public void   setProfileImg(String p)        { this.profileImg = p; }
}
