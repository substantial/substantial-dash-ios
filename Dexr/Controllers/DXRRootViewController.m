//
//  DXRRootViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-08.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "CABasicAnimation+NavigationAnimation.h"
#import "DXRLogin.h"
#import "DXRLoginViewController.h"
#import "DXRMainViewController.h"
#import "DXRRootViewController.h"

@interface DXRRootViewController ()
@property (strong, nonatomic) UIViewController *loginViewController;
@property (strong, nonatomic) UIViewController *mainViewController;
@property (strong, nonatomic) UIViewController *currentViewController;
@end

@implementation DXRRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self setupSubviews];
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

- (void)navigateToLogin
{
    if ([self.currentViewController isEqual:self.loginViewController])
        return;
    self.currentViewController = self.loginViewController;

    float frameWidth = self.view.frame.size.width;

    CGFloat originalMainX = self.mainViewController.view.layer.position.x;
    self.mainViewController.view.layer.position = CGPointMake(frameWidth*1.5, self.mainViewController.view.layer.position.y);
    CABasicAnimation *mainAnimation = [CABasicAnimation animatePositionXFromPositionX:@(originalMainX) withDelegate:self];

    self.loginViewController.view.layer.position = CGPointMake(frameWidth/2, self.loginViewController.view.layer.position.y);
    CABasicAnimation *loginAnimation = [CABasicAnimation animatePositionXFromPositionX:@(-frameWidth*0.5) withDelegate:self];

    [self.mainViewController.view.layer addAnimation:mainAnimation forKey:@"mainPosition"];
    [self.loginViewController.view.layer addAnimation:loginAnimation forKey:@"loginPosition"];
}

- (void)navigateToMain
{
    if ([self.currentViewController isEqual:self.mainViewController])
        return;
    self.currentViewController = self.mainViewController;

    float frameWidth = self.view.frame.size.width;

    self.mainViewController.view.layer.position = CGPointMake(frameWidth/2, self.mainViewController.view.layer.position.y);
    CABasicAnimation *mainAnimation = [CABasicAnimation animatePositionXFromPositionX:@(frameWidth*1.5) withDelegate:self];

    CGFloat originalLoginX = self.loginViewController.view.layer.position.x;
    self.loginViewController.view.layer.position = CGPointMake(-frameWidth*0.5, self.loginViewController.view.layer.position.y);
    CABasicAnimation *loginAnimation = [CABasicAnimation animatePositionXFromPositionX:@(originalLoginX) withDelegate:self];

    [self.mainViewController.view.layer addAnimation:mainAnimation forKey:@"queuePosition"];
    [self.loginViewController.view.layer addAnimation:loginAnimation forKey:@"loginPosition"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag)
        return;

    if ([self.currentViewController isEqual:self.mainViewController])
    {
        [self.mainViewController didMoveToParentViewController:self];
    } else {
        [self.loginViewController didMoveToParentViewController:self];
    }
}

- (void)setupSubviews
{
    self.mainViewController = [[DXRMainViewController alloc] init];
    [self addChildViewController:self.mainViewController];
    self.mainViewController.view.frame = self.view.frame;
    [self.view addSubview:self.mainViewController.view];

    // Login is last so that it is initially on top & current.
    self.loginViewController = [[DXRLoginViewController alloc] init];
    [self addChildViewController:self.loginViewController];
    self.loginViewController.view.frame = self.view.frame;
    [self.view addSubview:self.loginViewController.view];

    self.currentViewController = self.loginViewController;
    [self.loginViewController didMoveToParentViewController:self];
}

- (void)setupLoginSignal
{
    DXRLogin *login = [DXRLogin instance];
    __weak id weakSelf = self;
    [login.apiKeyChanged subscribeNext:^(NSString *apiKey) {
        id strongSelf = weakSelf;
        if (apiKey) {
            NSLog(@"API key changed to %@", apiKey);
            [strongSelf navigateToMain];
        } else {
            NSLog(@"API key removed");
            [strongSelf navigateToLogin];
        }
    }];
}

- (void)dealloc
{
    self.loginViewController = nil;
}

@end
