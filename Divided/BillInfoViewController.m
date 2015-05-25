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
    NSMutableArray *usersArray;
    NSMutableArray *_arrayLabels;
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
    
    
    
    NSString *groupName = [self.selectedBill.groupName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", groupName);
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/getgroupusers.php"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *post = [NSString stringWithFormat:@"groupName=%@",groupName];
    //set request content type we MUST set this value.
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    
    //start the connection
    [connection start];

    
    
    
    
    _billNameLabel.text = [NSString stringWithFormat:@"Bill name: %@", billName];
    _billTypeLabel.text = [NSString stringWithFormat:@"Bill type: %@", billType];
    _billAmountLabel.text = [NSString localizedStringWithFormat:@"Bill amount: £%@", billAmount];
    _paidByLabel.text = [NSString stringWithFormat:@"Paid by: %@", paidBy];
    
    
    
}

- (IBAction)deleteButton:(id)sender {
    NSString *billName = [self.selectedBill.billName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", billName);
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/deletebill.php"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *post = [NSString stringWithFormat:@"billName=%@",billName];
    //set request content type we MUST set this value.
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    
    //start the connection
    [connection start];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@" , error);
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"%@", _receivedData);
    
    
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *resultSTR = [[NSString alloc] initWithData:self.receivedData
                                                encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"%@", resultSTR);
    
    
    //Parse the JSON that came in
    NSError *error;
    usersArray = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error];
    
  
        NSLog(@"count = %d", [usersArray count]);
    NSNumber *billAmount = self.selectedBill.billAmount;

    
    NSUInteger *numberOfUsers = [usersArray count];
    
    float a = [billAmount floatValue];

    int b = (int)numberOfUsers;
    
    float split = a/b;
    
    NSString *splitBill = [NSString localizedStringWithFormat:@"£%.2f", split];
    
    _splitLabel.text = splitBill;
    
    NSLog(@"%f", split);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
