//
//  HomeModel.h
//  Divided
//
//  Created by Jo on 19/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *) items;

@end

@interface HomeModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<HomeModelProtocol> delegate;

-(void)downloadItems;

@end