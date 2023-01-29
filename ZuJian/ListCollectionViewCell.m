//
//  ListCollectionViewCell.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/17.
//

#import "ListCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ListCollectionViewCell()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *bgImageView;

@end

@implementation ListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setViewUI];
    }
    return self;
}

- (void)setViewUI{
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setTextName:(NSString *)textName{
    _textName = textName;
    
    self.textLabel.text = textName;
}

- (void)setImgName:(NSString *)imgName{
    _imgName = imgName;
    
    self.bgImageView.image = [UIImage imageNamed:imgName];
}


#pragma mark - Lazy
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
        _textLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

@end
