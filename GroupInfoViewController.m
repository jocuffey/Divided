//
//  GroupInfoViewController.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "GroupInfoViewController.h"
#import "Group.h"
#import "UserInGroup.h"


@interface GroupInfoViewController ()
{
    Group *_selectedGroup;
    NSMutableArray *usersArray;
    NSMutableArray *_arrayLabels;


}

@end

@implementation GroupInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *groupName = [self.selectedGroup.groupName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
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
    
    _groupNameLabel.text = _selectedGroup.groupName;

}

- (IBAction)deleteButton:(id)sender {
    NSString *groupName = [self.selectedGroup.groupName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@", groupName);
    
    [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/deletegroup.php"];
    
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
    _arrayLabels = [NSMutableArray array];
    int y = 140;
    
    for (NSDictionary *dic in usersArray){
        
        // Now you have dictionary get value for key
        NSString *username = (NSString*) [dic valueForKey:@"username"];
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, y, 100, 40)];
        [myLabel setBackgroundColor:[UIColor clearColor]];
        [myLabel setText: username];
        [[self view] addSubview:myLabel];
        [_arrayLabels addObject:myLabel];
        y=y+30;
        NSLog(@"count = %d", [_arrayLabels count]);

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
