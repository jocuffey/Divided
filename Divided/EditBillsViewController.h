//
//  EditBillsViewController.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBillsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (weak, nonatomic) IBOutlet UITextField *billNameField;
@property (weak, nonatomic) IBOutlet UITextField *billAmountField;
@property (weak, nonatomic) IBOutlet UITextField *billTypeField;
@property (weak, nonatomic) IBOutlet UIPickerView *billTypePicker;
@property (weak, nonatomic) IBOutlet UITextField *paidByField;
@property (weak, nonatomic) IBOutlet UITextField *groupNameField;

- (IBAction)addBill:(id)sender;

@end
