//
//  BillsTableViewController.m
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "BillsTableViewController.h"
#import "Bill.h"

@interface BillsTableViewController ()
{
    BillModel *_billModel;
    NSArray *_feedItems;
}
@end

@implementation BillsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set this view controller object as the delegate and data source for the table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _billModel = [[BillModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _billModel.delegate = self;
    
    // Call the download items method of the home model object
    [_billModel downloadItems];
    
    
    
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.tableView reloadData];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the location to be shown
    Bill *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    myCell.textLabel.text = item.billName;
    
    return myCell;
}

@end
