//
//  ButtonModel.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/17.
//

#import "ButtonModel.h"

@implementation ButtonModel

+ (ButtonModel *)sharedButtonModel{
    static ButtonModel *_manager = nil;
    static dispatch_once_t __onceToken;
    dispatch_once(&__onceToken, ^{
        _manager = [[ButtonModel alloc] init];
    });
    return _manager;
}


- (NSArray *)itemList{
    if (!_itemList) {
        
        NSArray *list = @[
            @{@"title":@"嫦娥", @"detials":@"云母屏风烛影深， 长河渐落晓星沉。 嫦娥应悔偷灵药， 碧海青天夜夜心。"},
            @{@"title":@"江雨", @"detials":@"江雨霏霏江草齐，六朝如梦鸟空啼。 无情最是台城柳，依旧烟笼十里堤。"},
            @{@"title":@"行宫", @"detials":@"寥落古行宫，宫花寂寞红。 白头宫女在，闲坐说玄宗。"},
            @{@"title":@"十二楼", @"detials":@"冰簟银床梦不成，碧天如水夜云轻。 雁声远过潇湘去，十二楼中月自明。"},
            @{@"title":@"黄鹤楼", @"detials":@"故人西辞黄鹤楼，烟花三月下扬州。 孤帆远影碧空尽，唯见长江天际流。"},
            @{@"title":@"北斗七星", @"detials":@"北斗七星高，哥舒夜带刀。 至今窥牧马，不敢过临洮。"},
            @{@"title":@"寻寻觅觅", @"detials":@"寻寻觅觅，冷冷清清，凄凄惨惨戚戚。"},
            @{@"title":@"居士", @"detials":@"壶山居士，未老心先懒。爱学道人家，办竹几、蒲团茗碗"},
            @{@"title":@"玉楼", @"detials":@"莫上玉楼看。花雨斑斑。四垂罗幕护朝寒。"},
            @{@"title":@"伊人", @"detials":@"蒹葭苍苍，白露为霜。所谓伊人，在水一方，溯洄从之，道阻且长。"}
        ];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            BtnItemModel *itemModel = [[BtnItemModel alloc] init];
            itemModel.length = i;
            itemModel.bgImgName = [NSString stringWithFormat:@"bg%d", i];
            itemModel.link = [NSString stringWithFormat:@"Btn://type%d", i];
            
            NSDictionary *dict = list[i];
            itemModel.details = [dict objectForKey:@"detials"];
            itemModel.title = [dict objectForKey:@"title"];
            
            [arrM addObject:itemModel];
        }
        
        _itemList = arrM.copy;
    }
    return _itemList;
}

- (BtnItemModel*)getSelectItemWithName:(NSString*)name{
    
    for (BtnItemModel *itemModel in self.itemList) {
        if ([itemModel.title isEqualToString:name]) {
            return itemModel;
        }
    }
    
    return self.itemList.firstObject;
}

- (NSArray*)seatchWithInput:(NSString*)input{
    if (input.length == 0) {
        return [NSArray array];
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (BtnItemModel *itemModel in self.itemList) {
        if ([itemModel.title containsString:input]) {
            [arrM addObject:itemModel];
        }
    }
    
    return arrM.copy;
}

@end


@implementation BtnItemModel

@end
