//
//  YSDeviceToken.m
//  Bus Notifier
//
//  Created by Wooseong Kim on 2014. 4. 14..
//  Copyright (c) 2014년 Yooii Studios. All rights reserved.
//

#import "YSDeviceToken.h"

@implementation YSDeviceToken

+ (void)initWithDeviceToken:(NSData *)deviceToken {
    YSDeviceToken *sharedDeviceToken = [YSDeviceToken sharedDeviceToken];
    sharedDeviceToken.deviceToken = deviceToken;
}

+ (YSDeviceToken *)sharedDeviceToken {
    static YSDeviceToken *instance;
    
    if (instance == nil) {
        @synchronized(self) {
            if (instance == nil) {
                instance = [[self alloc] init];
            }
        }
    }
    return instance;
}

@end
