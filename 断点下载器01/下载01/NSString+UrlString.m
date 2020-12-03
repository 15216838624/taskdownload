//
//  NSString+UrlString.m
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import "NSString+UrlString.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (UrlString)
- (NSString *)md5Str{
    const char *data = self.UTF8String;
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data, (CC_LONG)strlen(data), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}
@end
