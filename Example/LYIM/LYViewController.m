//
//  LYViewController.m
//  LYIM
//
//  Created by 萝卜 on 05/27/2019.
//  Copyright (c) 2019 萝卜. All rights reserved.
//

#import "LYViewController.h"
#import <LYIM/LYIMClient.h>
#import <LYIM/LYIMServer.h>

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[LYIMClient sharedManager]setClientHost:@"imdev.baihe.com" AndPort:@"6211"];
//    [LYIMServer sharedManager]setAcceptPort:@""
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [[LYIMClient sharedManager]sendMessage:@"nihao"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
