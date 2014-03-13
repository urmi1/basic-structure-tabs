/*
 *  Constants.h
 *  BasicStructure
 *
 *  Created by _MyCompanyName_ on 31/08/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#define isiPad     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isiPhone   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isiPhone5  (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)


#ifdef DEBUG
    #define kWebserviceURL @"demo url"
#else
    #define kWebserviceURL @"live url"
#endif

#define kDatabaseName @"DBName.sqlite"
#define kRandomPasswordString @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

#define DegreesToRadians(degrees) (degrees * M_PI / 180)
#define RadiansToDegrees(radians) (radians * 180/M_PI)
#define	kMeterToMile 0.000621371192

#define kGeoCodingString @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"

#define kNotificationMessage @"Notification Message."
#define kRemindMeNotificationDataKey @"kRemindMeNotificationDataKey"

#define kUserDirectoryPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

//For Success Failure Duplicate Response
#define kResponseSuccess 1
#define kResponseFailure 2
#define kResponseDuplicate 3

#define kPleaseWait @"Please wait..."
#define kDateFormat @"yyyy-MM-dd"