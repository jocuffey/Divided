//
//  EditGroupsViewController.h
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGroupsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *groupName;

- (IBAction)addGroup:(id)sender;

@end
