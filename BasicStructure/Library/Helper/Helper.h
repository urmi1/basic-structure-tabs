//
//  ClsGlobal.h
//  iPhoneBasicStructure
//
//  Created by _MyCompanyName_ on 14/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DatePickerView.h"

@interface Helper : NSObject
{

}

//Custom AlertView
+(void)showAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage delegate:(id)pDelegate;
+(void)showYesNoAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage tag:(NSInteger)pTag delegate:(id)pDelegate;
+(void)showInAppAlertView:(NSString *)pstrTitle withMessage:(NSString *)pstrMessage tag:(NSInteger)pTag delegate:(id)pDelegate;

//+(void)showToastView:(NSString *)pStrMsg;

//Loading
+(void)displayLoadingView:(UIView*)pViewToAddLoading viewController:(UIViewController*)pViewController andMessage:(NSString *)strMessage;
+(void)hideLoadingView:(UIView*)pViewToRemoveLoading viewController:(UIViewController*)pViewController;

//Check for iPad idiom
+(BOOL)isPad;
+(BOOL)isSimulator;

//Address From LatLong
+(NSString *)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude;

//String function
+(NSString*)getStringFromDate:(NSDate*)pDate withFormat:(NSString*)pDateFormat;
+(NSDate*)getDateFromString:(NSString*)pStrDate withFormat:(NSString*)pDateFormat;
+(NSMutableString*)getRandomString:(NSInteger)pIntLength;

//NSUserDefaults
+(void)addToNSUserDefaults:(id)pObject forKey:(NSString*)pForKey;
+(void)removeFromNSUserDefaults:(NSString*)pForKey;
+(id)getFromNSUserDefaults:(NSString*)pForKey;

//Local Notification
+(void)setLocalNotification:(NSString *)pStrNotificationTitle;
+(void)setLocalNotificationWithDate:(NSDate *)pDateTime withNotificationTitle:(NSString *)pStrNotificationTitle;
+(void)removeLocalNotificationIfSet:(NSString *)pStrNotificationTitle;

//DocumentDirectory Path
+(NSString*)getDocumentDirectoryPath:(NSString*)pStrPathName;

//Camera Availability
+(UIImagePickerControllerCameraDevice)getAvailableCamera;
+(void)showCamera:(id)pController;
+(void)showPhotoLibrary:(id)pController;
+(BOOL)isCameraDeviceAvailable;
+(BOOL)isFrontCameraDeviceAvailable;
+(BOOL)isRearCameraDeviceAvailable;

//Image resize
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)image withSize:(CGSize)newSize;

//Blank cell
+(UITableViewCell*)getBlankCell:(UITableView*)tableView withText:(NSString*)pStrText;

//Scroll view updown for textfield show properly
+(void)scrollViewUp:(float)pUpvalue withDuration:(float)pDuration withView:(UIView *)pView;
+(void)scrollViewDown:(float)pDownvalue withDuration:(float)pDuration withView:(UIView *)pView;

//Show hide label on record countl
+(void)checkRecordAvailable:(NSMutableArray *)pArrTemp withTable:(UITableView *)pTblTemp withLabel:(UILabel *)pLabel;

//Parse success failure response
+(NSInteger)parseSuccessFailureResponse:(NSString *)xmlData;

//Date Picker Button action
+(void)setDatePickerButtonAction:(DatePickerView *)pView withId:(id)pId;

//Random Number
+(NSNumber*)getRandomNumber:(NSUInteger)from to:(NSUInteger)to;

//Random Integer
+(NSInteger)getRandomInteger:(NSUInteger)from to:(NSUInteger)to;

//Call Number
+(void)callTheNumber:(NSString *)pStrDialedNumber;

//Play tap sound
+(void)playTapSound;

+(BOOL)isValidCreditCard:(NSString*)pStrCreditCard;

//Add and Get Custom objects from UserDefaults
+(void)addCustomObjectToUserDefaults:(id)pObject key:(NSString *)pStrKey;
+(id)getCustomObjectToUserDefaults:(NSString *)pStrKey;

+(BOOL)isRetina;

//For KeyboardNotification
+(void)registerKeyboardNotification:(id)pObserver;
+(void)deRegisterKeyboardNotification:(id)pObserver;

//For Done button in Numeric Keyboard
+(void)addDoneButtonToKeyboard:(id)pActionTarget;
+(void)removeDoneButtonFromKeyboard;

//Converting Float to decimal
+(NSString *)floatToDecimal:(CGFloat)pFltPrice;

+(UIImage *)createImageFromView:(UITableView *)pView;

//For Image From View
+(UIImage *)imageWithView:(UIView *)view;
+(UIImage *)imageFromView:(UIView *)theView;
+(void)RetinaAwareUIGraphicsBeginImageContext:(CGSize)size;

+(void)goToNextTextField:(UITextField *)pTextField;
+(NSString*)getFullURL:(NSString*)pFileName;

+(void)keyboardShow:(UIView *)pTmpView andScrollView:(UIScrollView *)pTmpScrollView;
+(void)keyboardHide:(UIView *)pTmpView andScrollView:(UIScrollView *)pTmpScrollView andHeight:(CGFloat)pFltHeight;

+(void)rateApplication:(NSString*)pStrAppID;
+(void)openInItunes:(NSString *)pStrAppName;

+(NSString*)checkNullStringFromDB:(char *)pChars;

+(CLLocationCoordinate2D)getLatLon:(NSString *)pStrAddress;
@end
