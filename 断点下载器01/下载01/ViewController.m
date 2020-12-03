//
//  ViewController.m
//  下载01
//
//  Created by 韩李涛 on 2020/12/2.
//

#import "ViewController.h"
#import "DownLoadManger.h"
@interface ViewController ()

@end

@implementation ViewController
//完成：
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *begin = [[UIButton alloc]init];
    [self.view addSubview:begin];
    begin.backgroundColor = [UIColor redColor];
    begin.frame = CGRectMake(100, 100, 100, 40);
    [begin setTitle:@"开始下载" forState:UIControlStateNormal];
    [begin addTarget:self action:@selector(begindownload) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *end= [[UIButton alloc]init];
    [self.view addSubview:end];
    end.backgroundColor = [UIColor redColor];
    end.frame = CGRectMake(100, 180, 100, 40);
    [end setTitle:@"暂停下载" forState:UIControlStateNormal];
    
    [end addTarget:self action:@selector(pausedownload) forControlEvents:UIControlEventTouchUpInside];

}

- (void)begindownload{
    
//    [[DownLoadManger shareInstance]downLoadWithURL:[NSURL URLWithString:@"https://softforspeed.51xiazai.cn/down/1__3112605__3f7372633d6c6d266c733d6e35646135366261623964__68616f2e3336302e636e__0cf9.exe"] progress:^(CGFloat progress) {
//        NSLog(@"%f",progress);
//        } completed:^(BOOL suceess) {
//            //NSLog(@"%d",suceess);
//        }];
//
    
    [[DownLoadManger shareInstance]downLoadWithURL:[NSURL URLWithString:@"https://softforspeed.51xiazai.cn/down/1__3112605__3f7372633d6c6d266c733d6e35646135366261623964__68616f2e3336302e636e__0cf9.exe"] progress:^(CGFloat progress) {
        
    } success:^(NSString * _Nonnull savePath) {
        NSLog(@"%@",savePath);
    } fail:^(NSError * _Nonnull error) {

        
    }];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
//    [[DownLoadManger shareInstance]downLoadWithURL:[NSURL URLWithString:@"http://audio.xmcdn.com/group23/M06/5C/70/wKgJL1g0DVahoMhrAMJMkvfN17c025.m4a"]];
//
//
//
//
//    [[DownLoadManger shareInstance]downLoadWithURL:[NSURL URLWithString:@"https://softforspeed.51xiazai.cn/down/1__3112605__3f7372633d6c6d266c733d6e35646135366261623964__68616f2e3336302e636e__0cf9.exe"]];
    
}

- (void)pausedownload{
    [[DownLoadManger shareInstance]pauseWithURL:[NSURL URLWithString:@"https://softforspeed.51xiazai.cn/down/1__3112605__3f7372633d6c6d266c733d6e35646135366261623964__68616f2e3336302e636e__0cf9.exe"]];
}
@end
