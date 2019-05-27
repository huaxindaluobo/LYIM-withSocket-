//
//  LYIMServer.h
//  LYIM_Example
//
//  Created by 刘洋 on 2019/5/27.
//  Copyright © 2019 萝卜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYIMServer : NSObject

+ (instancetype)sharedManager;

-(void)setAcceptPort:(NSString *)port;

@end

NS_ASSUME_NONNULL_END
