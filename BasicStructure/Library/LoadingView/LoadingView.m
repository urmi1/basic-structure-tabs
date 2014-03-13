//
//  LoadingView.m
//  BasicStructure
//
//  Created by __CompanyName__ on 05/06/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "LoadingView.h"

#define kLoadingHeight 64
#define kLoadingWidth 189
#define kLoadingImgName @"loaderbg.png"

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor redColor];
        
        //Background
        _imgBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loaderbg.png"]];
        _imgBG.frame = CGRectMake(0, 0, kLoadingWidth, kLoadingHeight);
        [self addSubview:_imgBG];

        //Indicator
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.frame = CGRectMake(10, 14, 37, 37);
        _indicatorView.hidesWhenStopped = NO;
        [_indicatorView startAnimating];
        [self addSubview:_indicatorView];
        
        //Label
        _lblLoadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(50, 19, 120, 28)];
        _lblLoadingMessage.backgroundColor = [UIColor clearColor];
        _lblLoadingMessage.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _lblLoadingMessage.textColor = [UIColor whiteColor];
        _lblLoadingMessage.text = kPleaseWait;
        _lblLoadingMessage.numberOfLines = 0;
        [self addSubview:_lblLoadingMessage];
        
        [self sendSubviewToBack:_imgBG];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

-(id)init{    
    CGRect centerFrame;
    centerFrame.size.width = kLoadingWidth;
    centerFrame.size.height = kLoadingHeight;
    return [self initWithFrame:centerFrame];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self setCenter:newSuperview.center];
}

@end
