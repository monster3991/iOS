//
//  VSAddEditViewController.m
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "VSAddEditViewController.h"
#import "VSTableViewController.h"

@interface VSAddEditViewController ()

@end


@implementation VSAddEditViewController

@synthesize beginningText;
@synthesize VStextView;
@synthesize saveButton;
@synthesize cancelButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [super setEditing:YES animated:YES];
    //[self setEditing:YES];
    // Do any additional setup after loading the view from its nib.
    saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonAction:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    
    [VStextView setText:beginningText];
    [VStextView setKeyboardAppearance:UIKeyboardAppearanceDark];
    NSLog(@"VSAddEditController is loaded");
}

-(void) viewDidAppear:(BOOL)animated
{
    VSTableViewController *tableViewController = [[self.navigationController viewControllers] objectAtIndex:([[self.navigationController viewControllers] count]-2)];
    if(![tableViewController.buttonPressed isEqualToString:@"add"])
        VStextView.text = tableViewController.initializeTextForEditing;
    NSLog(@"VSAddViewController is appeared");
}

-(void) viewDidDisappear:(BOOL)animated
{
    VStextView.text = @"";
    NSLog(@"VSAddViewController is dissappeared");
}

-(void) viewWillLayoutSubviews
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
    {
        self.VStextView.frame = CGRectMake(0, 0, 568, 104);//big small
    }
    else
    {
        self.VStextView.frame = CGRectMake(0, 0, 320, 288);//small big
    }
}

- (IBAction)saveButtonAction:(id)sender
{
    NSString *currentText = VStextView.text.copy;//[NSString stringWithString:VStextView.text];
    NSArray *stack = [self.navigationController viewControllers];
    //previous viewController
    VSTableViewController *tableController = [stack objectAtIndex:([stack count]-2)];
    if([tableController.buttonPressed isEqual:@"add"])
        [tableController addRow:currentText];
    else
        if([tableController.buttonPressed isEqual:@"edit"])
            [tableController editRow:tableController.indexPathEditRow newText:currentText];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Save button pressed");
}


- (IBAction)cancelButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Cancel button pressed");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}*/


-(IBAction)backgroundTouched:(id)sender
{
    [VStextView resignFirstResponder];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
        NSLog(@"The border of the screen is reached and scrolled the text up");
    }
}

@end

