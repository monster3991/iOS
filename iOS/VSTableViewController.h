//
//  VSTableViewController.h
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "VSAddEditViewController.h"

@interface VSTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

-(id)init;
@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) VSAddEditViewController *editField;
@property (strong, nonatomic) NSMutableString *buttonPressed;
@property (strong, nonatomic) NSIndexPath *indexPathEditRow;
@property (strong, nonatomic) NSString *initializeTextForEditing;


- (void) addRow: (NSString*) stringText;
- (void)editRow:(NSIndexPath*)indexPath newText:(NSString*)newText;
@end





