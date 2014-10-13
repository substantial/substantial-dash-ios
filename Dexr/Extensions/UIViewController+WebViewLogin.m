//
//  UIWebView+Login.m
//  Dexr
//
//  Created by Mars Hall on 2014-10-09.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "UIViewController+WebViewLogin.h"
#import "NSURL+QueryDictionary.h"

@implementation UIViewController (WebViewLogin)

- (void)loadLoginWithWebView:(UIWebView *)webView
{
    DXREnvironment *env = [DXREnvironment instance];
    NSString *baseUrlString = [[env baseUrl] absoluteString];
    NSString *urlString =  [NSString stringWithFormat:@"%@/auth/google_apps/init", baseUrlString];

    NSURL *loginUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *loginRequest = [NSMutableURLRequest requestWithURL:loginUrl];

    // Fake referrer used to receive redirect query params.
    NSString *referer =  [NSString stringWithFormat:@"%@%@", baseUrlString, refererIdentifier];
    [loginRequest addValue:referer forHTTPHeaderField:@"Referer"];

    // Prevent previously logged-in authentication from persisting.
    [self clearCookies];

    NSLog(@"Initiating authentication...");
    [webView loadRequest:loginRequest];
}

- (BOOL)detectSuccessfulLoginWithWebView:(UIWebView *)webView fromRedirectURL:(NSURL *)redirectURL;
{
    NSString *urlString = [redirectURL absoluteString];
    NSLog(@"detectSuccessfulLoginFromRedirectURL:%@", urlString);

    if ([urlString containsString:refererIdentifier]) {
        NSDictionary *queryParams = [redirectURL uq_queryDictionary];
        DXRLogin *login = [DXRLogin instance];
        login.apiKey = [self decodeQuerystringParam:queryParams[@"api_key"]];
        login.userName = [self decodeQuerystringParam:queryParams[@"user_name"]];
        NSLog(@"user_name => %@, api_key => %@", login.userName, login.apiKey);

        [self loadAboutBlankWithWebView:webView];
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)decodeQuerystringParam:(NSString *)param
{
    return [[param stringByReplacingOccurrencesOfString:@"+"
                                             withString:@"%20"]  stringByRemovingPercentEncoding];
}

- (void)clearCookies
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadAboutBlankWithWebView:(UIWebView *)webView
{
    NSURL *aboutBlankUrl = [NSURL URLWithString:@"about:blank"];
    NSMutableURLRequest *aboutBlankRequest = [NSMutableURLRequest requestWithURL:aboutBlankUrl];
    [webView loadRequest:aboutBlankRequest];
}

@end
