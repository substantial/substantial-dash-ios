//
//  DXRRootViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-08.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRRootViewController.h"
#import "DXRLoginViewController.h"
#import "DXRLogin.h"

@interface DXRRootViewController ()
@property (strong, nonatomic) UIViewController *loginViewController;
@property (strong, nonatomic) UIViewController *mainViewController;
@end

@implementation DXRRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self setupLoginSignal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)displayLoginController;
{
    if (!self.loginViewController) {
        self.loginViewController = [[DXRLoginViewController alloc] init];
    }
    [self addChildViewController:self.loginViewController];
    self.loginViewController.view.frame = self.view.frame;
    [self.view addSubview:self.loginViewController.view];
    [self.loginViewController didMoveToParentViewController:self];
}

- (void)displayMainController;
{
    if (!self.mainViewController) {
        self.mainViewController = [[UIViewController alloc] init];
    }
    [self.mainViewController.view setBackgroundColor:[UIColor colorWithRed:1 green:0.6 blue:0 alpha:1]];
    [self addChildViewController:self.mainViewController];
    self.mainViewController.view.frame = self.view.frame;
    [self.view addSubview:self.mainViewController.view];
    [self.mainViewController didMoveToParentViewController:self];
}

- (void)setupLoginSignal
{
    DXRLogin *login = [DXRLogin instance];
    __weak id weakSelf = self;
    [login.apiKeyChanged subscribeNext:^(id apiKey) {
        id strongSelf = weakSelf;
        if (apiKey) {
            NSLog(@"API key changed to %@", apiKey);
            [strongSelf displayMainController];
        } else {
            NSLog(@"API key removed");
            [strongSelf displayLoginController];
        }
    }];
}

- (void)dealloc
{
    self.loginViewController = nil;
}

@end
