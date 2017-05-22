//
//  VSMEmail.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMEmailMetadata.h"
#import "VSMPart.h"

@interface VSMEmail : NSObject

@property (nonatomic, strong, readonly) VSMEmailMetadata * __nonnull metadata;
@property (nonatomic, strong, readonly) NSDictionary * __nonnull headers;
@property (nonatomic, strong, readonly) NSArray <VSMPart *>* __nonnull parts;

+ (instancetype __nonnull) deserializeFrom:(NSDictionary * __nonnull)candidate;

- (instancetype __nonnull)initWithMetadata:(VSMEmailMetadata * __nonnull )metadata headers:(NSDictionary * __nonnull )headers parts:(NSArray <VSMPart *>* __nonnull )parts NS_DESIGNATED_INITIALIZER;

@end
