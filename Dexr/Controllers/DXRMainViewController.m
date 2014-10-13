//
//  DXRMainViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-10-13.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRMainViewController.h"
#import "DXRLogin.h"

@interface DXRMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *loginUserName;
@property (weak, nonatomic) DXRLogin *login;
@end

@implementation DXRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.login = [DXRLogin instance];

    __weak DXRMainViewController *weakSelf = self;
    [self.login.userNameChanged subscribeNext:^(NSString *userName) {
        DXRMainViewController *strongSelf = weakSelf;
        strongSelf.loginUserName.text = userName;
    }];
}

- (IBAction)didPressLogoutButton:(id)sender
{
    [self.login logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
