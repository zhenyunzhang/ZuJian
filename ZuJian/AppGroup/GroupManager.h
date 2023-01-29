//
//  GroupManager.h
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupManager : NSObject
+ (instancetype)shared;

- (void)writeGushiData;

- (NSArray *)getGushiData;

@end

NS_ASSUME_NONNULL_END
