//
//  OneWord.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import WidgetKit
import SwiftUI
import Intents

struct OneProvider : IntentTimelineProvider {
    //默认视图
    func placeholder(in context: Context) -> OneSimpleEntry {
        let oneModel = OneWordModel();
        oneModel.hitokoto = "每日一言, 总有懂你的"
        oneModel.from = "懂你"
        return OneSimpleEntry(date: Date(), oneModel: oneModel)
    }
    
    //预览快照,一个大致情况
    func getSnapshot(for configuration: OneWordIntent, in context: Context, completion: @escaping (OneSimpleEntry) -> ()) {
        let oneModel = OneWordModel();
        oneModel.hitokoto = "每日一言, 总有懂你的"
        oneModel.from = "懂你"
        let entry = OneSimpleEntry(date: Date(), oneModel: oneModel)
        completion(entry)
    }
    
    //刷新事件
    func getTimeline(for configuration: OneWordIntent, in context: Context, completion: @escaping (Timeline<OneSimpleEntry>) -> ()) {
        
        //当前时间、下次刷新时间
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
        
        //获取数据
        OneWordModel.getContentCompletion { (error, oneModel) in
            
            let entry = OneSimpleEntry(date: currentDate, oneModel: oneModel!)
            
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

//用来保存所需要的数据
struct OneSimpleEntry: TimelineEntry {
    let date: Date
    public let oneModel : OneWordModel
}

//用来展示的视图View
struct OneEntryView : View {
    
    var entry: OneProvider.Entry

    var body: some View {
        ZJOneWordView(oneModel: entry.oneModel).onAppear{
            let intent = OneWordIntent()
            
            let interaction = INInteraction(intent: intent, response: nil)
            interaction.donate { error in
                if let error = error {
                    print("Donating intent failed with error \(error)")
                }
            }
        }
    }
}


struct OneWord: Widget {
    let kind: String = "OneWord"  // 标识符，不能和其他Widget重复，最好就是使用当前Widgets的名字。

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: OneWordIntent.self, provider: OneProvider()) { entry in
            OneEntryView(entry: entry)
        }
        .configurationDisplayName("每日一言")         //Widget显示的名字
        .description("每小时刷新一言")                 //Widget的描述
        .supportedFamilies([.systemMedium])         //组建显示的类型
    }
}

//
//struct OneWord_Previews: PreviewProvider {
//    static var previews: some View {
//        OneEntryView(entry: OneSimpleEntry(date: Date(), configuration: OneWordIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
