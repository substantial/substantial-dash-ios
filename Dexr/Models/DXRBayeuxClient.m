//
//  DXRBayeuxClient.m
//  Dexr
//
//  Created by Mars Hall on 2014-10-13.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRBayeuxClient.h"
#import "DXREnvironment.h"
#import "DXRLogin.h"

static NSString *const DXRBayeuxBaseUrlFormat = @"%@/bayeux";
static NSString *const DXRBayeuxExtApiKeyName = @"apiKey";

@interface DXRBayeuxClient ()
@property (strong, nonatomic) MZFayeClient *faye;
@property (strong, nonatomic) DXREnvironment *env;
@property (strong, nonatomic) DXRLogin *login;
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
        [self setupFaye];
    }
    return self;
}

- (NSURL *)baseUrl
{
    NSString *url = [NSString stringWithFormat:DXRBayeuxBaseUrlFormat, _env.baseUrl];
    return [NSURL URLWithString:url];
}

- (void)subscribeToChannel:(NSString *)channel
{
    [_faye setExtension:@{ DXRBayeuxExtApiKeyName:_login.apiKey } forChannel:channel];
    [_faye subscribeToChannel:channel];
}

- (void)unsubscribeFromChannel:(NSString *)channel
{
    [_faye unsubscribeFromChannel:channel];
    [_faye removeExtensionForChannel:channel];
}

#pragma mark - Private

- (void)setupFaye
{
    _env = [DXREnvironment instance];
    _login = [DXRLogin instance];
    _faye = [MZFayeClient clientWithURL:[self baseUrl]];
    _faye.delegate = self;
}

@end
