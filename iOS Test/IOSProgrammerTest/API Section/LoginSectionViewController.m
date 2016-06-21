//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"

@interface LoginSectionViewController () <UITextFieldDelegate>

//The username and password properties which are connected to the UITextFields, username and password
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

//Properties to calculate the start time and finish time of the POST call, and thereby calculate the execution time
@property (nonatomic) NSTimeInterval executionTime;
@property (nonatomic) NSDate* methodStart;
@property (nonatomic) NSDate* methodFinish;
@end

@implementation LoginSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the Title for the Main Menu Page as "Login"
    self.navigationItem.title = @"Login";
    
    //Assign the username and password to be delegated to themselves, in order to dismiss keyboard on clicking "Return"
    self.username.delegate = self;
    self.password.delegate = self;
}


- (IBAction)loginButton:(id)sender {
    
    //Create the URL Request for the website
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.apppartner.com/AppPartnerProgrammerTest/scripts/login.php"]
                            cachePolicy:NSURLRequestReloadIgnoringCacheData
                        timeoutInterval:90];
    
    //Create the string which needs to be appended to the URL Request in the "POST" call
    NSMutableString *postrequest = [NSMutableString string];
    [postrequest appendFormat:@"&%@=%@", @"username", self.username.text];
    [postrequest appendFormat:@"&%@=%@", @"password", self.password.text];
    
    //Sets the post request data to be encoded to the string
    NSData *requestData = [postrequest dataUsingEncoding:NSUTF8StringEncoding];
    
    //Set the request type to be "POST", since default is "GET" and set the request properties
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)requestData.length] forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:requestData];
    
    //Set the start time for the request to be se sent
    self.methodStart = [NSDate date];
    
    //Sent an Asynchronus request
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        //Set the finish time for the request to be sent
        self.methodFinish = [NSDate date];
        
        //Calculate the execution time for the request
        self.executionTime = [self.methodFinish timeIntervalSinceDate:self.methodStart];
        
        //Store all the JSON Data fetched in a dictionary
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //Create and Alert View Controller to be displayed on the screen
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:[dictionary valueForKey:@"code"]
                                      message:[NSString stringWithFormat:@"%@\n\nAPI call took %f milliseconds",[dictionary valueForKey:@"message"], self.executionTime]
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        //Add the button for "OK", which will go back to the Main Menu when clicked
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"Ok" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        //Add a button for "Cancel", which will simply close the alert box
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action){
           [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        //Add the buttons to the Alert Box
        [alert addAction:ok];
        [alert addAction:cancel];
        
        //Present the alert box
        [self presentViewController:alert animated:YES completion:nil];
    }];

}


//Action based upon a textfield delegate property
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    //Close the Keyboard when the return button is pressed
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
