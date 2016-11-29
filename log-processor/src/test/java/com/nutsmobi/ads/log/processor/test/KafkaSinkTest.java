package com.nutsmobi.ads.log.processor.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nutsmobi.ads.log.processor.bean.UserItem;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * 测试 KafkaSink
 *
 * Author: Noprom <tyee.noprom@qq.com>
 * Date: 18/10/2016 3:30 PM.
 */
public class KafkaSinkTest {

    @Test
    public void parseFlumeData() {
        String line = "10.0.17.2|2016-07-29 15:19:52|{\"default\":\"com.google.android.apps.maps\",\"Action\":\"1501\",\"h08\":\"89860020181777451385\",\"h09\":\"867692010496734\",\"h07\":\"460023074511385\",\"h06\":\"R054_0DUOMIUI\",\"list\":[{\"package\":\"com.android.calendar\",\"click\":1,\"class\":\"com.android.calendar.AllInOneActivity\",\"version\":\"17\",\"name\":\"日历\"},{\"package\":\"com.android.settings\",\"click\":1,\"class\":\"com.android.settings.Settings\",\"version\":\"17\",\"name\":\"设置\"},{\"package\":\"com.mediatek.filemanager\",\"click\":1,\"class\":\"com.mediatek.filemanager.FileManagerOperationActivity\",\"version\":\"1\",\"name\":\"文件管理\"},{\"package\":\"com.tencent.mobileqq\",\"click\":1,\"class\":\"com.tencent.mobileqq.activity.SplashActivity\",\"version\":\"104\",\"name\":\"QQ\"},{\"package\":\"com.baidu.searchbox\",\"click\":17,\"class\":\"com.baidu.searchbox.MainActivity\",\"version\":\"16783887\",\"name\":\"百度\"},{},{},{},{},{},{},{\"package\":\"com.mxtech.videoplayer.ad\",\"click\":5,\"class\":\"com.mxtech.videoplayer.ad.ActivityMediaList\",\"version\":\"1170000086\",\"name\":\"MX Player\"},{\"package\":\"com.tencent.mm\",\"click\":12,\"class\":\"com.tencent.mm.ui.LauncherUI\",\"version\":\"700\",\"name\":\"微信\"}],\"h05\":\"f1381\",\"h04\":\"shfz259\",\"h03\":\"MyHome.V1.0.126.18454.140116\",\"h02\":18454,\"h01\":\"com.cooee.Mylauncher\",\"h10\":\"\"}";

        String[] jsonArr = line.split("\\|");
        if (jsonArr.length == 3) {
            String jsonStr = jsonArr[2];
            JSONObject jsonObject = JSON.parseObject(jsonStr);
            String userId = (String) jsonObject.get("h09");
            JSONArray list = (JSONArray) jsonObject.get("list");
            List<UserItem> userItemList = new ArrayList<UserItem>();

            for (Object object: list) {
                JSONObject event = (JSONObject) object;
                String pkg = (String) event.get("package");
                Integer click = (Integer) event.get("click");
                if (pkg != null && click != null) {
                    UserItem userItem = UserItem.fromObject(userId, pkg, click);
                    userItemList.add(userItem);
                }
            }
            System.out.println(userItemList);
        }
    }
}