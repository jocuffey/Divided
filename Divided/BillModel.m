//
//  BillModel.m
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import "BillModel.h"
#import "Bill.h"


@interface BillModel()

{
    NSMutableData *_downloadedData;
}

@end

@implementation BillModel

- (void)downloadItems
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs synchronize];
    
    NSString *username = [prefs stringForKey:@"userDefault"];
    
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://localhost:8888/getbills.php"];
    
    // Create the request
    //NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[jsonFileUrl standardizedURL]];
    
    //set http method
    [urlRequest setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *post = [NSString stringWithFormat:@"username=%@",username];
    //set request content type we MUST set this value.
    
    [urlRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [urlRequest setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];

    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the groups
    NSMutableArray *_bills = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new group object and set its props to JsonElement properties
        Bill *newBill = [[Bill alloc] init];
        newBill.billID = jsonElement[@"billID"];
        newBill.billName = jsonElement[@"billName"];
        newBill.billType = jsonElement[@"billType"];
        newBill.billAmount = jsonElement[@"billAmount"];
        newBill.paidBy = jsonElement[@"paidBy"];
        newBill.groupName = jsonElement[@"groupName"];
        
        
        // Add this question to the groups array
        [_bills addObject:newBill];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_bills];
    }
}
@end
