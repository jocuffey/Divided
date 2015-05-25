//
//  BillInfoViewController.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bill.h"

@interface BillInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *billNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *billAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *billTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *paidByLabel;

@property (weak, nonatomic) IBOutlet UILabel *splitLabel;

@property (strong, nonatomic) Bill *selectedBill;

- (IBAction)deleteButton:(id)sender;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;


@end
