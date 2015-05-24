//
//  GroupInfoViewController.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"


@interface GroupInfoViewController : UIViewController 

- (IBAction)deleteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;

@property NSMutableArray *arrayLabels;

@property (strong, nonatomic) Group *selectedGroup;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@end
