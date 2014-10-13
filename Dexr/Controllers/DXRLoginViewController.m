//
//  DXRLoginViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-16.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRLoginViewController.h"
#import "UIViewController+WebViewLogin.h"

@interface DXRLoginViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation DXRLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self loadLoginWithWebView:self.webView];
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
    self.webView = nil;
}

@end
