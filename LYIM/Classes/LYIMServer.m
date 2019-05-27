//
//  LYIMServer.m
//  LYIM_Example
//
//  Created by 刘洋 on 2019/5/27.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import "LYIMServer.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface LYIMServer ()<GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *serverSocket;

@property (nonatomic,strong) NSMutableArray *clientSockets;

@end

@implementation LYIMServer

+ (instancetype)sharedManager {
    static LYIMServer  *_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[LYIMServer alloc] init];
    });
    return _singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    }
    return self;
}

-(void)setAcceptPort:(NSString *)port{
    BOOL result = [self.serverSocket acceptOnPort:@"6211".integerValue error:nil];
}


-(void)sendMessage:(NSString *)message{
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSockets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj writeData:data withTimeout:-1 tag:0];
    }];
}


- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{
    [self.clientSockets addObject:newSocket];
    //开启定时器
    NSLog(@"server===链接成功");
    
    [newSocket readDataWithTimeout:- 1 tag:0];
}

@end
