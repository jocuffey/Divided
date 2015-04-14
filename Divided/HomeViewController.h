//
//  HomeViewController.h
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *welcomeUser;

@end
