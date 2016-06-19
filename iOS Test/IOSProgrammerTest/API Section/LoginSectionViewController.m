//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController ()
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton:(id)sender {
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"]
                            cachePolicy:NSURLRequestReloadIgnoringCacheData
                        timeoutInterval:90];
    NSMutableString *postrequest = [NSMutableString string];
    [postrequest appendFormat:@"&%@=%@", @"username", @"SuperBoise"];
    [postrequest appendFormat:@"&%@=%@", @"password", @"qwerty"];
    
    NSData *requestData = [postrequest dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)requestData.length] forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:requestData];
    
    //NSData *outData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strData);
    }];
    //NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:outData options:0 error:NULL];
    
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}



@end
