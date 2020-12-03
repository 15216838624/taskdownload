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

- (void)downLoadWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))downloadprogress      completed:(void(^)(BOOL suceess))downLoadcompleted;
- (void)pause;
- (void)resume;
@end

NS_ASSUME_NONNULL_END
