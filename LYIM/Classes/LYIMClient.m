//
//  LYIMClient.m
//  LYIM_Example
//
//  Created by 刘洋 on 2019/5/27.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYIMClient.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface LYIMClient ()<GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *socket;

@property (nonatomic,assign) BOOL isConnect;

@property (nonatomic,strong) NSTimer* conectTimer;

@end

@implementation LYIMClient

#pragma mark - 懒加载
- (GCDAsyncSocket *)socket {
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _socket;
}

+ (instancetype)sharedManager {
    static LYIMClient *_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[LYIMClient alloc] init];
    });
    return _singleton;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setClientHost:(NSString *)host AndPort:(NSString *)port{
    [self.socket connectToHost:host onPort:[port integerValue] error:NULL];
}


-(void)sendMessage:(NSString *)message{
    NSData * data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:0];
}

//添加定时器
-(void)addTimer{
    self.conectTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(socketCheckoutTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.conectTimer forMode:NSRunLoopCommonModes];
}

- (void)socketCheckoutTimer:(id)sender{
    NSLog(@"定时器");
    if (!self.isConnect) {
        //重新链接
        
    }
}

#pragma mark --- GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"链接成功");
    //链接成功开启定时器
    [self addTimer];
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:0];
    self.isConnect = YES;
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接受到数据-----------%@",str);
    [self.socket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
   
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err{
    NSLog(@"断开链接");
    self.socket.delegate = nil;
    self.socket = nil;
    self.isConnect = NO;
    //j定时器停止
    [self.conectTimer invalidate];
}

@end
