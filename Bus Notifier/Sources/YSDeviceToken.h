//
//  YSDeviceToken.h
//  Bus Notifier
//   디바이스 토큰을 저장하기 위한 싱글톤
//
//  Created by Wooseong Kim on 2014. 4. 14..
//  Copyright (c) 2014년 Yooii Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YSDeviceToken : NSObject

+ (void)initWithDeviceToken:(NSData *)deviceToken;
+ (YSDeviceToken *)sharedDeviceToken;

@property (nonatomic, strong) NSData *deviceToken;

@end
