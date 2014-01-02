//
//  VSButtonsViewController.m
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "VSButtonsViewController.h"

@interface VSButtonsViewController ()

@end

@implementation VSButtonsViewController
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button10;
@synthesize button7;
@synthesize button11;
@synthesize button8;
@synthesize button9;

BOOL button6IsActive;
BOOL button7IsActive;
BOOL isAnimationOverAtButtonIndex[10];


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        button6IsActive = TRUE;
        button7IsActive = TRUE;
        for(unsigned int i = 1; i < 10; i++)
            isAnimationOverAtButtonIndex[i] = TRUE;
        self.title = @"Buttons";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = FALSE;
    button1.alpha =1.0f;
    button2.transform = CGAffineTransformMakeScale(1,1);
    button3.center = CGPointMake(53, 84);
    button4.center = CGPointMake(53, 252);
    if(!isAnimationOverAtButtonIndex[5])
        [self.button5 setTransform:CGAffineTransformRotate(self.button5.transform, -M_PI/4)];
    [button8 setUserInteractionEnabled:TRUE];
    for(unsigned int i = 1; i < 10; i++)
        isAnimationOverAtButtonIndex[i] = TRUE;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)button1TransparencyChanged:(id)sender
{
    [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        button1.alpha = 0.0;
        isAnimationOverAtButtonIndex[1] = FALSE;
    } completion:^(BOOL finished)
     {
         if (finished)
             [UIView animateWithDuration:3.0f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
                 button1.alpha = 1.0;
                 isAnimationOverAtButtonIndex[1] = TRUE;
             } completion:nil];
     }
     ];
    NSLog(@"Button 1 is initialized");
}

- (IBAction)button2HalfResize:(id)sender
{
    [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        button2.transform = CGAffineTransformMakeScale(0.5,0.5);
        isAnimationOverAtButtonIndex[2] = FALSE;
    } completion:^(BOOL finished)
     {
         if (finished)
             [UIView animateWithDuration:3.0f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
                 button2.transform = CGAffineTransformMakeScale(1,1);
                 isAnimationOverAtButtonIndex[2] = TRUE;
             } completion:nil];
     }
     ];
    NSLog(@"Button 2 is initialized");
}

- (IBAction)button3MoveToButton4CurrentPosition:(id)sender
{
    [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button3.center = CGPointMake(-161, 252);
        isAnimationOverAtButtonIndex[3] = FALSE;
    } completion:^(BOOL finished)
     {
         if(finished)
             [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                 button3.center = CGPointMake(53, 84);
                 isAnimationOverAtButtonIndex[3] = TRUE;
             } completion:nil];
     }];
    NSLog(@"Button 3 is initialized");
}

- (IBAction)button4MoveToButton3CurrentPosition:(id)sender
{
    
    [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        button4.center = CGPointMake(267, 84);
        isAnimationOverAtButtonIndex[4] = FALSE;
    } completion:^(BOOL finished)
     {
         if(finished)
             [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                 button4.center = CGPointMake(53, 252);
                 isAnimationOverAtButtonIndex[4] = TRUE;
             } completion:nil];
     }];
    NSLog(@"Button 4 is initialized");
}


- (IBAction)button5RotateButton45Degrees:(id)sender
{
    [UIView animateWithDuration:3.0f delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.button5 setTransform:CGAffineTransformRotate(self.button5.transform, M_PI/4)];
        isAnimationOverAtButtonIndex[5] = FALSE;
    } completion:^(BOOL finished)
     {
         if(finished)
             [UIView animateWithDuration:3.0f delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                 [self.button5 setTransform:CGAffineTransformRotate(self.button5.transform, -M_PI/4)];
                 isAnimationOverAtButtonIndex[5] = TRUE;
             } completion:nil];
     }];
    NSLog(@"Button 5 is initialized");
}

- (IBAction)button6FlipToLeftToButton10:(id)sender
{
    [UIView transitionFromView:button6
                        toView:button10
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionShowHideTransitionViews
                    completion:nil];
    NSLog(@"Button 6 is initialized");
    button6IsActive = FALSE;
}

- (IBAction)button10FlipToRightToButton6:(id)sender
{
    [UIView transitionFromView:button10
                        toView:button6
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews
                    completion:nil];
    NSLog(@"Button 10 is initialized");
    button6IsActive = TRUE;
}

- (IBAction)button7CrossDissolveToButton11:(id)sender
{
    [UIView transitionWithView:button7
                      duration:1
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // Change the view's state
                        button7.alpha = 0.0f;
                        button11.alpha = 1.0f;
                    }
                    completion:nil];
    NSLog(@"Button 7 is initialized");
    button7IsActive = FALSE;
}

- (IBAction)button11FadeToButton7:(id)sender
{

    [UIView transitionWithView:button11
                      duration:1
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        // Change the view's state
                        button7.alpha = 1.0f;
                        button11.alpha = 0.0f;
                    }
                    completion:nil];
    NSLog(@"Button 11 is initialized");
    button7IsActive = TRUE;
}

- (IBAction)button8AllButtonsActions:(id)sender
{
    [button8 setUserInteractionEnabled:FALSE];
    //button1
    if(isAnimationOverAtButtonIndex[1])
        [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            button1.alpha = 0.0;
        } completion:^(BOOL finished)
         {
             if (finished)
                 [UIView animateWithDuration:3.0f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
                     button1.alpha = 1.0;
                 } completion:nil];
         }
         ];
    
    //button2
    if(isAnimationOverAtButtonIndex[2])
        [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{button2.transform = CGAffineTransformMakeScale(0.5,0.5);} completion:^(BOOL finished)
         {
             if (finished)
                 [UIView animateWithDuration:3.0f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{button2.transform = CGAffineTransformMakeScale(1,1);} completion:nil];
         }
         ];
    
    //button3
    if(isAnimationOverAtButtonIndex[3])
        [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.autoresizesSubviews = NO;
            button3.center = CGPointMake(-161, 252);
        } completion:^(BOOL finished)
         {
             if(finished)
                 [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{button3.center = CGPointMake(53, 84);
                 } completion:nil];
         }];
    
    //button4
    if(isAnimationOverAtButtonIndex[4])
        [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.view.autoresizesSubviews = NO;
            button4.center = CGPointMake(267, 84);
        } completion:^(BOOL finished)
         {
             if(finished)
                 [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{button4.center = CGPointMake(53, 252);
                 } completion:nil];
         }];
    
    //button5
    if(isAnimationOverAtButtonIndex[5])
    {
        [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.button5 setTransform:CGAffineTransformRotate(self.button5.transform, M_PI/4)];
            isAnimationOverAtButtonIndex[5] = FALSE;
            isAnimationOverAtButtonIndex[8] = FALSE;
        } completion:^(BOOL finished)
         {
             if(finished)
                 [UIView animateWithDuration:3.0f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                     [self.button5 setTransform:CGAffineTransformRotate(self.button5.transform, -M_PI/4)];
                     [button8 setUserInteractionEnabled:TRUE];
                     isAnimationOverAtButtonIndex[5] = TRUE;
                     isAnimationOverAtButtonIndex[8] = TRUE;
                 } completion:nil];
         }];
    }
    
    if(button6IsActive)
    {
        //button6
        [UIView transitionFromView:button6
                            toView:button10
                          duration:3
                           options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
        button6IsActive = FALSE;
    }
    else
    {
        //button10
        [UIView transitionFromView:button10
                            toView:button6
                          duration:3
                           options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
        button6IsActive = TRUE;
    }
    
    if(button7IsActive)
    {
        //button7
        [UIView transitionWithView:button7
                          duration:3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            // Change the view's state
                            button7.alpha = 0.0f;
                            button11.alpha = 1.0f;
                        }
                        completion:nil];
        button7IsActive = FALSE;
    }
    else
    {
        //button11
        [UIView transitionWithView:button11
                          duration:3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            // Change the view's state
                            button7.alpha = 1.0f;
                            button11.alpha = 0.0f;
                        }
                        completion:nil];
        button7IsActive = TRUE;
    }
    
    if(isAnimationOverAtButtonIndex[8])
        [button8 setUserInteractionEnabled:TRUE];
    
    NSLog(@"Button 8 is initialized");
        
}

- (IBAction)button9CrazyAction:(id)sender
{

}


@end




