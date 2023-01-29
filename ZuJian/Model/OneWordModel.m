//
//  OneWordModel.m
//  ZuJian
//
//  Created by zhangzhenyun on 2023/1/17.
//

#import "OneWordModel.h"

@implementation OneWordModel

+ (void)getContentCompletion:(CompletaTaskBlack)completion{
    NSURL *url = [NSURL URLWithString:@"https://v1.hitokoto.cn/"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            OneWordModel *oneModel = [[OneWordModel alloc] init];

            if (error) {
                if (completion) {
                    oneModel.hitokoto = @"很遗憾本次更新失败,等待下一次更新.";
                    oneModel.from = @"失败了...";
                    oneModel.lengtn = 1;
                    completion(error, nil);
                }
            } else {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                oneModel.hitokoto = [dict objectForKey:@"hitokoto"];
                oneModel.from = [dict objectForKey:@"from"];
                oneModel.lengtn = [[dict objectForKey:@"length"] integerValue];
                
                if (completion) {
                    completion(nil, oneModel);
                }
            }
        });
    }];
    
    [task resume];
}

@end
