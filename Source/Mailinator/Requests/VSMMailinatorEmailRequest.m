//
//  VSMMailinatorEmailRequest.m
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMMailinatorEmailRequest.h"
#import "VSMEmail.h"
#import "VSMEmailResponse.h"
#import "NSObject+VSMUtils.h"

@interface VSMMailinatorEmailRequest ()

@property (nonatomic, strong, readwrite) VSMEmail * __nullable email;
@property (nonatomic, strong) NSString * __nonnull emailId;

@end

@implementation VSMMailinatorEmailRequest

#pragma mark - Lifecycle

- (instancetype)initWithContext:(VSMHTTPRequestContext *)context token:(NSString *)token emailId:(NSString *)emailId {
    self = [super initWithContext:context token:token];
    if (self == nil) {
        return nil;
    }
    _emailId = emailId;
    
    [self setRequestMethod:GET];
    return self;
}

#pragma mark - Overrides

- (NSString *)methodPath {
    NSString *token = self.token;
    if (token == nil) {
        return nil;
    }
    return [NSString stringWithFormat:@"email?id=%@&token=%@", self.emailId, token];
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    NSDictionary *emailCandidate = [candidate vsm_as:[NSDictionary class]];
    VSMEmailResponse *response = [VSMEmailResponse deserializeFrom:emailCandidate];
    self.email = response.email;
    
    return nil;
}

@end
