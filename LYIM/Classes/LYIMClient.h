//
//  LYIMClient.h
//  LYIM_Example
//
//  Created by 刘洋 on 2019/5/27.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYIMClient : NSObject

+ (instancetype)sharedManager;

-(void)setClientHost:(NSString *)host AndPort:(NSString *)port;

-(void)sendMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
