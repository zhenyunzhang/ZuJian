//
//  OneContentView.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/17.
//

#import "OneContentView.h"
#import <Masonry/Masonry.h>

@interface OneContentView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *fromLabel;

@end

@implementation OneContentView

- (instancetype)init{
    if (self = [super init]) {
        [self setupViewUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViewUI];
    }
    return self;
}

- (void)setupViewUI{
    [self.fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.fromLabel);
        make.top.equalTo(self).offset(15);
        make.bottom.lessThanOrEqualTo(self.fromLabel.mas_top).offset(-10);
    }];
}


#pragma mark - Model
- (void)setOneModel:(OneWordModel *)oneModel{
    _oneModel = oneModel;
    
    self.titleLabel.text = oneModel.hitokoto;
    self.titleLabel.font = [UIFont systemFontOfSize:oneModel.lengtn];
    self.fromLabel.text = oneModel.from;
}

#pragma mark - Lazy
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)fromLabel{
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.font = [UIFont systemFontOfSize:15];
        _fromLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_fromLabel];
    }
    return _fromLabel;
}

@end
