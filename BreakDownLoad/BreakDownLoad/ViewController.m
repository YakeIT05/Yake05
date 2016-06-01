//
//  ViewController.m
//  BreakDownLoad
//
//  Created by student on 16/3/17.
//  Copyright © 2016年 Tom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate> {
    long long _receviceLength;//用来保存已经下载好的长度
    long long _totalLength;//用来保存要下载文件的总长度
}
@property (nonatomic ,retain)NSFileHandle *fileHandle;
@property(nonatomic ,retain)NSURLConnection *connection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFileManager *mager = [NSFileManager defaultManager];
    if (![mager fileExistsAtPath:[self getPath]]) {
        [mager createFileAtPath:[self getPath] contents:nil attributes:nil];
    }
    if (_fileHandle == nil) {
        self.fileHandle  =[NSFileHandle fileHandleForWritingAtPath:[self getPath]];
    }
}
- (NSString *)getPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xin.dmg"];
}
- (IBAction)downButton:(UIButton *)sender {
    NSString *urlStr = @"http://dlsw.baidu.com/sw-search-sp/soft/90/25706/QQMusic_3.1.1.2_mac.1457491013.dmg";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"GET"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self getPath]]) {
        //这个方法是取出来你输入的路径下的文件的属性。
        NSDictionary *dic =  [manager attributesOfItemAtPath:[self getPath] error:nil];
     _receviceLength= [dic[NSFileSize]longLongValue];
    }
    NSString *rangeStr = [NSString stringWithFormat:@"bytes=%qu-",_receviceLength];
    //告诉服务器要从那个字节传数据给我们
    
    [request setValue:rangeStr forHTTPHeaderField:@"renge"];
  self.connection=  [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
}
- (IBAction)pullOnButttonClick:(UIButton *)sender {
    //取消连接
    [_connection cancel];
    
    
    
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response {
    //response.expectedContentLength这个属性是未下载文件的长度
    _totalLength =_receviceLength+ response.expectedContentLength;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data {
    _receviceLength = _receviceLength+data.length;
    _progress.progress = (CGFloat)_receviceLength/_totalLength;
    _labelText.text = [NSString stringWithFormat:@"%.f%%",_progress.progress*100];
    [_fileHandle seekToEndOfFile];
    [_fileHandle writeData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%@",[self getPath]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_progress release];
    [_labelText release];
    [super dealloc];
}
@end
