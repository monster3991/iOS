//
//  VSTableViewController.m
//  iOS
//
//  Created by Admin on 19.11.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "VSTableViewController.h"
#import <Twitter/Twitter.h>

@interface VSTableViewController ()

@end

@implementation VSTableViewController


-(id)init
{
    if (self = [super init])
    {
        self.title = @"Table";
        _data = [NSMutableArray arrayWithObject:@"test"];//data with one test project
        [_table reloadData];
        _buttonPressed = [[NSMutableString alloc] init];//string which show what button pressed on the next screen "edit string" or "add string"
        [_buttonPressed setString:@"None"];
    }
    return self;
}

-(void)loadView
{
    //initialize memory for tableView
    _table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    
    [_table reloadData];

    //main View is table
    
    self.view = _table;
}


//rendering View
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [_table setBounds:(CGRectMake(0.0, 0.0, 320, 40))];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addButtonAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];

	//
    UIBarButtonItem *offsetLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //editButton in the center
   	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Editing mode" style:UIBarButtonItemStyleDone target:self action:@selector(editButtonAction:)];
    UIBarButtonItem *offsetRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	//Drop into the massive
    NSArray *array = [[NSArray alloc] initWithObjects: offsetLeft, editButton, offsetRight,nil];
    [self setToolbarItems:array];
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background3.jpg"]];
}

-(void) viewDidAppear:(BOOL)animated
{
    //for editing mode button
    if(self.editing)
        [self.navigationController setToolbarHidden:YES animated:YES];
    else
        [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.navigationBar.hidden = FALSE;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (IBAction)editButtonAction:(id)sender
{
    [super setEditing:YES animated:YES];
    [_table setEditing:YES animated:YES];
    [_table reloadData];
    //[self.navigationItem setRightBarButtonItem:nil animated:YES];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DoneButtonAction:)];
    [self.navigationItem setLeftBarButtonItem:doneButton animated:YES];
    [self.navigationController setToolbarHidden:YES animated:YES];
    
}

//editing cell
- (void)editRow:(NSIndexPath*)indexPath newText:(NSString*)newText
{
    if([newText isEqual:@""])//if return empty string delete cell
    {
        [_data removeObjectAtIndex:indexPath.row];
        [_table reloadData];
    }
    else
    {//if return not empty string editing text in the cell
        [_data replaceObjectAtIndex:indexPath.row withObject:newText];
        [_table reloadData];
    }
}


- (IBAction)addButtonAction:(id)sender
{
    if(_editField == nil)
        _editField = [ [ VSAddEditViewController alloc ] initWithNibName:@"VSAddEditViewController" bundle:nil];
    [_buttonPressed setString:@"add"];
    [self.navigationController pushViewController:_editField animated:YES];
}


- (void) addRow: (NSString*) stringText
{
    if(![stringText isEqual:@""])
    {
        [_data insertObject:stringText atIndex:[_data count]];
        [_table reloadData];
    }
}

- (IBAction)DoneButtonAction:(id)sender
{
    [super setEditing:NO animated:YES];
    [_table setEditing:NO animated:YES];
    [_table reloadData];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_data count] + self.editing;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        //cell.backgroundColor = default;
    }
    
    // Configure the cell...
    if ((self.editing) && (indexPath.row == [ _data count ]) )
    {
        cell.textLabel.text = @"Add new row";
    }
    else
    {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        cell.textLabel.text = [_data objectAtIndex:indexPath.row];
    }
    
    return cell;
}

// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
-(UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath)
        return UITableViewCellEditingStyleNone;
    // Determine the editing style based on whether the cell is a placeholder for adding content or already
    // existing content. Existing content can be deleted.
    if(self.editing == YES && indexPath.row == _data.count)
        return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete;

}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_data removeObjectAtIndex:indexPath.row];
        [_table beginUpdates];
        [_table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [_table endUpdates];
    } else
        if (editingStyle == UITableViewCellEditingStyleInsert)
        {
            if(_editField == nil)
                _editField = [ [ VSAddEditViewController alloc ] initWithNibName:@"VSAddEditViewController" bundle:nil];
            [_buttonPressed setString:@"add"];
            [self.navigationController pushViewController:_editField animated:YES];
            //[_data insertObject:@"Mac Mini" atIndex:[_data count]];
        }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != _data.count)
        return YES;
    else
        return NO;
}

// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath
{
    if( toIndexPath.row == _data.count || fromIndexPath.row == _data.count )
    {
        [_table reloadData];
        return;
    }
    //[_data exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    NSString *item = [_data objectAtIndex:fromIndexPath.row];
    [_data removeObject:item];
    [_data insertObject:item atIndex:toIndexPath.row];
    [_table reloadData];
}

//selected and start editing our text
//no editing mode
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath * )indexPath
{
    //init every time when calls
    _initializeTextForEditing = [NSString stringWithString: [_data objectAtIndex:indexPath.row]];
    if(_editField == nil)
        _editField = [ [ VSAddEditViewController alloc ] initWithNibName:@"VSAddEditViewController" bundle:nil];
    [_buttonPressed setString:@"edit"];
    _indexPathEditRow = indexPath;
    [ self.navigationController pushViewController:_editField animated:YES ];
}

//dynamic height for cells
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < _data.count)
    {
        NSString *str = [_data objectAtIndex:indexPath.row];
        CGSize contrainSize = CGSizeMake(320, MAXFLOAT);//320 is width of the screen
        CGRect size = [str boundingRectWithSize:contrainSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]} context:nil];
        return size.size.height + 14;
    }
    else
        return 30;//for "add row" element
}

@end
