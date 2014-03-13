//
//  ClsGlobal.m
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 14/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Helper.h"
#import "TouchXML.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+extras.h"
#import "SBJson.h"

@implementation Helper

#pragma mark -
#pragma mark AlertView

+(void)showAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage delegate:(id)pDelegate
{
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:pstrTitle message:pstrMessage delegate:pDelegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}

+(void)showYesNoAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage tag:(NSInteger)pTag delegate:(id)pDelegate
{
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:pstrTitle message:pstrMessage delegate:pDelegate cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO",nil];
	alertView.tag = pTag;
	[alertView show];
}

+(void)showInAppAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage tag:(NSInteger)pTag delegate:(id)pDelegate
{
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:pstrTitle message:pstrMessage delegate:pDelegate cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Buy Now",nil];
	alertView.tag = pTag;
	[alertView show];
}

//+(void)showToastView:(NSString *)pStrMsg
//{
//    DPToastView *toast = [DPToastView makeToast:pStrMsg];
//    [toast show];
//}

#pragma mark -
#pragma mark Address From Lat Long

+(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
	NSString *urlString = [NSString stringWithFormat:kGeoCodingString,pdblLatitude, pdblLongitude];
	NSError* error;
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
	locationString = [locationString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
	return [locationString substringFromIndex:6];
}

+(CLLocationCoordinate2D)getLatLonFromAddress:(NSString*)strAddress
{
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv",[strAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSError* error;
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
    double latitude = 0.0;
    double longitude = 0.0;
	
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) 
	{
        latitude = [[listItems objectAtIndex:2] doubleValue];
        longitude = [[listItems objectAtIndex:3] doubleValue];
	}

	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;		
	
    return location;
}

#pragma mark -
#pragma mark Display and Hide loading view

+(void)displayLoadingView:(UIView*)pViewToAddLoading viewController:(UIViewController*)pViewController andMessage:(NSString *)strMessage;
{
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	appDelegate.loadingView.lblLoadingMessage.text = strMessage;
	[pViewToAddLoading addSubview:appDelegate.loadingView];
	[pViewController.view setUserInteractionEnabled:NO];
	[pViewToAddLoading setUserInteractionEnabled:NO];
}

+(void)hideLoadingView:(UIView*)pViewToRemoveLoading viewController:(UIViewController*)pViewController;
{
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	[appDelegate.loadingView removeFromSuperview];
	[pViewController.view setUserInteractionEnabled:YES];
	[pViewToRemoveLoading setUserInteractionEnabled:YES];
}

#pragma mark -
#pragma mark Check for iPad 

+(BOOL)isPad
{	
	#ifdef UI_USER_INTERFACE_IDIOM
		return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
	#else
		return NO;
	#endif
}

+(BOOL)isSimulator
{
	BOOL isSimulator = NO;
	#if TARGET_IPHONE_SIMULATOR
		isSimulator = YES;
	#endif
	return isSimulator;
}

#pragma mark -
#pragma mark String Functions 

+(NSString*)getStringFromDate:(NSDate*)pDate withFormat:(NSString*)pDateFormat
{
	NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
	[dtFormatter setDateFormat:pDateFormat];
	return [dtFormatter stringFromDate:pDate];
}

+(NSDate*)getDateFromString:(NSString*)pStrDate withFormat:(NSString*)pDateFormat
{
	NSDateFormatter *dtFormatter = [[NSDateFormatter alloc] init];
	[dtFormatter setDateFormat:pDateFormat];
	return [dtFormatter dateFromString:pStrDate];
}

+(NSMutableString*)getRandomString:(NSInteger)pIntLength
{
	NSMutableString *strPassword = [[NSMutableString alloc]init];
	for (int i = 0; i < pIntLength; i++)
	{
		NSInteger intTag = arc4random() % [kRandomPasswordString length];
		char str = [kRandomPasswordString characterAtIndex:intTag];
		[strPassword appendString:[NSString stringWithFormat:@"%c",str]];
	}
	return strPassword;
}

#pragma mark -
#pragma mark NSUserDefaults

+(void)addToNSUserDefaults:(id)pObject forKey:(NSString*)pForKey
{
	NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:pObject forKey:pForKey];
	[defaults synchronize];	
}

+(void)removeFromNSUserDefaults:(NSString*)pForKey
{
	NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:pForKey];
	[defaults synchronize];		
}


+(id)getFromNSUserDefaults:(NSString*)pForKey
{
	id pReturnObject;
	NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	pReturnObject = [defaults valueForKey:pForKey];
	return pReturnObject;
}

#pragma mark -
#pragma mark Local Notification

+(void)setLocalNotification:(NSString *)pStrNotificationTitle
{
	Class cls = NSClassFromString(@"UILocalNotification");
	if (cls != nil) 
	{
		UILocalNotification *notif = [[cls alloc] init];
		
		notif.fireDate = [NSDate date];
		notif.timeZone = [NSTimeZone systemTimeZone];
		
		notif.alertBody = [NSString stringWithFormat:@"%@, %@",pStrNotificationTitle,kNotificationMessage];
		notif.alertAction = @"Show me";
		
		notif.soundName = UILocalNotificationDefaultSoundName;
		notif.applicationIconBadgeNumber = 1;
		
		NSDictionary *userDict = [NSDictionary dictionaryWithObject:pStrNotificationTitle forKey:kRemindMeNotificationDataKey];
		notif.userInfo = userDict;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:notif];
	}		
}

+(void)setLocalNotificationWithDate:(NSDate *)pDateTime withNotificationTitle:(NSString *)pStrNotificationTitle
{
	Class cls = NSClassFromString(@"UILocalNotification");
	if (cls != nil) 
	{
		UILocalNotification *notif = [[cls alloc] init];
		
		notif.fireDate = pDateTime;
		notif.timeZone = [NSTimeZone systemTimeZone];
		
		notif.alertBody = [NSString stringWithFormat:@"%@, %@",pStrNotificationTitle,kNotificationMessage];
		notif.alertAction = @"Show me";
		
		notif.soundName = UILocalNotificationDefaultSoundName;
		notif.applicationIconBadgeNumber = 1;
		
		NSDictionary *userDict = [NSDictionary dictionaryWithObject:pStrNotificationTitle forKey:kRemindMeNotificationDataKey];
		notif.userInfo = userDict;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:notif];
	}
}

+(void)removeLocalNotificationIfSet:(NSString *)pStrNotificationTitle
{
	NSMutableArray *arrLocalNotifications=[[NSMutableArray alloc] initWithArray:[[UIApplication sharedApplication]scheduledLocalNotifications]];
	for (int k=0;k<[arrLocalNotifications count];k++) 
	{
		UILocalNotification *notification=[arrLocalNotifications objectAtIndex:k];
		NSString *strListName=[notification.userInfo valueForKey:kRemindMeNotificationDataKey];
		if([strListName isEqualToString:pStrNotificationTitle])
		{
			[[UIApplication sharedApplication] cancelLocalNotification:notification];
			break;
		}
	}
}

+(NSString*)getDocumentDirectoryPath:(NSString*)pStrPathName
{
	NSString *strPath=nil;
	
	if(pStrPathName)
		strPath = [[kUserDirectoryPath objectAtIndex:0] stringByAppendingPathComponent:pStrPathName];
	
	return strPath;
}

#pragma mark -
#pragma mark Camera Availability

+(BOOL)isCameraDeviceAvailable
{
	BOOL isCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
			isCameraAvailable = YES;
	}
	return isCameraAvailable;
}

+(BOOL)isFrontCameraDeviceAvailable
{
	BOOL isCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
			isCameraAvailable = YES;
	}
	return isCameraAvailable;
}

+(BOOL)isRearCameraDeviceAvailable
{
	BOOL isCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
			isCameraAvailable = YES;
	}
	return isCameraAvailable;
}

#pragma mark -
#pragma mark Image scaling

+(void)showCamera:(id)pController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = pController;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [pController presentModalViewController:imagePicker animated:YES];
}

+(void)showPhotoLibrary:(id)pController
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = pController;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [pController presentModalViewController:imagePicker animated:YES];
}

+(UIImagePickerControllerCameraDevice)getAvailableCamera
{
	UIImagePickerControllerCameraDevice availableDevice = NSNotFound;

	if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
		availableDevice = UIImagePickerControllerCameraDeviceFront;
	else if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
		availableDevice = UIImagePickerControllerCameraDeviceRear;
		
	return availableDevice;
}

+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize 
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}


+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)image withSize:(CGSize)newSize 
{
	CGFloat largestSize = (newSize.width > newSize.height) ? newSize.width : newSize.height;
	CGSize imageSize = [image size];
	
	// Scale the image while mainting the aspect and making sure the 
	// the scaled image is not smaller then the given new size. In
	// other words we calculate the aspect ratio using the largest
	// dimension from the new size and the small dimension from the
	// actual size.
	CGFloat ratio;
	if (imageSize.width > imageSize.height)
		ratio = largestSize / imageSize.height;
	else
		ratio = largestSize / imageSize.width;
	
	CGRect rect = CGRectMake(0.0, 0.0, ratio * imageSize.width, ratio * imageSize.height);
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Crop the image to the requested new size maintaining
	// the inner most parts of the image.
	CGFloat offsetX = 0;
	CGFloat offsetY = 0;
	imageSize = [scaledImage size];
	if (imageSize.width < imageSize.height)
		offsetY = (imageSize.height / 2) - (imageSize.width / 2);
	else
		offsetX = (imageSize.width / 2) - (imageSize.height / 2);
	
	CGRect cropRect = CGRectMake(offsetX, offsetY, imageSize.width - (offsetX * 2), imageSize.height - (offsetY * 2));
	
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
	UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef];
	CGImageRelease(croppedImageRef);
	
	return newImage;
}

+(UITableViewCell*)getBlankCell:(UITableView*)tableView withText:(NSString*)pStrText
{
	static NSString *CellIdentifier = @"BlankCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) 
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	
	UILabel *lblName = [[UILabel alloc]init];
	lblName.backgroundColor = [UIColor clearColor];
	lblName.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
	lblName.frame = CGRectMake(12, 3, 170, 25);
	lblName.text = pStrText;	
	[cell addSubview:lblName];
	[cell bringSubviewToFront:cell.textLabel];	
	
	return cell;
}

+(NSInteger)parseSuccessFailureResponse:(NSString *)xmlData
{
	NSInteger intResponse = 0;
	NSError *theError = NULL;
	CXMLDocument *theXMLDocument = [[CXMLDocument alloc] initWithXMLString:xmlData options:0 error:&theError];
	CXMLElement *rootElement = [theXMLDocument rootElement];
	NSString *strNodeName = [rootElement name];
	NSString *strNodeValue = [[rootElement stringValue]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if ([strNodeName isEqualToString:@"result"]) 
	{
		if([strNodeValue isEqualToString:@"success"])
			intResponse = kResponseSuccess;
		else if([strNodeValue isEqualToString:@"failure"])
			intResponse = kResponseFailure;
		else if([strNodeValue isEqualToString:@"duplicate"])
			intResponse = kResponseDuplicate;
	}
	return intResponse;
}


#pragma mark -
#pragma mark Show Hide label on record count.

+(void)checkRecordAvailable:(NSMutableArray *)pArrTemp withTable:(UITableView *)pTblTemp withLabel:(UILabel *)pLabel
{
	if(pArrTemp.count > 0)
		pLabel.hidden = YES;
	else 
		pLabel.hidden = NO;
	
	[pTblTemp reloadData];
}

#pragma mark -
#pragma mark Scrollview according to text input

+(void)scrollViewUp:(float)pUpvalue withDuration:(float)pDuration withView:(UIView *)pView
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:pDuration]; 
	CGRect rect = pView.frame;
    rect.origin.y -= pUpvalue;
    pView.frame = rect;
    [UIView commitAnimations];
}

+(void)scrollViewDown:(float)pDownvalue withDuration:(float)pDuration withView:(UIView *)pView
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:pDuration]; 
	CGRect rect = pView.frame;
    rect.origin.y += pDownvalue;
    pView.frame = rect;
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Set tableview common style

+(void)setTableViewStyle:(UITableView *)tblView delegate:(id)parent
{
	tblView.delegate = parent;
	tblView.dataSource = parent;
	tblView.backgroundColor = [UIColor clearColor];
	tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tblView.bounces = NO;
}

+(void)setDatePickerButtonAction:(DatePickerView *)pView withId:(id)pId
{
	//Please write btnDoneTapped method in your controller
	[pView.btnDone addTarget:pId action:@selector(btnDoneTapped:) forControlEvents:UIControlEventTouchUpInside];
	[pView.btnClose addTarget:pId action:@selector(btnDoneTapped:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -
#pragma mark Random Number

+(NSNumber*)getRandomNumber:(NSUInteger)from to:(NSUInteger)to 
{
	NSInteger intRandomNo = (int)from + arc4random() % (to-from+1);
	return [NSNumber numberWithInt:intRandomNo];
}

#pragma mark -
#pragma mark Random Inetger

+(NSInteger)getRandomInteger:(NSUInteger)from to:(NSUInteger)to 
{
	NSInteger intRandomNo = (int)from + arc4random() % (to-from+1);
	return intRandomNo;
}

#pragma mark -
#pragma mark Call The Number 

+(void)callTheNumber:(NSString *)pStrDialedNumber
{
	NSString *deviceName = [UIDevice currentDevice].model;    
	if(![deviceName isEqualToString:@"iPhone"])
	{		
		NSString *strAlertMessage = [NSString stringWithFormat:@"%@ 'tel:%@' %@",kAlertTitle,pStrDialedNumber,kAlertMessage];
		[Helper showAlertView:nil withMessage:strAlertMessage delegate:self];
	}    
	else
	{   
		pStrDialedNumber = [NSString stringWithFormat:@"tel://%@",pStrDialedNumber];
		NSString *strDialedNumber = [pStrDialedNumber stringByReplacingOccurrencesOfString:@" " withString:@""];      
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:strDialedNumber]];    
	}
}


#pragma mark -
#pragma mark Play Tap sound

+(void)playTapSound
{
	CFURLRef soundFileURLRef = CFBundleCopyResourceURL(CFBundleGetBundleWithIdentifier(CFSTR("com.apple.UIKit")),CFSTR ("Tock"),CFSTR ("aiff"),NULL);
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
	AudioServicesPlaySystemSound(soundID);
	CFRelease(soundFileURLRef);
}

+(BOOL)isValidCreditCard:(NSString*)pStrCreditCard
{
	BOOL isValid= NO;
	int Luhn = 0;
	for (int i=0;i<[pStrCreditCard length];i++)
	{
		NSUInteger count = [pStrCreditCard length]-1; // Prevents Bounds Error and makes characterAtIndex easier to read
		int doubled = [[NSNumber numberWithUnsignedChar:[pStrCreditCard characterAtIndex:count-i]] intValue] - 48;
		if (i % 2)
			doubled = doubled*2;
		
		NSString *double_digit = [NSString stringWithFormat:@"%d",doubled];
		
		if ([[NSString stringWithFormat:@"%d",doubled] length] > 1)
		{   Luhn = Luhn + [[NSNumber numberWithUnsignedChar:[double_digit characterAtIndex:0]] intValue]-48;
			Luhn = Luhn + [[NSNumber numberWithUnsignedChar:[double_digit characterAtIndex:1]] intValue]-48;
		}
		else
			Luhn = Luhn + doubled;
		
	}
	if (Luhn%10 == 0) // If Luhn/10's Remainder is Equal to Zero, the number is valid
		isValid =  YES;
	
	return isValid;
}

#pragma mark -
#pragma mark Add and Get Custom objects from UserDefaults

+(void)addCustomObjectToUserDefaults:(id)pObject key:(NSString *)pStrKey
{
	NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
	[currentDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:pObject] forKey:pStrKey];	
	[currentDefaults synchronize];	
}

+(id)getCustomObjectToUserDefaults:(NSString *)pStrKey
{
	id pReturnObject;
	NSData *data = [Helper getFromNSUserDefaults:pStrKey];
	pReturnObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	return pReturnObject;
}

+(BOOL)isRetina
{
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
		return YES;
	else 
		return NO;
}

#pragma mark -
#pragma mark Add and remove Done button

+(void)registerKeyboardNotification:(id)pObserver
{
	[[NSNotificationCenter defaultCenter] addObserver:pObserver selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:pObserver selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];		
}

+(void)deRegisterKeyboardNotification:(id)pObserver
{
	[[NSNotificationCenter defaultCenter] removeObserver:pObserver name:UIKeyboardDidShowNotification object:nil]; 
	[[NSNotificationCenter defaultCenter] removeObserver:pObserver name:UIKeyboardWillHideNotification object:nil]; 
}

+(void)addDoneButtonToKeyboard:(id)pActionTarget
{
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	doneButton.tag= 9999;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {        
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:pActionTarget action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	
	UIWindow* tempWindow = nil;
	
	if ([[[UIApplication sharedApplication] windows] count]>1) 
		tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];		
	else
		tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];			
	
	UIView* keyboard;
	for(int i=0; i<[tempWindow.subviews count]; i++) 
	{
		keyboard = [tempWindow.subviews objectAtIndex:i];
		
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) 
		{
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		}
		else 
		{
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}	
}

+(void)removeDoneButtonFromKeyboard
{
	if([[[UIApplication sharedApplication] windows] count] >1)
	{
		UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
		UIView* keyboard;
		for(int i=0; i<[tempWindow.subviews count]; i++) {
			keyboard = [tempWindow.subviews objectAtIndex:i];
			// keyboard found, add the button
			if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
				if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
					[[keyboard viewWithTag:9999] removeFromSuperview];
			} else {
				if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
					[[keyboard viewWithTag:9999] removeFromSuperview];
			}
		}
	}
}

+(UIImage *)createImageFromView:(UITableView *)pView
{
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(pView.contentSize.width, pView.contentSize.height), NO, 0.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect previousFrame = pView.frame;
	pView.frame = CGRectMake(pView.frame.origin.x, pView.frame.origin.y, pView.contentSize.width, pView.contentSize.height);
	[pView.layer renderInContext:context];
	pView.frame = previousFrame;
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(UIImage *)imageFromView:(UIView *)theView 
{
	// UIGraphicsBeginImageContext(theView.frame.size);
    [Helper RetinaAwareUIGraphicsBeginImageContext:theView.frame.size];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[theView.layer renderInContext:context];
	UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return theImage;
}

+(void)RetinaAwareUIGraphicsBeginImageContext:(CGSize)size 
{
    static CGFloat scale = -1.0;
	if (scale < 0.0) {
		UIScreen *screen = [UIScreen mainScreen];
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
			scale = [screen scale];
		} else {
            // Use pre-retina API
			scale = 0.0;
		}
	}
	if (scale > 0.0) {
		UIGraphicsBeginImageContextWithOptions(size, NO, scale);
	} else {
		UIGraphicsBeginImageContext(size);
	}
}

+(NSString *)floatToDecimal:(CGFloat)pFltPrice
{
	NSString *strReturnValue = @"";
	NSNumberFormatter *frmtr = [[NSNumberFormatter alloc] init];
	[frmtr setNumberStyle:NSNumberFormatterDecimalStyle];
	strReturnValue = [frmtr stringFromNumber:[NSNumber numberWithFloat:pFltPrice]];
	if(![strReturnValue isEmptyString] || strReturnValue != nil)
		strReturnValue  = [NSString stringWithFormat:@"%@",strReturnValue];
	
	return strReturnValue;
}

+(NSString*)getFullURL:(NSString*)pFileName
{
	return [NSString stringWithFormat:@"%@%@",kWebserviceURL,pFileName];
}

+(void)goToNextTextField:(UITextField *)pTextField
{
	NSInteger intNextTag = pTextField.tag +1 ;
	UIResponder *nextResponder = [pTextField.superview viewWithTag:intNextTag];
	if(nextResponder)
		[nextResponder becomeFirstResponder];
	else
		[pTextField resignFirstResponder];
}

+(void)keyboardShow:(UIView *)pTmpView andScrollView:(UIScrollView *)pTmpScrollView
{
    CGRect mainFrame = [UIScreen mainScreen].bounds;
    
    CGFloat keyboardHeight = 0.0;
    
    if(UIInterfaceOrientationIsPortrait(UIDeviceOrientationPortrait) || UIInterfaceOrientationIsPortrait(UIDeviceOrientationPortraitUpsideDown))
        keyboardHeight = 216;
    else
        keyboardHeight = 162;
    
    pTmpScrollView.frame= CGRectMake(pTmpScrollView.frame.origin.x, pTmpScrollView.frame.origin.y, pTmpScrollView.frame.size.width, mainFrame.size.height-keyboardHeight-pTmpScrollView.frame.origin.y-20);
	pTmpScrollView.contentSize = CGSizeMake(pTmpScrollView.frame.size.width, pTmpView.frame.size.height);
}

+(void)keyboardHide:(UIView *)pTmpView andScrollView:(UIScrollView *)pTmpScrollView andHeight:(CGFloat)pFltHeight
{
	pTmpScrollView.frame= CGRectMake(pTmpScrollView.frame.origin.x, pTmpScrollView.frame.origin.y, pTmpScrollView.frame.size.width, pFltHeight);
	pTmpScrollView.contentSize = CGSizeMake(pTmpScrollView.frame.size.width, pTmpView.frame.size.height);
}

+(void)rateApplication:(NSString*)pStrAppID
{
    NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
    str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
    str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];

    // Here is the app id from itunesconnect
    str = [NSString stringWithFormat:@"%@%@", str,pStrAppID];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+(void)openInItunes:(NSString *)pStrAppName
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms://itunes.com/apps/%@",pStrAppName]]];
}

+(NSString*)checkNullStringFromDB:(char *)pChars
{
    if(pChars)
        return [NSString stringWithUTF8String: pChars];
    else
        return @"";
}

+(CLLocationCoordinate2D)getLatLon:(NSString *)pStrAddress
{
	NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",[pStrAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSError* error;
    NSString *strDict = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSASCIIStringEncoding error:&error];

    CLLocationCoordinate2D location;
    double latitude = 0.0;
    double longitude = 0.0;

    SBJsonParser *objParser = [[SBJsonParser alloc] init];
    
    NSDictionary *resultDictionary = (NSDictionary*) [objParser objectWithString:strDict];
    if([[resultDictionary objectForKey:@"status"] isEqualToString:@"OK"])
    {
        NSArray* arrResults = [(NSDictionary*)resultDictionary objectForKey:@"results"];

        if(arrResults.count > 0)
        {
            NSDictionary *dict = [arrResults objectAtIndex:0];
            NSDictionary *dictGeometry = [dict objectForKey:@"geometry"];
            NSDictionary *dictLocation = [dictGeometry objectForKey:@"location"];
            latitude = [[dictLocation valueForKey:@"lat"] doubleValue];
            longitude = [[dictLocation valueForKey:@"lng"] doubleValue];
        }
    }

    location.latitude = latitude;
    location.longitude = longitude;

    return location;
}

@end
