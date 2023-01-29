//
//  RSSReader.swift
//  RSSReaderExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

struct RSSReaderProvider: IntentTimelineProvider {
    //默认视图
    func placeholder(in context: Context) -> RSSSimpleEntry {
        RSSSimpleEntry(date: Date(), rssModel: RSSModel())
    }
    
    //预览快照,一个大致情况
    func getSnapshot(for configuration: RSSReaderIntent, in context: Context, completion: @escaping (RSSSimpleEntry) -> ()) {
        let entry = RSSSimpleEntry(date: Date(), rssModel: RSSModel())
        completion(entry)
    }
    
    
    //刷新事件
    func getTimeline(for configuration: RSSReaderIntent, in context: Context, completion: @escaping (Timeline<RSSSimpleEntry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        
        let entry = RSSSimpleEntry(date: currentDate, rssModel: RSSModel())
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }

}

//用来保存所需要的数据
struct RSSSimpleEntry: TimelineEntry {
    let date: Date
    let rssModel : RSSModel
}

//用来展示的视图View
struct RSSReaderEntryView : View {
    //三种样式
    //@Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: RSSReaderProvider.Entry

    var body: some View {
        RSSContentView(rssModel: RSSModel())
    }
}

struct RSSReaderPlaceholderView : View {
    
    var body: some View {
        RSSContentView(rssModel: RSSModel())
    }
}


struct RSSReader: Widget {
    let kind: String = "RSSReader"  // 标识符，不能和其他Widget重复，最好就是使用当前Widgets的名字。

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: RSSReaderIntent.self, provider: RSSReaderProvider()) { entry in
            RSSReaderEntryView(entry: entry)
        }
        .configurationDisplayName("RSS阅读器")         //Widget显示的名字
        .description("快捷获取你关心的最新信息")           //Widget的描述
        .supportedFamilies([.systemMedium]) //组建显示的类型
    }
}


struct RSSReader_Previews: PreviewProvider {
    static var previews: some View {
        RSSReaderEntryView(entry: RSSSimpleEntry(date: Date(), rssModel: RSSModel()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
