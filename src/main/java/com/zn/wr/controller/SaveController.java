package com.zn.wr.controller;


import com.zn.wr.dao.contentDAO;
import com.zn.wr.model.Content;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;


@Controller
public class SaveController {

    private Content content;

    @Resource
    private contentDAO contentdao;

    /**
     * Initial Content
     */
    @ResponseBody
    @RequestMapping(value = "initdata", method = RequestMethod.POST)
    public Content toInitData() {
        this.content = new Content();
        this.content.setScontent(contentdao.search());
        System.out.println("content:" + this.content.getScontent());
        return content;
    }

    /**
     * Manual Saving
     */
    @PostMapping(value = "save")
    @ResponseBody
    public Map<String, Object> doSave(@RequestBody String initcontent) {
        boolean state = contentdao.insert(initcontent);
        Map<String, Object> modelMap = new HashMap<String, Object>();
        modelMap.put("state", state);
        return modelMap;
    }

}
