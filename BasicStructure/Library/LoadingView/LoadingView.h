//
//  LoadingView.h
//  BasicStructure
//
//  Created by __CompanyName__ on 05/06/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic,strong) UILabel *lblLoadingMessage;
@property (nonatomic,strong) UIImageView *imgBG;

@end
