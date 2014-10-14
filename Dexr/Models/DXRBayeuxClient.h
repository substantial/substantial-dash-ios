//
//  DXRBayeuxClient.h
//  Dexr
//
//  Created by Mars Hall on 2014-10-13.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import <MZFayeClient/MZFayeClient.h>

@interface DXRBayeuxClient : NSObject <MZFayeClientDelegate>

+ (instancetype)instance;

@property (strong, readonly, nonatomic) MZFayeClient *faye;

- (NSURL *)baseUrl;

@end
