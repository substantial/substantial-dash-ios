//
//  UIWebView+Login.h
//  Dexr
//
//  Created by Mars Hall on 2014-10-09.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXREnvironment.h"
#import "DXRLogin.h"

static NSString *refererIdentifier = @"/-client/ios/login";

@interface UIViewController (WebViewLogin)

- (void)loadLoginWithWebView:(UIWebView *)webView;
- (BOOL)detectSuccessfulLoginFromRedirectURL:(NSURL *)redirectURL;

@end
