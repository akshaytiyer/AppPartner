//
//  TableSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatSectionViewController.h"
#import "MainMenuViewController.h"
#import "ChatCell.h"

#define TABLE_CELL_HEIGHT 100.0f

@interface ChatSectionViewController ()

//The TableView Data
@property (nonatomic, strong) IBOutlet UITableView *tableView;

//The array in which the chat data will be displayed
@property (nonatomic, strong) NSMutableArray *loadedChatData;
@end

@implementation ChatSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the Title for the Main Menu Page as "Chat"
    self.navigationItem.title = @"Chat";
    
    //Allocate space for the Array
    self.loadedChatData = [[NSMutableArray alloc] init];
    
    //Call the function Load JSON Data
    [self loadJSONData];

}

- (void)loadJSONData
{
    //Get the JSON file path where the file name is "chatData"
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"chatData" ofType:@"json"];

    //Assign an error property
    NSError *error = nil;

    //Get the JSON Data into
    NSData *rawData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];

    //Check for the JSON Data to be displayed
    id JSONData = [NSJSONSerialization JSONObjectWithData:rawData options:NSJSONReadingAllowFragments error:&error];

    
    //Empty the array
    [self.loadedChatData removeAllObjects];
    if ([JSONData isKindOfClass:[NSDictionary class]])
    {
        //Assign a dictionary
        NSDictionary *jsonDict = (NSDictionary *)JSONData;

        //Create an array which contains all the data of key "data" into the loaded array
        NSArray *loadedArray = [jsonDict objectForKey:@"data"];
        if ([loadedArray isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *chatDict in loadedArray)
            {
                //Added the data into the array loaded chat data
                ChatData *chatData = [[ChatData alloc] init];
                [chatData loadWithDictionary:chatDict];
                [self.loadedChatData addObject:chatData];
            }
        }
    }
    
    //Refresh the data in the table
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ChatCell";
    ChatCell *cell = nil;
    //Load the cell with data of Identifier "ChatCell", which takes a reference to the ChatCell.m class
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (ChatCell *)[nib objectAtIndex:0];
    }
    
    //Loads the data onto the table to be displayed
    ChatData *chatData = [self.loadedChatData objectAtIndex:[indexPath row]];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell loadWithData:chatData];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //The number of elements in the array
    return self.loadedChatData.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the height of each row
    return TABLE_CELL_HEIGHT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
