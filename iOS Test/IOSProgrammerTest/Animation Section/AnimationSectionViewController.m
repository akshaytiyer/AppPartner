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
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property float transferX;
@property float transferY;
@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Coding Tasks";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background Animation"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rotateImage:(id)sender {
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        [self.imageView setTransform:CGAffineTransformRotate(self.imageView.transform, M_PI)];
        [self.imageView setTransform:CGAffineTransformRotate(self.imageView.transform, M_PI)];
                            //self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        
    } completion:nil];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    self.transferX = touchLocation.x - self.imageView.center.x;
    self.transferY = touchLocation.y - self.imageView.center.y;
}


- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(self.imageView.frame, touchLocation))
    {
        self.imageView.center  = CGPointMake(touchLocation.x-self.transferX, touchLocation.y-self.transferY);
    }
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}


@end
