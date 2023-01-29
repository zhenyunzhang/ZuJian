//
//  RSSContentView.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import SwiftUI

struct RSSContentView : View {
    
    let rssModel : RSSModel
    
    var body: some View {
        
        Link(destination: URL(string: "https://www.baidu.com")!) {
            VStack(alignment: .leading, spacing: 10, content: {
                
                Text("我是一个大标题，大标题，标题")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                //
                HStack(alignment: .bottom, spacing: nil, content: {
                    Text("RSS阅读器")
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                    //
                    Spacer()
                    //
                    Text("1天前")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                })
            }).padding(.all)
        }
    }
}
