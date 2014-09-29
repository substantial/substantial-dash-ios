//
//  DXRRootViewController.m
//  Dexr
//
//  Created by Mars Hall on 2014-09-08.
//  Copyright (c) 2014 Substantial. All rights reserved.
//

#import "DXRRootViewController.h"

@interface DXRRootViewController ()

@end

@implementation DXRRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self performSegueWithIdentifier:@"RootToLoginSegue" sender:self];
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

@end
