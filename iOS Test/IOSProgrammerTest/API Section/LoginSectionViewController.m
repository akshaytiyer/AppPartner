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
@property (nonatomic) NSTimeInterval executionTime;
@property (nonatomic) NSDate* methodStart;
@property (nonatomic) NSDate* methodFinish;
@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Login";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background Login"]];
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
    
    self.methodStart = [NSDate date];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:[dictionary valueForKey:@"code"]
                                      message:[NSString stringWithFormat:@"%@\n\nAPI call took %f milliseconds",[dictionary valueForKey:@"message"], self.executionTime]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action){
           [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    self.methodFinish = [NSDate date];
    self.executionTime = [self.methodFinish timeIntervalSinceDate:self.methodStart];
    //NSLog(@"executionTime = %f", executionTime);
    //NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:outData options:0 error:NULL];

}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}



@end
