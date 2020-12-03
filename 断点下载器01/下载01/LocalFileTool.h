//
//  LocalFileTool.h
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalFileTool : NSObject
+ (BOOL)isFileExists: (NSString *)path;
+(BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL;
+ (void)removeFileAtPath: (NSString *)path;

@end

NS_ASSUME_NONNULL_END
