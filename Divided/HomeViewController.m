//
//  HomeViewController.m
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(![prefs boolForKey:@"logged_in"]) {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    

    
}



- (IBAction)logout:(id)sender {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"userDefault"];
    [prefs removeObjectForKey:@"passDefault"];
    [prefs synchronize];

    
    NSLog(@"%@", [prefs stringForKey:@"userDefault"]);
    
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender    {
    if([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }

}
@end
