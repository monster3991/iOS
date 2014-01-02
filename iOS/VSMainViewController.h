//
//  VSMainViewController.h
//  iOS
//
//  Created by Admin on 17.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VSTableViewController.h"
#import "VSButtonsViewController.h"

@interface VSMainViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *incremental;
@property (weak, nonatomic) IBOutlet UIButton *goToButtons;
@property (weak, nonatomic) IBOutlet UIButton *goToTable;


- (IBAction)increment:(id)sender;
- (IBAction)switchToTable:(id)sender;
- (IBAction)switchToButtons:(id)sender;

@property (strong, nonatomic) VSTableViewController *tableView;
@property (strong, nonatomic) VSButtonsViewController *buttonsView;

-(id)init;


@end
