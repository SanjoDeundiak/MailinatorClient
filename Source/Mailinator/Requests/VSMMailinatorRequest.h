//
//  VSMMailinatorRequest.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSSHTTPJSONRequest.h"
#import "VSSHTTPRequestContext.h"

@protocol VSMMailinatorRequestSettingsProvider;

@interface VSMMailinatorRequest : VSSHTTPJSONRequest

@property (nonatomic, strong, readonly) NSString * __nullable token;

- (instancetype __nonnull)initWithContext:(VSSHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSSHTTPRequestContext * __nonnull)context NS_UNAVAILABLE;

@end
