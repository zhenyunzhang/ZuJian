//
//  IntentHandler.swift
//  ZJWidIntentExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}

extension IntentHandler : ClickBtnIntentHandling {
    //列表总数据
    func provideBtnTypeOptionsCollection(for intent: ClickBtnIntent, with completion: @escaping (INObjectCollection<BtnType>?, Error?) -> Void) {
        //把数据跟BtnType 绑定
        let list : [BtnType] = ButtonModel.shared().itemList.map { itemModel in
            let item = BtnType(identifier: (itemModel as AnyObject).title, display: (itemModel as AnyObject).title)
            return item
        }
        let collection = INObjectCollection(items: list)
        completion(collection, nil)
    }
    //搜索时,根据关键词需要返回的展示数据
    func provideBtnTypeOptionsCollection(for intent: ClickBtnIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<BtnType>?, Error?) -> Void) {
        let searchList = ButtonModel.shared().seatch(withInput: searchTerm!)
        let list : [BtnType] = searchList.map { itemModel in
            let item = BtnType(identifier: (itemModel as AnyObject).title, display: (itemModel as AnyObject).title)
            return item
        }
        let collection = INObjectCollection(items: list)
        completion(collection, nil)
    }
    //弹框中参数默认数据
    func defaultBtnType(for intent: ClickBtnIntent) -> BtnType? {
        let itemModel = ButtonModel.shared().itemList.first
        let item = BtnType(identifier: (itemModel as AnyObject).title, display: (itemModel as AnyObject).title)
        return item
    }
}
