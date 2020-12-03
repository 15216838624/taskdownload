

#import "DownLoadManger.h"
#import "NSString+UrlString.h"
#import "DownLoader.h"
@interface DownLoadManger()

@property (nonatomic, strong) NSMutableDictionary <NSString *,DownLoader *>*downLoadInfo;
@end
@implementation DownLoadManger
static DownLoadManger  *_shareInstance;
+ (instancetype)shareInstance {
    
    if (!_shareInstance) {
        _shareInstance = [[DownLoadManger alloc] init];
    }
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!_shareInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _shareInstance = [super allocWithZone:zone];
        });
    }
    return _shareInstance;
}

- (NSMutableDictionary *)downLoadInfo {
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}

- (void)downLoadWithURL: (NSURL *)url  progress:(void(^)(CGFloat progress))downloadprogress      completed:(void(^)(BOOL suceess))downLoadcompleted{
    NSString *md5 = [url.absoluteString md5Str];
    DownLoader *downLoader = self.downLoadInfo[md5];
    if (downLoader==nil) {
        downLoader = [[DownLoader alloc]init];
    }
    [downLoader downLoadWithURL:url progress:downloadprogress completed:downLoadcompleted];
    [self.downLoadInfo setValue:downLoader forKey:md5];
}

- (void)pauseWithURL: (NSURL *)url{
    NSString *md5 = [url.absoluteString md5Str];
    DownLoader *downLoader = self.downLoadInfo[md5];
    [downLoader pause];
}

@end
