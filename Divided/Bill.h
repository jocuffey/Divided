//
//  Bill.h
//  Divided
//
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bill : NSObject


@property (nonatomic, strong) NSString *billID;
@property (nonatomic, strong) NSString *billName;
@property (nonatomic, strong) NSDecimalNumber *billAmount;
@property (nonatomic, strong) NSString *billType;
@property (nonatomic, strong) NSString *paidBy;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSDecimalNumber *numberUsers;

@end
