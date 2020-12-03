//
//  DownLoadManger.h
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DownLoadManger : NSObject
+ (instancetype)shareInstance;

- (void)downLoadWithURL: (NSURL *)url  progress:(void(^)(CGFloat progress))downloadprogress      completed:(void(^)(BOOL suceess))downLoadcompleted;

- (void)pauseWithURL: (NSURL *)url;

//- (nullable SDWebImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
//                                                   options:(SDWebImageDownloaderOptions)options
//                                                   context:(nullable SDWebImageContext *)context
//                                                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
//                                                 completed:(nullable SDWebImageDownloaderCompletedBlock)completedBloc
@end

NS_ASSUME_NONNULL_END
