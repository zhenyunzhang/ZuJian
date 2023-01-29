//
//  ZJWidPack.swift
//  ZJWidPack
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

//
struct SimpleEntry: TimelineEntry {
    let date: Date
}

//@main 代表着Widget的主入口，系统从这里加载
//展示多个Widget
@main
struct ZJWidPack: WidgetBundle {
    @WidgetBundleBuilder
    
    var body : some Widget{
//        OneWord()       //每日一言
//        RSSReader()     //RSS
//        CountDownTime()     //倒计时
        ClickBtn()          //动态列表
//        LineClick()         //点击链接
//        RefreshTag()      //测试刷新
    }
}
