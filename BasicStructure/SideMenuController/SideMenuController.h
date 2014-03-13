//
//  SideMenuController.h
//  BasicStructure
//
//  Created by Jennis on 01/11/13.
//  Copyright (c) 2013 MFMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuController : UIViewController
  
@property (nonatomic,strong) NSMutableArray *arrMenuList;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UITableView *tblSideMenu;

- (void)loadApp;
- (IBAction)btnLogoutTapped:(id)sender;

@end
