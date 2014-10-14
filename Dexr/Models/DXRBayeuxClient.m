//
//  DXRBayeuxClient.m
//  Dexr
//
//  Created by Mars Hall on 2014-10-13.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRBayeuxClient.h"
#import "DXREnvironment.h"

static NSString *const DXRBayeuxBaseUrlFormat = @"%@/bayeux";

@interface DXRBayeuxClient ()
@property (strong, nonatomic) MZFayeClient *faye;
@property (strong, nonatomic) DXREnvironment *env;
@end

@implementation DXRBayeuxClient

+ (instancetype)instance
{
    static dispatch_once_t once;
    static DXRBayeuxClient *instance;
    dispatch_once(&once, ^ { instance = [[self alloc] init]; });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _env = [DXREnvironment instance];
        _faye = [[MZFayeClient alloc] initWithURL:[self baseUrl]];
    }
    return self;
}

- (NSURL *)baseUrl
{
    NSString *url = [NSString stringWithFormat:DXRBayeuxBaseUrlFormat, _env.baseUrl];
    return [NSURL URLWithString:url];
}

@end
