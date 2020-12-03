//
//  LocalFileTool.m
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import "LocalFileTool.h"

@implementation LocalFileTool
+ (BOOL)isFileExists: (NSString *)path {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}
+ (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL{
    return [[NSFileManager defaultManager]moveItemAtURL:srcURL toURL:dstURL error:nil];
}

+ (void)removeFileAtPath: (NSString *)path {
    
    if (![self isFileExists:path]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
}
@end
