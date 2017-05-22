//
//  VSMMailinatorInboxRequest.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMMailinatorRequest.h"
#import "VSMHTTPRequestContext.h"
#import "VSMEmailMetadata.h"

@interface VSMMailinatorInboxRequest : VSMMailinatorRequest

@property (nonatomic, strong, readonly) NSArray<VSMEmailMetadata *> * __nullable metadataList;

- (instancetype __nonnull)initWithContext:(VSMHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token to:(NSString * __nonnull)to NS_DESIGNATED_INITIALIZER;

- (instancetype __nonnull)initWithContext:(VSMHTTPRequestContext * __nonnull)context token:(NSString * __nonnull)token NS_UNAVAILABLE;

@end
