//
//  EditBillsViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "EditBillsViewController.h"

@interface EditBillsViewController ()


@end

@implementation EditBillsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)addBill:(id)sender {
    
    NSString *billname = [self.billNameField.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *billamount = [self.billAmountField.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *billtype = [self.billTypeField.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *paidby = [self.paidByField.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *groupname = [self.groupNameField.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([billname length] == 0 || [billamount length] == 0 || [billtype length] == 0 || [paidby length] == 0 || [groupname length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All fields must be completed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    
    else{
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://localhost:8888/addbill.php"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
        
        //set http method
        [request setHTTPMethod:@"POST"];
        //initialize a post data
        NSString *post = [NSString stringWithFormat:@"billName=%@&billAmount=%@&billType=%@&paidBy=%@&groupName=%@",billname,billamount, billtype, paidby, groupname];
        //set request content type we MUST set this value.
        
        [request setValue:@"application/x-www-form-urlencoded; charset= utf-8" forHTTPHeaderField:@"Content-Type"];
        
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

            
        [self.navigationController popToRootViewControllerAnimated:YES];
            
        
        
        
}

    
  /*  else{
        PFObject *bill = [PFObject objectWithClassName:@"bill"];
        bill[@"name"] = self.billNameField.text;
        bill[@"amount"] = self.billAmountField.text;
        bill[@"username"] = [PFUser currentUser];
        
        [bill saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"Bill added");
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
            }
        }];
    }*/

@end
