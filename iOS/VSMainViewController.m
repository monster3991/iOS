//
//  VSMainViewController.m
//  iOS
//
//  Created by Admin on 17.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "VSMainViewController.h"

@interface VSMainViewController ()

@end

@implementation VSMainViewController
@synthesize label;
@synthesize incremental;
@synthesize goToTable;
@synthesize goToButtons;

-(id)init
{
    self = [super initWithNibName:@"VSMainViewController" bundle:nil];
    if (self)
    {
        // Custom initialization
        self.title = @"MainWindow";
        //self.delegate = self;
        [self.navigationController setToolbarHidden:YES];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
    //self.navigationController.navigationBar.hidden = TRUE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    label.layer.cornerRadius = 10;
    goToButtons.layer.cornerRadius = 15;
    goToTable.layer.cornerRadius = 15;
    incremental.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillLayoutSubviews
{
    //background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background3.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //round buttons and labels
    
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        NSLog(@"Landscape main screen");//big small
        label.frame = CGRectMake(254, 5, 50, 50);
        incremental.frame = CGRectMake(150, 55, 268, 50);
        goToTable.frame = CGRectMake(50, 130, 468, 50);
        goToButtons.frame = CGRectMake(50, 200, 468, 50);
    }
    else
    {
        NSLog(@"portrait main screen");//small big
        label.frame = CGRectMake(140, 65, 40, 40);
        incremental.frame = CGRectMake(95, 130, 130, 50);
        goToTable.frame = CGRectMake(50, 285, 220, 50);
        goToButtons.frame = CGRectMake(50, 360, 220, 50);
    }
}

-(IBAction)increment:(id)sender
{
    static unsigned int counter = 0;
    counter++;
    NSString *output = [ NSString stringWithFormat:@"%u", counter ];
    
    label.text = output;
}

-(IBAction)switchToTable:(id)sender
{
    if ( !_tableView )
    {
        _tableView = [ [ VSTableViewController alloc ] init ];
    }
    [ self.navigationController pushViewController:_tableView animated:YES ];
}

- (IBAction)switchToButtons:(id)sender
{
    if( !_buttonsView )
    {
        _buttonsView = [ [ VSButtonsViewController alloc ] initWithNibName:@"VSButtonsViewController" bundle:nil ];
    }
    [ self.navigationController pushViewController:_buttonsView animated:YES ];
}
@end
