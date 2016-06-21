//
//  ViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ChatSectionViewController.h"
#import "LoginSectionViewController.h"
#import "AnimationSectionViewController.h"

@interface MainMenuViewController ()
@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the Title for the Main Menu Page as "Coding Taska"
    self.navigationItem.title = @"Coding Tasks";
}

- (IBAction)tableSectionAction:(id)sender
{
    //Goes to the Chat Section View Controller by Pushing it in the Navigation Controller Stack
    ChatSectionViewController *tableSectionViewController = [[ChatSectionViewController alloc] init];
    [self.navigationController pushViewController:tableSectionViewController animated:YES];
}
- (IBAction)apiSectionAction:(id)sender
{
    //Goes to the Login Section View Controller by Pushing it in the Navigation Controller Stack
    LoginSectionViewController *apiSectionViewController = [[LoginSectionViewController alloc] init];
    [self.navigationController pushViewController:apiSectionViewController animated:YES];
}
- (IBAction)animationSectionAction:(id)sender
{
    //Goes to the Animation Section View Controller by Pushing it in the Navigation Controller Stack
    AnimationSectionViewController *animationSectionViewController = [[AnimationSectionViewController alloc] init];
    [self.navigationController pushViewController:animationSectionViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
