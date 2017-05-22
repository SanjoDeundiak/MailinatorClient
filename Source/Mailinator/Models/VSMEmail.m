//
//  VSMEmail.m
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMEmail.h"
#import "VSMEmailMetadata.h"
#import "VSMPart.h"

#import "NSObject+VSSUtils.h"

static NSString *const kMEMetadata = @"metadata";
static NSString *const kMEHeaders = @"headers";
static NSString *const kMEParts = @"parts";

@interface VSMEmail ()

@property (nonatomic, strong, readwrite) VSMEmailMetadata * __nonnull metadata;
@property (nonatomic, strong, readwrite) NSDictionary * __nonnull headers;
@property (nonatomic, strong, readwrite) NSArray * __nonnull parts;

@end

@implementation VSMEmail

@synthesize metadata = _metadata;
@synthesize headers = _headers;
@synthesize parts = _parts;

#pragma mark - Lifecycle

- (instancetype)initWithMetadata:(VSMEmailMetadata *)metadata headers:(NSDictionary *)headers parts:(NSArray <VSMPart *>*)parts {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    _metadata = metadata;
    _headers = headers;
    _parts = parts;
    return self;
}

- (instancetype)init {
    return [self initWithMetadata:[[VSMEmailMetadata alloc] init] headers:@{} parts:@[]];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self initWithMetadata:[self.metadata copy] headers:[self.headers copy] parts:[self.parts copy]];
}

#pragma mark - VFSerializable

+ (instancetype)deserializeFrom:(NSDictionary *)candidate {
    VSMEmailMetadata *metadata = [VSMEmailMetadata deserializeFrom:candidate];
    NSDictionary *headers = [candidate[kMEHeaders] vss_as:[NSDictionary class]];

    NSArray *partsCandidates = [candidate[kMEParts] vss_as:[NSArray class]];
    NSMutableArray *parts = [[NSMutableArray alloc] initWithCapacity:[partsCandidates count]];
    for (NSDictionary *partCandidate in partsCandidates) {
        VSMPart *part = [VSMPart deserializeFrom:partCandidate];
        if (part != nil) {
            [parts addObject:part];
        }
    }
    
    return [[self alloc] initWithMetadata:metadata headers:headers parts:parts];
}

@end
