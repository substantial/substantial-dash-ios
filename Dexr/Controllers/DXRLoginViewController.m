//
//  DXRLoginViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-16.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRLoginViewController.h"
#import "DXREnvironment.h"
#import "DXRLogin.h"

static NSString *refererIdentifier = @"/-client/ios/login";

@interface DXRLoginViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DXRLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadWebViewLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    NSURL *requestedUrl = [webView.request mainDocumentURL];
//    NSLog(@"webViewDidStartLoad: %@", requestedUrl);
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSLog(@"webViewDidFinishLoad");
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL = [request URL];
    BOOL didLogin = [self detectSuccessfulLoginFromRedirectURL:requestURL];
    return !didLogin;
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    NSLog(@"didFailLoadWithError: %@", error);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private

- (void)loadWebViewLogin
{
    DXREnvironment *env = [DXREnvironment sharedInstance];
    NSString *baseUrlString = [[env baseUrl] absoluteString];
    NSString *urlString =  [NSString stringWithFormat:@"%@/auth/google_apps/init", baseUrlString];

    NSURL *loginUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *loginRequest = [NSMutableURLRequest requestWithURL:loginUrl];

    // Fake referrer used to receive redirect query params.
    NSString *referer =  [NSString stringWithFormat:@"%@%@", baseUrlString, refererIdentifier];
    [loginRequest addValue:referer forHTTPHeaderField:@"Referer"];

    NSLog(@"Initiating authentication...");
    [self.webView loadRequest:loginRequest];
}

- (BOOL)detectSuccessfulLoginFromRedirectURL:(NSURL *)redirectURL
{
    NSString *urlString = [redirectURL absoluteString];
    NSLog(@"detectSuccessfulLoginFromRedirectURL:%@", urlString);

    if ([urlString containsString:refererIdentifier]) {
        NSDictionary *queryParams = [redirectURL uq_queryDictionary];
        DXRLogin *login = [DXRLogin instance];
        login.apiKey = [self decodeQuerystringParam:queryParams[@"api_key"]];
        login.userName = [self decodeQuerystringParam:queryParams[@"user_name"]];
        NSLog(@"user_name => %@, api_key => %@", login.userName, login.apiKey);
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

- (void)dealloc
{
    self.webView.delegate = nil;
}

@end
