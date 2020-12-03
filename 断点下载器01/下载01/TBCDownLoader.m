//
//  TBCDownLoader.m
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import "TBCDownLoader.h"

@implementation TBCDownLoader
+ (void)downLoader:(NSURL *)url{
    //1.下载ing->temp + 名称  完成：cache + 名称
    // MD5 + URL 防止重复资源
    //1、判断,url地址，对应的资源，是否下载完毕  1.1
    NSString *cath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}
@end
