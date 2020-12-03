//
//  DownLoader.m
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import "DownLoader.h"
#import "LocalFileTool.h"
#import "NSString+UrlString.h"
#define kCache NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()
@interface DownLoader()<NSURLSessionDelegate>
@property(nonatomic,strong)NSURLSessionDownloadTask * downLoadTask;
@property(nonatomic,strong)NSData *resumeData;
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong) void(^downloadProgress)(CGFloat downloadProgress);
@property(nonatomic,strong) void(^downloadsuccess)(NSString*savePath);
/** 文件的缓存路径 */
@property (nonatomic, copy) NSString *cacheFilePath;
/** 文件的临时缓存路径 */
@property (nonatomic, copy) NSString *tmpFilePath;
@end
@implementation DownLoader
- (NSURLSession *)session{
    if (_session==nil) {
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue new]];
        _session =session;
    }
    return _session;
}

- (NSData *)resumeData{
    if (_resumeData==nil) {
        _resumeData = [NSData dataWithContentsOfFile:self.tmpFilePath];
    }
    return _resumeData;
}
              

- (void)downLoadWithURL: (NSURL *)url  progress:(void(^)(CGFloat progress))downloadprogress      success:(void(^)(NSString*savePath))successBlock  fail:(void(^)(NSError *error))faiilBlock{
    self.downloadProgress = downloadprogress;
    self.downloadsuccess = successBlock;
    NSString *fileName = [[url.absoluteString md5Str]stringByAppendingPathExtension:url.pathExtension];
    self.cacheFilePath = [kCache stringByAppendingPathComponent:fileName];
    if ([LocalFileTool isFileExists:self.cacheFilePath]) {
        //NSLog(@"已下载:%@",self.cacheFilePath);
        self.downloadsuccess(self.cacheFilePath);
        return;
    }
    self.tmpFilePath = [kTmpPath stringByAppendingPathComponent:fileName];
    if (self.resumeData) {
        [self resume];
    }else{
        NSURLSessionDownloadTask * downLoadTask = [self.session downloadTaskWithURL:url];
        [downLoadTask resume];
        self.downLoadTask = downLoadTask;
    }
}

#pragma mark - 恢复下载
- (void)resume{
    self.downLoadTask =   [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downLoadTask resume];
}



-(void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    NSLog(@"%@下载进度:%f", downloadTask.currentRequest.URL,1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    //self.downloadProgress(1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    self.downloadProgress(progress);
}

-(void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    NSLog(@"恢复下载");
}
-(void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location{
    [LocalFileTool moveItemAtURL:location toURL:[NSURL fileURLWithPath:self.cacheFilePath]];
    NSLog(@"下载完成");
    NSLog(@"%@",self.cacheFilePath);
    [LocalFileTool removeFileAtPath:self.tmpFilePath];
    self.downloadsuccess(self.cacheFilePath);
    //self.downLoadSuccess(self.cacheFilePath);
}

-(void)URLSession:(nonnull NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (error) {
        NSLog(@"%@",error);
        self.resumeData = nil;
        [LocalFileTool removeFileAtPath:self.tmpFilePath];
        //self.downloadsuccess(NO);
    }
}



- (void)pause{
    [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
        [resumeData writeToFile:self.tmpFilePath atomically:YES];
        NSLog(@"%@",resumeData);
    }];
}
@end
