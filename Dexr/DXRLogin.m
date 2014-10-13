//
//  DXRLoginStream.m
//  Dexr
//
//  Created by Mars Hall on 2014-10-06.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRLogin.h"

@implementation DXRLogin

+ (instancetype)instance
{
    static dispatch_once_t once;
    static DXRLogin *instance;
    dispatch_once(&once, ^ { instance = [[self alloc] init]; });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupStreams];
    }
    return self;
}

- (void)logout
{
    self.apiKey = nil;
    self.userName = nil;
}

#pragma mark - private

- (void)setupStreams
{
    self.apiKeyChanged = RACObserve(self, apiKey);
    self.userNameChanged = RACObserve(self, userName);
}

@end
