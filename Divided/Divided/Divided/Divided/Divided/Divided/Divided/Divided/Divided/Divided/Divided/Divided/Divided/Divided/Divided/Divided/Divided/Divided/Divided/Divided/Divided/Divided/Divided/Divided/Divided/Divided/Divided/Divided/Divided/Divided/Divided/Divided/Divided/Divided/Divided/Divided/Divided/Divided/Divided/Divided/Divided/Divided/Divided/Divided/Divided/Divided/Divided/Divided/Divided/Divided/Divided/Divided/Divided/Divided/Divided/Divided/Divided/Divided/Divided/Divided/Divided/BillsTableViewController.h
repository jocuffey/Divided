//
//  BillsTableViewController.h
//  Divided
//
//  Created by Jo on 18/03/2015.
//  Copyright (c) 2015 Jo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillModel.h"

@interface BillsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, BillModelProtocol>

@end
