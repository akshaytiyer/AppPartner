//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@end

@implementation ChatCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: chatData.avatar_url]];
    self.imageView2.image = [UIImage imageWithData: imageData];
    self.imageView2.layer.cornerRadius = self.imageView2.frame.size.width/2;
    NSLog(@"%f",self.imageView2.layer.cornerRadius);
    self.imageView2.layer.masksToBounds = YES;
    self.imageView2.layer.borderWidth=1.0f;
}
@end
