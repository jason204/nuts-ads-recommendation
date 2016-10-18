package com.nutsmobi.ads.log.processor.bean;

import java.io.Serializable;

/**
 * 推荐算法 USER-ITEM-CLICK 模型
 *
 * Author: Noprom <tyee.noprom@qq.com>
 * Date: 18/10/2016 4:08 PM.
 */
public class UserItem implements Serializable {

    private String user;
    private String item;
    private Integer click;

    public UserItem(String user, String item, Integer click) {
        this.user = user;
        this.item = item;
        this.click = click;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public Integer getClick() {
        return click;
    }

    public void setClick(Integer click) {
        this.click = click;
    }

    @Override
    public String toString() {
        return "UserItem{" +
                "user='" + user + '\'' +
                ", item='" + item + '\'' +
                ", click=" + click +
                '}';
    }

    public static UserItem fromObject(String user, String item, Integer click) {
        return new UserItem(user, item, click);
    }
}