//
//  SideMenuController.m
//  BasicStructure
//
//  Created by Jennis on 01/11/13.
//  Copyright (c) 2013 MFMA. All rights reserved.
//

#import "SideMenuController.h"

@interface SideMenuController ()
@end

@implementation SideMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if(isiPhone5)
            [self.view setFrame:CGRectMake(0, 0, 320, 568)];
        else
            [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ((UILabel*)[self.view viewWithTag:1]).font =[UIFont fontWithName:@"Raleway-SemiBold" size:18];
    [self commonInit];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view setBackgroundColor:[UIColor colorWithHex:0x464E5F]];
    [_bottomView setBackgroundColor:[UIColor colorWithHex:0x3A404F]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CommonInit

-(void)commonInit{
    _arrMenuList = [[NSMutableArray alloc] initWithCapacity:0];
    [self fetchMenuList];
}

-(void)fetchMenuList{
    NSArray *arrValues = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"]];
    _arrMenuList = [Menu arrayOfModelsFromDictionaries:arrValues];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrMenuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if(indexPath.row != [_arrMenuList count]-1)
            [self addBottomBorder:cell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Menu *objMenu = [_arrMenuList objectAtIndex:indexPath.row];
    
    //Text Configuration
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.font = [UIFont fontWithName:@"Raleway" size:16];
    [cell.textLabel setTextColor:[UIColor colorWithHexString:objMenu.strFontColor]];

    cell.imageView.image = [UIImage imageNamed:objMenu.strImage];
    
    if([objMenu.strTitle isEqualToString:@"My Profile"] || [objMenu.strTitle isEqualToString:@"My Karma Points"] || [objMenu.strTitle isEqualToString:@"My Karma Cards"]){
            NSString *strSpace = [objMenu.strTitle stringByAddingSpace:12 atIndex:0];
            cell.textLabel.text = strSpace;
    }else
           cell.textLabel.text = objMenu.strTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Menu *objMenu = [_arrMenuList objectAtIndex:indexPath.row];
    if(objMenu.strDestinationController && ![objMenu.strDestinationController isEmptyString]){
        [self loadViewController:objMenu.strDestinationController];
    }
}

//MFSideMenu replace center container

-(void)loadViewController:(NSString*)strViewController{
    NSString *destinationControllerName = [strViewController stringByAppendingString:@"Controller"];
    UIViewController *dest = [[NSClassFromString(destinationControllerName) alloc] initWithNibName:destinationControllerName bundle:nil];
    if(dest){
        //May be this is leak
//        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//        NSArray *controllers = [NSArray arrayWithObject:dest];
//        navigationController.viewControllers = controllers;
//        self.menuContainerViewController.centerViewController = nil;
        UINavigationController *navigationController = [[UINavigationController alloc] init];
        navigationController.navigationBar.hidden = YES;
        NSArray *controllers = [NSArray arrayWithObject:dest];
        navigationController.viewControllers = controllers;
//        self.menuContainerViewController.centerViewController = navigationController;
    }
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

-(void)addBottomBorder:(UIView*)theView{
    UIView *bottomBorderView = [[UIView alloc] initWithFrame:CGRectMake(7, theView.bounds.size.height - 1, 250.0f, 1.0f)];
    bottomBorderView.opaque = YES;
    bottomBorderView.backgroundColor = [UIColor colorWithHex:0x3A404F];
    [theView addSubview:bottomBorderView];
}

-(void)loadApp{
    [self loadViewController:@"Home"];
}

#pragma mark - Button Events
- (IBAction)btnLogoutTapped:(id)sender {
    [self loadViewController:@"Login"];
}

@end
