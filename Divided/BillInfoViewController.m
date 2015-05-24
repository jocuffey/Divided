//
//  BillInfoViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "BillInfoViewController.h"
#import "Bill.h"


@interface BillInfoViewController ()
{
    
    Bill *_selectedBill;
}

@end

@implementation BillInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *billName = [self.selectedBill.billName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *billType = [self.selectedBill.billType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSDecimalNumber *billAmount = self.selectedBill.billAmount;
    NSString *paidBy= [self.selectedBill.paidBy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", billAmount);
    
   /* NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:self.selectedBill.billAmount];*/
    
    _billNameLabel.text = [NSString stringWithFormat:@"Bill name: %@", billName];
    _billTypeLabel.text = [NSString stringWithFormat:@"Bill type: %@", billType];
    _billAmountLabel.text = [NSString stringWithFormat:@"Bill amount: %@", billAmount];
    _paidByLabel.text = [NSString stringWithFormat:@"Paid by: %@", paidBy];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
