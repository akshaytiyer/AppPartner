//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"

@interface AnimationSectionViewController ()

//The Image View which is needed to be animated, currently assigned the image directly
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

//The properties which will be used in order to calculate the point where the image is being touched
@property float transferX;
@property float transferY;
@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the Title for the Main Menu Page as "Animation"
    self.navigationItem.title = @"Animation";
}

- (IBAction)rotateImage:(id)sender {
    
    //The properites required to animate the image
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                        //Looped twice since each loop causes a 180 degree rotation
                        for (int i=0;i<2;i++)
                            {
                             [self.imageView setTransform:CGAffineTransformRotate(self.imageView.transform, M_PI)];
                            }
                        }
                     completion:nil];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //Get the touch location in the view
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    //Assign the values of transferX and transferY
    self.transferX = touchLocation.x - self.imageView.center.x;
    self.transferY = touchLocation.y - self.imageView.center.y;
}


- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    
    //Get the touch location in the view
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    //If the touch location is over the frame of that image then simply transfer the image based upon the location of the touch
    if (CGRectContainsPoint(self.imageView.frame, touchLocation))
    {
        self.imageView.center  = CGPointMake(touchLocation.x-self.transferX, touchLocation.y-self.transferY);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
