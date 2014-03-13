//
//  CustomCell.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblListName;

-(void)configureData:(List*)objList;

@end
