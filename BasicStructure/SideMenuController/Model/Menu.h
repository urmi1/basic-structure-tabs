//
//  Menu.h
//  BasicStructure
//
//  Created by Tulip M on 07/11/13.
//  Copyright (c) 2013 MFMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : BSObject

@property (nonatomic,strong) NSString *strTitle;
@property (nonatomic,strong) NSString <Optional>* strImage;
@property (nonatomic,strong) NSString *strFontColor;
@property (nonatomic,strong) NSString *strDestinationController;

@end
