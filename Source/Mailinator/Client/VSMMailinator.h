//
//  VSMMailinator.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMEmail.h"
#import "VSMEmailMetadata.h"

@interface VSMMailinator : NSObject

@property (nonatomic, copy, readonly) NSURL * __nonnull serviceUrl;
@property (nonatomic, copy, readonly) NSString * __nonnull token;

- (instancetype __nonnull)initWithApplicationToken:(NSString * __nonnull)token serviceUrl:(NSURL * __nonnull)serviceUrl;

- (void)getInbox:(NSString * __nonnull)name completionHandler:(void(^ __nullable)(NSArray<VSMEmailMetadata *> * __nullable metadataList, NSError * __nullable error))completionHandler;
- (void)getEmail:(NSString * __nonnull)emailId completionHandler:(void(^ __nullable)(VSMEmail * __nullable email, NSError * __nullable error))completionHandler;

@end
