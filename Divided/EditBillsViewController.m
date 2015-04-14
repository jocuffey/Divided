//
//  EditBillsViewController.m
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "EditBillsViewController.h"
#import <Parse/Parse.h>

@interface EditBillsViewController ()


@end

@implementation EditBillsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)addBill:(id)sender {
    
    NSString *billname = [self.billNameField.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *billamount = [self.billAmountField.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([billname length] == 0 || [billamount length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Bill name and amount are required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    
    else{
        PFObject *bill = [PFObject objectWithClassName:@"bill"];
        bill[@"name"] = self.billNameField.text;
        bill[@"amount"] = self.billAmountField.text;
        bill[@"username"] = [PFUser currentUser];
        
        [bill saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"Bill added");
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }



}
@end
