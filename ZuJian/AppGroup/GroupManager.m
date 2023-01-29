//
//  GroupManager.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/18.
//

#import "GroupManager.h"
#import "ButtonModel.h"

#define GroupId @"group.com.ios.zujian"

@implementation GroupManager
+ (instancetype)shared {
    static GroupManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GroupManager alloc] init];
    });
    return manager;
}

- (void)writeGushiData {
    NSArray *list = @[
        @{@"title":@"行宫", @"detials":@"1--寥落古行宫，宫花寂寞红。白头宫女在，闲坐说玄宗。"},
        @{@"title":@"鹿柴", @"detials":@"2--空山不见人，但闻人语响。返景入深林，复照青苔上。"},
        @{@"title":@"杂诗", @"detials":@"3--君自故乡来，应知故乡事。来日绮窗前，寒梅著花未？"},
        @{@"title":@"相思", @"detials":@"4--红豆生南国，春来发几枝。愿君多采撷，此物最相思。"},
        @{@"title":@"静夜", @"detials":@"5--床前明月光，疑是地上霜。举头望明月，低头思故乡。"},
        @{@"title":@"玉楼", @"detials":@"6--莫上玉楼看。花雨斑斑。四垂罗幕护朝寒。"},
        @{@"title":@"送别", @"detials":@"7--山中相送罢，日暮掩柴扉。春草明年绿，王孙归不归？"},
        @{@"title":@"登乐", @"detials":@"8--向晚意不适，驱车登古原。夕阳无限好，只是近黄昏。"},
        @{@"title":@"嫦娥", @"detials":@"9--云母屏风烛影深， 长河渐落晓星沉。 嫦娥应悔偷灵药， 碧海青天夜夜心。"},
        @{@"title":@"怨情", @"detials":@"10--美人卷珠帘，深坐颦蛾眉。但见泪痕湿，不知心恨谁。"},
        @{@"title":@"听筝", @"detials":@"11--鸣筝金粟柱，素手玉房前。欲得周郎顾，时时误拂弦。"},
        @{@"title":@"伊人", @"detials":@"12--蒹葭苍苍，白露为霜。所谓伊人，在水一方，溯洄从之，道阻且长。"},
        @{@"title":@"江雪", @"detials":@"13--千山鸟飞绝，万径人踪灭。孤舟蓑笠翁，独钓寒江雪。"},
        @{@"title":@"送上", @"detials":@"14--孤云将野鹤，岂向人间住。莫买沃洲山，时人已知处。"},
        @{@"title":@"春宫", @"detials":@"15--昨夜风开露井桃，未央前殿月轮高。平阳歌舞新承宠，帘外春寒赐锦袍。"},
        @{@"title":@"忆弟", @"detials":@"16--独在异乡为异客，每逢佳节倍思亲。遥知兄弟登高处，遍插茱萸少一人。"},
        @{@"title":@"宫词", @"detials":@"17--寂寂花时闭院门，美人相并立琼轩。含情欲说宫中事，鹦鹉前头不敢言。"},
        @{@"title":@"北斗", @"detials":@"18--北斗七星高，哥舒夜带刀。 至今窥牧马，不敢过临洮。"},
        @{@"title":@"夜雨", @"detials":@"19--君问归期未有期，巴山夜雨涨秋池。何当共剪西窗烛，却话巴山夜雨时。"},
        @{@"title":@"寻寻", @"detials":@"20--寻寻觅觅，冷冷清清，凄凄惨惨戚戚。"},
        @{@"title":@"瑶池", @"detials":@"21--瑶池阿母绮窗开，黄竹歌声动地哀。八骏日行三万里，穆王何事不重来。"},
        @{@"title":@"为有", @"detials":@"22--为有云屏无限娇，凤城寒尽怕春宵。无端嫁得金龟婿，辜负香衾事早朝。"},
        @{@"title":@"月夜", @"detials":@"23--更深月色半人家，北斗阑干南斗斜。今夜偏知春气暖，虫声新透绿窗纱。"},
        @{@"title":@"黄鹤", @"detials":@"24--故人西辞黄鹤楼，烟花三月下扬州。 孤帆远影碧空尽，唯见长江天际流。"},
        @{@"title":@"终南", @"detials":@"25--太乙近天都，连山接海隅。白云回望合，青霭入看无。"},
        @{@"title":@"和乐", @"detials":@"26--新妆宜面下朱楼，深锁春光一院愁。行到中庭数花朵，蜻蜓飞上玉搔头。"},
        @{@"title":@"江雨", @"detials":@"27--江雨霏霏江草齐，六朝如梦鸟空啼。 无情最是台城柳，依旧烟笼十里堤。"},
        @{@"title":@"十二", @"detials":@"28--冰簟银床梦不成，碧天如水夜云轻。 雁声远过潇湘去，十二楼中月自明。"},
        @{@"title":@"征人", @"detials":@"29--岁岁金河复玉关，朝朝马策与刀环。三春白雪归青冢，万里黄河绕黑山。"},
        @{@"title":@"已凉", @"detials":@"30--碧阑干外绣帘垂，猩色屏风画折枝。八尺龙须方锦褥，已凉天气未寒时。"},
        @{@"title":@"行宫", @"detials":@"31--寥落古行宫，宫花寂寞红。 白头宫女在，闲坐说玄宗。"},
        @{@"title":@"寒食", @"detials":@"32--春城无处不飞花，寒食东风御柳斜。日暮汉宫传蜡烛，轻烟散入五侯家。"},
        @{@"title":@"杂诗", @"detials":@"33--近寒食雨草萋萋，著麦苗风柳映堤。等是有家归未得，杜鹃休向耳边啼。"},
        @{@"title":@"居士", @"detials":@"34--壶山居士，未老心先懒。爱学道人家，办竹几、蒲团茗碗"},
        @{@"title":@"送别", @"detials":@"35--下马饮君酒，问君何所之？君言不得意，归卧南山陲。但去莫复问，白云无尽时。"},
    ];
    
    NSError *err;
    NSURL *url = [self gushiURL];
    BOOL result = [list writeToURL:url error:&err];
    
    NSLog(@"222222------ result = %@",result ? @"成功" : @"失败");
    NSLog(@"222222------ err = %@",err);
}

- (NSArray *)getGushiData {
    static NSInteger page = 0;
    if (page > 7) {
        page = 0;
    }
    
    NSError *err;
    NSURL *url = [self gushiURL];
    
    NSArray *totalList = [NSArray arrayWithContentsOfURL:url error:&err];
    NSInteger count = totalList.count;
    
    NSLog(@"222222------ totalList = %@ -- err = %@",totalList,err);
    
    NSInteger totalPage = totalList.count / 5;
    NSArray *pageList;
    if (count > 0 && page <= totalPage ) { //每次取 5 条数据
        NSRange range = NSMakeRange(page, page * 5);
        pageList = [totalList subarrayWithRange:range];
        NSLog(@"222222------ pageList = %@",pageList);
    }
    
    
    NSMutableArray *modelArr = [NSMutableArray array];
    
    for (int i = 0; i < pageList.count; i++) {
        BtnItemModel *item = [[BtnItemModel alloc] init];
        item.length = i;
        item.bgImgName = [NSString stringWithFormat:@"bg%d", i];
        item.link = [NSString stringWithFormat:@"Btn://type%d", i];
        
        NSDictionary *dict = pageList[i];
        item.details = [dict objectForKey:@"detials"];
        item.title = [dict objectForKey:@"title"];
        
        [modelArr addObject:item];
    }
    
    
    page++;
    return modelArr;
}


- (NSURL *)gushiURL {
    NSURL *groupURL = [self groupURL];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"gushi.plist"];
    return fileURL;
}

- (NSURL *)groupURL {
    NSFileManager *fileM = [NSFileManager defaultManager];
    NSURL *url = [fileM containerURLForSecurityApplicationGroupIdentifier:GroupId];
    return url;
}



@end
