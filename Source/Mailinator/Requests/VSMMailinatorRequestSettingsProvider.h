//
//  VSMMailinatorRequestSettingsProvider.h
//
//  Created by Pavel Gorb on 9/23/15.
//  Copyright (c) 2015 VirgilSecurity. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VSMMailinatorRequestSettingsProvider <NSObject>

@required
- (NSString*) mailinatorToken;

@end
