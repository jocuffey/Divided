//
//  EditGroupsViewController.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGroupsViewController : UIViewController

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UITextField *groupName;

- (IBAction)addGroup:(id)sender;

@end
