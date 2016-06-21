//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()

//The The Property for the Username
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;

//The The Property for the Message
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;

//The Image View which will show the photographs for the people who are involved in the chat
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation ChatCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)loadWithData:(ChatData *)chatData
{
    //Set the usernameLabel with the username
    self.usernameLabel.text = chatData.username;
    
    //Set the MessageTextView with the message
    self.messageTextView.text = chatData.message;
    
    //Set the imageData with the information associated with the image
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: chatData.avatar_url]];
    self.imageView2.image = [UIImage imageWithData: imageData];
    
    //Set the properties to create a circular imageView
    self.imageView2.layer.cornerRadius = self.imageView2.frame.size.height/2;
    self.imageView2.layer.masksToBounds = YES;
    
    //Set the border color and the borderwith around the circular image view
    self.imageView2.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.imageView2.layer.borderWidth=1.0f;
}
@end
