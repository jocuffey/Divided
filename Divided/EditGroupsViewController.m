//
//  EditGroupsViewController.m
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "EditGroupsViewController.h"
#import <Parse/Parse.h>

@interface EditGroupsViewController ()


@end

@implementation EditGroupsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)addGroup:(id)sender
{
    NSString *groupname = [self.groupName.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([groupname length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a group name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    
    else{
        PFObject *group = [PFObject objectWithClassName:@"group"];
        group[@"name"] = self.groupName.text;
        group[@"username"] = [PFUser currentUser];
        
        [group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                 NSLog(@"Group added");
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }

}

@end
