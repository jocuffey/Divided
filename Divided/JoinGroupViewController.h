//
//  JoinGroupViewController.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinGroupViewController : UIViewController

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UITextField *groupNameLabel;

- (IBAction)joinButton:(id)sender;


@end
