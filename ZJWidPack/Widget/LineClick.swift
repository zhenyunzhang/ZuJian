//
//  LineClick.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

struct LineClickProvider: IntentTimelineProvider {
    //默认视图
    func placeholder(in context: Context) -> LineSimpleEntry {
        LineSimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    //预览快照,一个大致情况
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (LineSimpleEntry) -> ()) {
        let entry = LineSimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    
    //刷新事件
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<LineSimpleEntry>) -> ()) {
        var entries: [LineSimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = LineSimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

//用来保存所需要的数据
struct LineSimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

//用来展示的视图View
struct LineEntryView : View {
    //三种样式
    //@Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: LineClickProvider.Entry

    var body: some View {
        LineContentView()
    }
}


struct LineClick: Widget {
    let kind: String = "LineClick"  // 标识符，不能和其他Widget重复，最好就是使用当前Widgets的名字。

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: LineClickProvider()) { entry in
            LineEntryView(entry: entry)
        }
        .configurationDisplayName("快速启动")                   //Widget显示的名字
        .description("快速到达想要的页面")                        //Widget的描述
        .supportedFamilies([.systemMedium]) //组建显示的类型
    }
}


struct LineClick_Previews: PreviewProvider {
    static var previews: some View {
        LineEntryView(entry: LineSimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

