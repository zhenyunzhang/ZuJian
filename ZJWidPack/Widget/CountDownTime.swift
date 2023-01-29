//
//  CountDownTime.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

struct CountDownModel {
    var day:Int = 0
    var date:Date
    var title:String
}

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let now = Date()
        
        let nowTimeStamp = Int(now.timeIntervalSince1970)
        let toDateTimeStamp = Int(toDate.timeIntervalSince1970)
        let difference:Double = Double(abs(nowTimeStamp - toDateTimeStamp))
        
        if(nowTimeStamp < toDateTimeStamp){
            return Int(floor( difference / (86400))) + 1
        }
        return Int(floor( difference / (86400)))
    }
    
    func dateToString(_ date:Date,dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
         formatter.locale = Locale.init(identifier: "zh_CN")
         formatter.dateFormat = dateFormat
         let date = formatter.string(from: date)
         return date
    }
    
    func getRelateiveDate(unitsStyle: RelativeDateTimeFormatter.UnitsStyle)->String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = unitsStyle
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

struct CountDownProvider: IntentTimelineProvider {
    //默认视图
    func placeholder(in context: Context) -> CountDownSimpleEntry {
        CountDownSimpleEntry(date: Date(), timeModel: CountDownModel(date: Date(), title: "到期时间"))
    }
    
    //预览快照,一个大致情况
    func getSnapshot(for configuration: CountDownTimeIntent, in context: Context, completion: @escaping (CountDownSimpleEntry) -> ()) {
        let entry = CountDownSimpleEntry(date: Date(), timeModel: CountDownModel(date: Date(), title: "到期时间"))
        completion(entry)
    }
    
    
    //刷新事件
    func getTimeline(for configuration: CountDownTimeIntent, in context: Context, completion: @escaping (Timeline<CountDownSimpleEntry>) -> ()) {
        
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        //Widget输入的日期默认为中午12点
        let configureDate = (configuration.date?.date  ?? Date()) - 12 * 3600
        
        let entry = CountDownSimpleEntry(date: currentDate, timeModel: CountDownModel(day: Date().daysBetweenDate(toDate: configureDate), date: configureDate,title: configuration.title ?? "请配置标题" ))
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }

}

//用来保存所需要的数据
struct CountDownSimpleEntry: TimelineEntry {
    let date: Date
    let timeModel: CountDownModel
}

//用来展示的视图View
struct CountDownEntryView : View {
    //三种样式
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: CountDownProvider.Entry

    var body: some View {
        switch family {
        case .systemSmall: CountDownView(title: entry.timeModel.title, day: entry.timeModel.day)
        case .systemMedium: CountDownView(title: entry.timeModel.title, day: entry.timeModel.day)
        default: CountDownView(title: entry.timeModel.title, day: entry.timeModel.day)
        }
    }
}


struct CountDownTime: Widget {
    let kind: String = "CountDownTime"  // 标识符，不能和其他Widget重复，最好就是使用当前Widgets的名字。

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: CountDownTimeIntent.self, provider: CountDownProvider()) { entry in
            CountDownEntryView(entry: entry)
        }
        .configurationDisplayName("倒计时")         //Widget显示的名字
        .description("输入一个日期，静静地等它到来")                           //Widget的描述
        .supportedFamilies([.systemSmall]) //组建显示的类型
    }
}

