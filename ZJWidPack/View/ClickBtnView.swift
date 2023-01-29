//
//  ClickBtnView.swift
//  ZJWidPackExtension
//
//  Created by zhangzhenyun on 2023/1/17.
//

import SwiftUI

struct ClickBtnView : View {
    
    let itemModel : BtnItemModel
    
    var body: some View {
        
        Text(itemModel.details)
            .widgetURL(URL(string: itemModel.link))
            .background(Image(itemModel.bgImgName))
            .font(.callout)
    }
}
