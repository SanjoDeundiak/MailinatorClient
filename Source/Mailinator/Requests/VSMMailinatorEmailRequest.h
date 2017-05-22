//
//  VSMMailinatorEmailRequest.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMMailinatorRequest.h"
#import "VSSHTTPRequestContext.h"
#import "VSMEmail.h"

@interface VSMMailinatorEmailRequest : VSMMailinatorRequest

@property (nonatomic, strong, readonly) VSMEmail * __nullable email;

- (instancetype __nonnull)initWithContext:(VSSHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token emailId:(NSString * __nonnull)emailId NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSSHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token NS_UNAVAILABLE;

@end
