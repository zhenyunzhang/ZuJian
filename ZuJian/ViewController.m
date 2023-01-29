//
//  ViewController.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/17.
//

#import "ViewController.h"
#import "OneWordModel.h"
#import "ButtonModel.h"
#import "ZuJian-Swift.h"
#import <WidgetKit/WidgetKit.h>
#import <Masonry/Masonry.h>
#import "ListCollectionViewCell.h"

typedef NS_OPTIONS(NSInteger, HomeSectionCode) {
    HOME_OneWord = 0,       // 一句话
    HOME_RefreshWidget,     // 刷新widget
    HOME_Select,            // 自定义选择
    
};

#define kCellTitle  @"kCellTitle"
#define kCellCode   @"kCellCode"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *oneLabel;

@property (nonatomic, strong) UICollectionView *listCollectionView;
@property (nonatomic, strong) NSArray *listData;
@property (nonatomic, copy)   NSString *oneString;

@end

static NSString *kListCollectionViewCellKey = @"kListCollectionViewCellKey";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getOneText];
    [self setViewUI];
}

- (void)setViewUI{
    [self.listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



//刷新指定的widget
- (IBAction)clickRefreshButton:(UIButton *)sender {
    NSLog(@"刷新指定的widget");
    
    [WidgetManager reloadAllTimeLines];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.listData.count;
    }
    return [ButtonModel sharedButtonModel].itemList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kListCollectionViewCellKey forIndexPath:indexPath];

    if (indexPath.section == 1) {
        BtnItemModel *itemModel = [ButtonModel sharedButtonModel].itemList[indexPath.item];
        cell.textName = itemModel.details;
        cell.imgName = itemModel.bgImgName;
    
    } else {
        NSDictionary *dict = self.listData[indexPath.item];
        NSNumber *number = [dict objectForKey:kCellCode];
        
        cell.textName = [dict objectForKey:kCellTitle];
        cell.imgName = @"";
        
        if (self.oneString.length > 0 && [number integerValue] == HOME_OneWord) {
            cell.textName = [NSString stringWithFormat:@"言:%@", self.oneString];
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.bounds.size.width-30)/2, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.listData[indexPath.item];
    NSNumber *number = [dict objectForKey:kCellCode];
    
    switch ([number integerValue]) {
        case HOME_OneWord:
            [self getOneText];
            break;
        case HOME_RefreshWidget:
            [self clickWidget];
            break;
        case HOME_Select:
            
            break;
        default:
            break;
    }
}

//获取一言
- (void)getOneText{
    __weak __typeof(self) weakSelf = self;
    [OneWordModel getContentCompletion:^(NSError * _Nullable error, OneWordModel * _Nullable oneModel) {
        NSLog(@"%@", oneModel.hitokoto);
        
        weakSelf.oneString = oneModel.hitokoto;
        [weakSelf.listCollectionView reloadData];
        [WidgetManager reloadTimeLinesWithKind:@"OneWord"];
    }];
}

//刷新widget
- (void)clickWidget{
    //刷新全部
    [WidgetManager reloadAllTimeLines];
}

#pragma mark - Lazy
- (UICollectionView *)listCollectionView{
    if (!_listCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 0;
        
        _listCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _listCollectionView.delegate = self;
        _listCollectionView.dataSource = self;
        _listCollectionView.backgroundColor = [UIColor grayColor];
        
        [_listCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:kListCollectionViewCellKey];
        
        [self.view addSubview:_listCollectionView];
    }
    return _listCollectionView;
}

- (NSArray *)listData{
    if (!_listData) {
        _listData = @[
            @{kCellTitle : @"每日一言",     kCellCode : @(HOME_OneWord)},
            @{kCellTitle : @"刷新Widget",  kCellCode : @(HOME_RefreshWidget)},
            @{kCellTitle : @"自定义选择",   kCellCode : @(HOME_Select)},
        ];
    }
    return _listData;
}

@end
