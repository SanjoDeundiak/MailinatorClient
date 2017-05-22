//
//  VSMEmailMetadata.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSMEmailMetadata : NSObject

@property (nonatomic, strong, readonly) NSNumber * __nonnull seconds_ago;
@property (nonatomic, strong, readonly) NSString * __nonnull mid;
@property (nonatomic, strong, readonly) NSString * __nonnull to;
@property (nonatomic, strong, readonly) NSNumber * __nonnull time;
@property (nonatomic, strong, readonly) NSString * __nonnull subject;
@property (nonatomic, strong, readonly) NSString * __nonnull fromfull;
@property (nonatomic, strong, readonly) NSNumber * __nonnull been_read;
@property (nonatomic, strong, readonly) NSString * __nonnull from;
@property (nonatomic, strong, readonly) NSString * __nonnull ip;

+ (instancetype __nonnull) deserializeFrom:(NSDictionary * __nonnull)candidate;

- (instancetype __nonnull)initWithMid:(NSString * __nonnull)mid subject:(NSString * __nonnull)subject from:(NSString * __nonnull)from to:(NSString * __nonnull)to time:(NSNumber * __nonnull)time beenRead:(NSNumber * __nonnull)beenRead fromfull:(NSString * __nonnull)fromfull secondsAgo:(NSNumber * __nonnull)secondsAgo ip:(NSString * __nonnull)ip NS_DESIGNATED_INITIALIZER;

@end
