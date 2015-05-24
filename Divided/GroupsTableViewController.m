//
//  GroupsTableViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "Group.h"
#import "GroupInfoViewController.h"

@interface GroupsTableViewController ()
{
    HomeModel *_homeModel;
    NSArray *_feedItems;
    Group *_selectedGroup;
}

@end

@implementation GroupsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    // Set this view controller object as the delegate and data source for the table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
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
    // Return the number of feed items
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the group to be shown
    Group *item = _feedItems[indexPath.row];
    
    // Get references to text label of cell
    myCell.textLabel.text = item.groupName;
    
    return myCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set selected group to var
    _selectedGroup = _feedItems[indexPath.row];
    
    // Manually call segue to detail view controller
    [self performSegueWithIdentifier:@"showGroupInfo" sender:self];
}


#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    GroupInfoViewController *groupInfoVC = segue.destinationViewController;
    
    // Set the property to the selected group so when the view for
    // detail view controller loads, it can access that property to get the feeditem object
    groupInfoVC.selectedGroup = _selectedGroup;
}


@end
