//
//  DXRLoginViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-16.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRLoginViewController.h"
#import "DXREnvironment.h"

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

    DXREnvironment *env = [DXREnvironment sharedInstance];
    NSString *baseUrlString = [[env baseUrl] absoluteString];
    NSString *urlString =  [NSString stringWithFormat:@"%@/auth/google_apps/init", baseUrlString];

    NSURL *loginUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *loginRequest = [NSMutableURLRequest requestWithURL:loginUrl];

    NSString *referer =  [NSString stringWithFormat:@"%@/-client/ios/login", baseUrlString];
    [loginRequest addValue:referer forHTTPHeaderField:@"Referer"];

    NSLog(@"Initiating authentication...");
    [self.webView loadRequest:loginRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"webView:shouldStartLoadWithRequest:navigationType");
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError: %@", error);
}

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

- (void)dealloc
{
    self.webView.delegate = nil;
}

@end
