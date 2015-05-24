//
//  HomeViewController.m
//  Divided
//
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
    
    [prefs synchronize];
    
    NSString *username = [prefs stringForKey:@"userDefault"];
    if(![prefs boolForKey:@"logged_in"]) {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/recentbill.php"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *post = [NSString stringWithFormat:@"username=%@",username];
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
