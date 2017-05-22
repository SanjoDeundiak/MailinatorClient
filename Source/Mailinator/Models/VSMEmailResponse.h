//
//  VSMEmailResponse.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMEmail.h"

@interface VSMEmailResponse : NSObject

@property (nonatomic, strong, readonly) NSNumber * __nonnull apiInboxFetchesLeft;
@property (nonatomic, strong, readonly) NSNumber * __nonnull apiEmailFetchesLeft;
@property (nonatomic, strong, readonly) VSMEmail * __nonnull email;
@property (nonatomic, strong, readonly) NSNumber * __nonnull forwardsLeft;

+ (instancetype __nonnull) deserializeFrom:(NSDictionary * __nonnull)candidate;

- (instancetype __nonnull)initWithInboxFetchesLeft:(NSNumber * __nonnull )inboxFetchesLeft emailFetchesLeft:(NSNumber * __nonnull )emailFetchesLeft email:(VSMEmail * __nonnull )email forwardsLeft:(NSNumber * __nonnull )forwardsLeft NS_DESIGNATED_INITIALIZER;

@end
