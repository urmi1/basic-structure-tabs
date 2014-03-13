//
//  DatePickerView.h
//  BasicStructure
//
//  Created by _MyCompanyName_ on 11/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DatePickerView : UIView 
{
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UIButton *btnDone;
	IBOutlet UIButton *btnClose;
}
@property(nonatomic, retain)UIDatePicker *datePicker;
@property(nonatomic, retain)UIButton *btnDone;
@property(nonatomic, retain)UIButton *btnClose;

@end
