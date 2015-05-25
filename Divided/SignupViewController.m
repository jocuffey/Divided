//
//  SignupViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//


#import "SignupViewController.h"
#import "User.h"

@interface SignupViewController ()

@end

@implementation SignupViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (IBAction)signup:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:email] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
        if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All fields must be completed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    
    else{
        
        
        NSString *urlStr = @"http://localhost:8888/register.php";
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&email=%@",username,password, email];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",[postData length]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if(conn) {
            NSLog(@"Connection Successful");
            NSLog(@"%@", post);
        } else {
            NSLog(@"Connection could not be made");
        }

        

    [self.navigationController popViewControllerAnimated:YES];
 
    }
    
}


@end