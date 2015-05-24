//
//  JoinGroupViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "JoinGroupViewController.h"

@interface JoinGroupViewController ()

@end

@implementation JoinGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)joinButton:(id)sender {
    NSString *groupname = [self.groupNameLabel.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs synchronize];
    
    NSString *username = [prefs stringForKey:@"userDefault"];
    
    if ([groupname length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a group name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    
    
    
    else{
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://localhost:8888/joingroup.php"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
        
        //set http method
        [request setHTTPMethod:@"POST"];
        //initialize a post data
        NSString *post = [NSString stringWithFormat:@"groupName=%@&username=%@",groupname,username];
        //set request content type
        
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        //set post data of request
        [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
        
        //initialize a connection from request
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = connection;
        
        //start the connection
        [connection start];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@" , error);
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *resultSTR = [[NSString alloc] initWithData:self.receivedData
                                                encoding:NSUTF8StringEncoding];
    NSLog(@"%@" , resultSTR);
    
    if (([resultSTR  isEqual: @"success"])) {
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    
    
}

@end
