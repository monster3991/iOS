//
//  VSButtonsViewController.h
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSButtonsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;


@property (weak, nonatomic) IBOutlet UIView *viewForButton3;


- (IBAction)button1TransparencyChanged:(id)sender;
- (IBAction)button2HalfResize:(id)sender;
- (IBAction)button3MoveToButton4CurrentPosition:(id)sender;
- (IBAction)button4MoveToButton3CurrentPosition:(id)sender;
- (IBAction)button5RotateButton45Degrees:(id)sender;
- (IBAction)button6FlipToLeftToButton10:(id)sender;
- (IBAction)button10FlipToRightToButton6:(id)sender;
- (IBAction)button7CrossDissolveToButton11:(id)sender;
- (IBAction)button11FadeToButton7:(id)sender;
- (IBAction)button8AllButtonsActions:(id)sender;
- (IBAction)button9CrazyAction:(id)sender;

@end
