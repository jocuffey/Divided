//
//  BillModel.h
//  Divided
//
//  Created by Jo on 10/04/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BillModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *) items;

@end

@interface BillModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<BillModelProtocol> delegate;

-(void)downloadItems;

@end
