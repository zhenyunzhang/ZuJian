//
//  LineContentView.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//
/*
 Text 用来显示文字 类似于UIKit中的UILabel
 Image 用来显示图片 类似于UIKit中的UIImageView
 Spacer用来填充空白
 
 VStack 竖直摆放的组合组件
 HStack 水平摆放的组合组件
 List 用来展示列表 类似于UIKit中的UITableView
 
 NavigationView 展示导航栏 类似于 UINavigationBar
 NavigationButton 类似于pushViewController:方法
 
 */

import SwiftUI
import WebKit

struct LineContentView : View {
    
    var body: some View {
        
        //        //让图片能在底部
        //        ZStack(alignment: .topLeading) {
        //            //背景图片
        //            Image("12")
        //                .resizable()
        ////                .cornerRadius(30)
        ////                .shadow(color: Color.black, radius: 20, x: 0, y: 0)
        //        }
        
        VStack(alignment: .center, spacing: 3) {
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                Spacer()
                Link(destination: URL(string: "RfrTagWidget://home")!) {
                    LineListItemView(bgColor: Color.red, title: "首页")
                }
                Link(destination: URL(string: "RfrTagWidget://mine")!) {
                    LineListItemView(bgColor: Color.yellow, title: "我的")
                }
                LineListItemView(bgColor: Color.blue, title: "菜单")
                    .widgetURL(URL(string: "RfrTagWidget://menu"))
                LineListItemView(bgColor: Color.green, title: "设置")
                    .widgetURL(URL(string: "RfrTagWidget://setting"))
                
                Spacer()
            }
            Spacer()
        }.widgetURL(URL(string: "RfrTagWidget://Widget"))
    }
}



struct LineListItemView : View {
    
    let bgColor : Color
    let title : String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
            Spacer()
            Text(title)
            
        }
    }
    
}

struct LineContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
