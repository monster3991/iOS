//
//  VSAddEditViewController.h
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSAddEditViewController : UIViewController

@property (nonatomic) float originalScrollerOffsetY;


@property (weak, nonatomic) IBOutlet UITextView *VStextView;


@property (weak, nonatomic) NSString *beginningText;

@property (strong,nonatomic) UIBarButtonItem *saveButton;

@property (strong, nonatomic) UIBarButtonItem *cancelButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;


@end

