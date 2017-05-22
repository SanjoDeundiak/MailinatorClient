//
//  MailinatorRequest.m
//  VirgilKeys
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "MailinatorRequest.h"
#import "MailinatorRequestSettingsProvider.h"
#import "NSObject+VSSUtils.h"
#import "VSSHTTPRequestContext.h"

@implementation MailinatorRequest

- (instancetype)initWithContext:(VSSHTTPRequestContext *)context token:(NSString *)token {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    _token = token;
    
    return self;
}

- (NSError *)handleError:(NSObject *)candidate code:(NSInteger)code {
    NSError *error = [super handleError:candidate code:code];
    if (error != nil) {
        return error;
    }
    
    return nil;
}

@end
