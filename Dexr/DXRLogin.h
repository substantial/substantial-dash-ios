//
//  DXRLoginStream.h
//  Dexr
//
//  Created by Mars Hall on 2014-10-06.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DXRLogin : NSObject

@property (copy) NSString *apiKey;
@property (strong, nonatomic) RACSignal *apiKeyChanged;
@property (copy) NSString *userName;

+ (instancetype)instance;

@end
