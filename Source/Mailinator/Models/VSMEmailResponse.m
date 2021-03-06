//
//  VSMEmailResponse.m
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMEmailResponse.h"

#import "NSObject+VSMUtils.h"

static NSString *const kMERApiInboxFetchesLeft = @"apiInboxFetchesLeft";
static NSString *const kMERApiEmailFetchesLeft = @"apiEmailFetchesLeft";
static NSString *const kMERData = @"data";
static NSString *const kMERForwardsLeft = @"forwardsLeft";

@interface VSMEmailResponse ()

@property (nonatomic, strong, readwrite) NSNumber * __nonnull apiInboxFetchesLeft;
@property (nonatomic, strong, readwrite) NSNumber * __nonnull apiEmailFetchesLeft;
@property (nonatomic, strong, readwrite) VSMEmail * __nonnull email;
@property (nonatomic, strong, readwrite) NSNumber * __nonnull forwardsLeft;

@end

@implementation VSMEmailResponse

@synthesize apiInboxFetchesLeft = _apiInboxFetchesLeft;
@synthesize apiEmailFetchesLeft = _apiEmailFetchesLeft;
@synthesize email = _email;
@synthesize forwardsLeft = _forwardsLeft;

#pragma mark - Lifecycle

- (instancetype)initWithInboxFetchesLeft:(NSNumber *)inboxFetchesLeft emailFetchesLeft:(NSNumber *)emailFetchesLeft email:(VSMEmail *)email forwardsLeft:(NSNumber *)forwardsLeft {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _apiInboxFetchesLeft = inboxFetchesLeft;
    _apiEmailFetchesLeft = emailFetchesLeft;
    _email = email;
    _forwardsLeft = forwardsLeft;
    return self;
}

- (instancetype)init {
    return [self initWithInboxFetchesLeft:@0 emailFetchesLeft:@0 email:[[VSMEmail alloc] init] forwardsLeft:@0];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self initWithInboxFetchesLeft:self.apiInboxFetchesLeft emailFetchesLeft:self.apiEmailFetchesLeft email:self.email forwardsLeft:self.forwardsLeft];
}

#pragma mark - VFSerializable

+ (instancetype) deserializeFrom:(NSDictionary *)candidate {
    NSNumber *inboxFetchesLeft = [candidate[kMERApiInboxFetchesLeft] vsm_as:[NSNumber class]];
    NSNumber *emailFetchesLeft = [candidate[kMERApiEmailFetchesLeft] vsm_as:[NSNumber class]];
    NSDictionary *emailCandidate = [candidate[kMERData] vsm_as:[NSDictionary class]];
    VSMEmail *email = [VSMEmail deserializeFrom:emailCandidate];
    NSNumber *forwardsLeft = [candidate[kMERForwardsLeft] vsm_as:[NSNumber class]];
    
    return [[self alloc] initWithInboxFetchesLeft:inboxFetchesLeft emailFetchesLeft:emailFetchesLeft email:email forwardsLeft:forwardsLeft];
}

@end
