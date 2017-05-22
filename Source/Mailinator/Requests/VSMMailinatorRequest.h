//
//  VSMMailinatorRequest.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMHTTPJSONRequest.h"
#import "VSMHTTPRequestContext.h"

@interface VSMMailinatorRequest : VSMHTTPJSONRequest

@property (nonatomic, strong, readonly) NSString * __nullable token;

- (instancetype __nonnull)initWithContext:(VSMHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSMHTTPRequestContext * __nonnull)context NS_UNAVAILABLE;

@end
