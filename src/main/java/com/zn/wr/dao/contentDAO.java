package com.zn.wr.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class contentDAO {

    @Autowired // inject spring jdbctemplate
    private JdbcTemplate jdbcTemplate;

    // manual saving
    public boolean insert(String content) {
        try {
            String sql = " INSERT INTO w_content(content,createtime,updatetime )VALUES (?,now(),now())";
            Object[] params = new Object[]{content};
            jdbcTemplate.update(sql, params);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // data refresh
    public String search() {
        String content = null;
        try {
            String sql = "SELECT content from w_content  ORDER BY updatetime DESC LIMIT 1";
            content = (String) jdbcTemplate.queryForObject(sql, java.lang.String.class);

        } catch (Exception e) {
            e.printStackTrace();

        }
        return content;
    }


    public Map<String, Object> query() {
        Map<String, Object> modelMap = new HashMap<String, Object>();
        String content = null;
        try {
            String sql = "SELECT content from w_content  ORDER BY updatetime DESC LIMIT 1";
            content = (String) jdbcTemplate.queryForObject(sql, java.lang.String.class);
            modelMap.put("state", true);
            modelMap.put("initcontent", content);
        } catch (Exception e) {
            e.printStackTrace();
            content = "Fail! ";
            modelMap.put("state", false);
            modelMap.put("initcontent", content);
        }
        return modelMap;
    }
}