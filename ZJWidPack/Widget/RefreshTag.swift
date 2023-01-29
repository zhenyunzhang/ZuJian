//
//  RefreshTag.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    typealias Intent = RefreshTagIntent
    typealias Entry = RfrTagSimpleEntry
    
    // 占位视图，是一个标准的 SwiftUI View，当第一次展示或者发生错误时都会展示该 View。
    func placeholder(in context: Context) -> RfrTagSimpleEntry {
        let date = Date()
        let message = "placeholder"
        
        return RfrTagSimpleEntry(date: date, message: message)
    }
    
    // 编辑屏幕在左上角选择添加Widget、第一次展示时会调用该方法
    func getSnapshot(for configuration: RefreshTagIntent, in context: Context, completion: @escaping (RfrTagSimpleEntry) -> ()) {
        let date = Date()
        let message = "getSnapshot"
        
        let entry = RfrTagSimpleEntry(date: date, message: message)
        completion(entry)
    }
    
    // 进行数据的预处理，转化成Entry 调用 completion，刷新Widget
    func getTimeline(for configuration: RefreshTagIntent, in context: Context, completion: @escaping (Timeline<RfrTagSimpleEntry>) -> Void) {
        
        var entries: [RfrTagSimpleEntry] = []
        
        var currentDate = Date()
        var nextDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var currentDateStr = ""
        var nextDateStr = ""

        for i in 1 ..< 5 {
            var msg = ""
            currentDate = nextDate;
            nextDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
            currentDateStr = formatter.string(from: currentDate)
            nextDateStr = formatter.string(from: nextDate)
            
            msg.append("时间轴第" + String(i+1) + "个视图\n")
            msg.append("\n本次视图开始时间 " + currentDateStr)
            msg.append("\n下次视图开始时间 " + nextDateStr)
            
            let entry = RfrTagSimpleEntry(date: currentDate, message: msg)
            
            entries.append(entry)
            print(String(i))
        }
        
        /*
         .never（不刷新）
         .atEnd（Entry 显示完毕之后自动刷新）
         .after(date)（到达某个特定时间后自动刷新）
         */
        
        //等entries都显示完毕之后，再进行Timeline 的刷新
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
}

struct RfrTagSimpleEntry: TimelineEntry {
    public let date: Date
    public let message: String
}

struct PlaceholderView : View {
    var body: some View {
        Text("PlaceholderView")
            .font(.callout)
    }
}

struct RfrTagEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        
        //widgetURL
        let str = "RfrTagWidget://123456"
        return Text(entry.message)
            .widgetURL(URL(string: str))
            .font(.callout)
        
        //Link
//        Link(destination: URL(string: "RfrTagWidget://123456")!) {
//            Text(entry.message)
//                .font(.callout)
//        }
        
        //组合
//        return VStack {
//            Link(destination: URL(string: "RfrTagWidget://home")!) {
//                Text("主页")
//            }
//
//            Spacer()
//
//            Link(destination: URL(string: "RfrTagWidget://setting")!) {
//                Text("设置")
//            }
//        }.widgetURL(URL(string: "RfrTagWidget://123456"))
        
    }
}


struct RefreshTag: Widget {
    let kind: String = "RefreshTag"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: RefreshTagIntent.self, provider: Provider()) { entry in
            RfrTagEntryView(entry: entry)
        }
        .configurationDisplayName("RefreshTag Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct RefreshTag_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date()
        let message = "RefreshTag_Previews"
        
        let entry = RfrTagSimpleEntry(date: date, message: message)
        return RfrTagEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
