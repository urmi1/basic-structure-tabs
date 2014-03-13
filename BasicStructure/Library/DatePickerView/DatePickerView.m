//
//  DatePickerView.m
//  BasicStructure
//
//  Created by _MyCompanyName_ on 11/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

@synthesize datePicker;
@synthesize btnDone;
@synthesize btnClose;

- (id)initWithFrame:(CGRect)frame 
{
	self = [super initWithFrame:frame];
    if (self) 
	{
		
    }
    return self;
}

//-(id)init{
//    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
//    return [self initWithFrame:CGRectMake(0, mainWindow.frame.size.height-, <#CGFloat width#>, <#CGFloat height#>)]
//}

@end
