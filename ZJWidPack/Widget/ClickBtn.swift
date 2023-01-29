//
//  ClickBtn.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//


import WidgetKit
import SwiftUI
import Intents

struct ClickBtnProvider: IntentTimelineProvider {
    //默认视图
    func placeholder(in context: Context) -> CliBtnSimpleEntry {
        let itemModel = ButtonModel.shared().itemList.first
        return CliBtnSimpleEntry(date: Date(), itemModel: itemModel as! BtnItemModel)
    }
    
    //预览快照,一个大致情况
    func getSnapshot(for configuration: ClickBtnIntent, in context: Context, completion: @escaping (CliBtnSimpleEntry) -> ()) {
        let itemModel = ButtonModel.shared().itemList.first
        let entry = CliBtnSimpleEntry(date: Date(), itemModel: itemModel as! BtnItemModel)
        completion(entry)
    }
    
    
    //刷新事件
    func getTimeline(for configuration: ClickBtnIntent, in context: Context, completion: @escaping (Timeline<CliBtnSimpleEntry>) -> ()) {
        
        //更新时间
//        let currentDate = Date()
//        let refreshDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
        
        //获取选中的
//        if let name = configuration.btnType?.identifier, let itemModel:BtnItemModel = ButtonModel.shared().getSelectItem(withName: name) {
//            let entry = CliBtnSimpleEntry(date: currentDate, itemModel: itemModel)
//            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
//
//            completion(timeline)
//            return
//        }
        
        //AppGroup数据
        let gushiData = GroupManager.shared().getGushiData()
        guard gushiData.count > 0 else {
            completion(Timeline(entries: [], policy: .atEnd))
            return
        }
        
        let list:[BtnItemModel] = gushiData as! [BtnItemModel]
        var entries: [CliBtnSimpleEntry] = []
        var currentDate = Date()
        var nextDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!

        for i in 1 ..< list.count {
            currentDate = nextDate;
            nextDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
            let itemModel:BtnItemModel = list[i]
            let entry = CliBtnSimpleEntry(date: currentDate, itemModel: itemModel)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func selectItem(for configuration: ClickBtnIntent) -> BtnItemModel {
        
        // 根据BtnType绑定的值，取出相应的数据
        if let name = configuration.btnType?.identifier, let itemModel:BtnItemModel = ButtonModel.shared().getSelectItem(withName: name) {
            return itemModel;
        }
        return ButtonModel.shared().itemList.first as! BtnItemModel
    }

}

//用来保存所需要的数据
struct CliBtnSimpleEntry: TimelineEntry {
    let date: Date
    let itemModel : BtnItemModel
}

//用来展示的视图View
struct CliBtnEntryView : View {
    //三种样式
//    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var entry: ClickBtnProvider.Entry
    var body: some View {
//        switch family {
//            case .systemSmall:
//            case .systemMedium:
//            case .systemLarge:
//            default:
//
//        }
        
        ClickBtnView(itemModel: entry.itemModel)
    }
}


struct ClickBtn: Widget {
    let kind: String = "ClickBtn"  // 标识符，不能和其他Widget重复，最好就是使用当前Widgets的名字。
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ClickBtnIntent.self, provider: ClickBtnProvider()) { entry in
            CliBtnEntryView(entry: entry)
        }
        .configurationDisplayName("自定义选择")         //Widget显示的名字
        .description("选择自己喜欢的")                           //Widget的描述
        .supportedFamilies([.systemMedium]) //组建显示的类型
    }
}


struct ClickBtn_Previews: PreviewProvider {
    static var previews: some View {
        CliBtnEntryView(entry: CliBtnSimpleEntry(date: Date(), itemModel: BtnItemModel()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

//extension ClickBtn :
//providecardoptioncollection
