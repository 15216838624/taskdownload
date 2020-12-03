//
//  DownLoader.h
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DownLoader : NSObject

- (void)downLoadWithURL: (NSURL *)url  progress:(void(^)(CGFloat progress))downloadprogress      success:(void(^)(NSString*savePath))successBlock  fail:(void(^)(NSError *error))faiilBlock;
- (void)pause;
@end

NS_ASSUME_NONNULL_END
