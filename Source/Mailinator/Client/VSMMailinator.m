//
//  VSMMailinator.m
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import "VSMMailinator.h"
#import "VSMEmail.h"

#import "VSMMailinatorInboxRequest.h"
#import "VSMMailinatorEmailRequest.h"
#import "VSMHTTPRequest.h"
#import "VSMHTTPRequest.h"

#import "NSObject+VSMUtils.h"

static NSString *const kMailinatorErrorDomain = @"MailinatorErrorDomain";

@interface VSMMailinator ()

@property (nonatomic) NSOperationQueue * __nonnull queue;
@property (nonatomic) NSURLSession * __nonnull urlSession;

@end

@implementation VSMMailinator

- (instancetype)initWithApplicationToken:(NSString *)token serviceUrl:(NSURL *)serviceUrl {
    self = [super init];
    
    if (self) {
        _token = [token copy];
        _serviceUrl = [serviceUrl copy];
        
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 10;
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:_queue];
    }
    
    return self;
}

#pragma mark - Overrides

- (void)getInbox:(NSString *)name completionHandler:(void(^)(NSArray<VSMEmailMetadata *> *metadataList, NSError *error))completionHandler {
    if (name == nil) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kMailinatorErrorDomain code:-100 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Request for the inbox data can not be sent. Inbox name is not set.", @"GetInbox") }]);
            });
        }
        return;
    }
    
    VSMHTTPRequestCompletionHandler handler = ^(VSMHTTPRequest *request) {
        if (request.error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, request.error);
            }
            return;
        }
        
        if (completionHandler != nil) {
            VSMMailinatorInboxRequest *mrequest = [request vsm_as:[VSMMailinatorInboxRequest class]];
            if (mrequest.metadataList == nil) {
                completionHandler(nil, [NSError errorWithDomain:kMailinatorErrorDomain code:-103 userInfo:@{ NSLocalizedDescriptionKey: @"Error parsing response" }]);
                return;
            }
            completionHandler(mrequest.metadataList, nil);
        }
    };
    
    VSMHTTPRequestContext *context = [[VSMHTTPRequestContext alloc] initWithServiceUrl:self.serviceUrl];
    VSMMailinatorInboxRequest *request = [[VSMMailinatorInboxRequest alloc] initWithContext:context token:self.token to:name];
    request.completionHandler = handler;
    [self send:request];
}

- (void)getEmail:(NSString *)emailId completionHandler:(void(^)(VSMEmail *email, NSError *error))completionHandler {
    if (emailId == nil) {
        if (completionHandler != nil) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                completionHandler(nil, [NSError errorWithDomain:kMailinatorErrorDomain code:-102 userInfo:@{ NSLocalizedDescriptionKey: NSLocalizedString(@"Request for the email data can not be sent. Email id is not set.", @"GetEmail") }]);
            });
        }
        return;
    }
    
    VSMHTTPRequestCompletionHandler handler = ^(VSMHTTPRequest *request) {
        if (request.error != nil) {
            if (completionHandler != nil) {
                completionHandler(nil, request.error);
            }
            return;
        }
        
        if (completionHandler != nil) {
            VSMMailinatorEmailRequest *mrequest = [request vsm_as:[VSMMailinatorEmailRequest class]];
            if (mrequest.email == nil) {
                completionHandler(nil, [NSError errorWithDomain:kMailinatorErrorDomain code:-103 userInfo:@{ NSLocalizedDescriptionKey: @"Error parsing response" }]);
                return;
            }
            completionHandler(mrequest.email, nil);
        }
    };
    
    VSMHTTPRequestContext *context = [[VSMHTTPRequestContext alloc] initWithServiceUrl:self.serviceUrl];
    VSMMailinatorEmailRequest *request = [[VSMMailinatorEmailRequest alloc] initWithContext:context token:self.token emailId:emailId];
    request.completionHandler = handler;
    [self send:request];
}

- (void)send:(VSMHTTPRequest *)request {
    if (request == nil) {
        return;
    }
    
#if USE_SERVICE_REQUEST_DEBUG
    {
        VSMRDLog(@"%@: request URL: %@", NSStringFromClass(request.class), request.request.URL);
        VSMRDLog(@"%@: request method: %@", NSStringFromClass(request.class), request.request.HTTPMethod);
        if (request.request.HTTPBody.length) {
            NSString *logStr = [[NSString alloc] initWithData:request.request.HTTPBody encoding:NSUTF8StringEncoding];
            VSMRDLog(@"%@: request body: %@", NSStringFromClass(request.class), logStr);
        }
        VSMRDLog(@"%@: request headers: %@", NSStringFromClass(request.class), request.request.allHTTPHeaderFields);
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        NSArray *cookies = [cookieStorage cookiesForURL:request.request.URL];
        for (NSHTTPCookie *cookie in cookies) {
            VSMRDLog(@"*******COOKIE: %@: %@", [cookie name], [cookie value]);
        }
    }
#endif
    
    NSURLSessionDataTask *task = [request taskForSession:self.urlSession];
    [task resume];
}

@end
