//
//  LocationManager.h
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SVPlacemark.h"
#import "SVGeocoder.h"

@class AppDelegate;

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) SVPlacemark *objPlaceMark;

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, assign) BOOL locationDefined;
@property (nonatomic, assign) BOOL locationDenied;
@property (nonatomic, assign) double currentLatitude;
@property (nonatomic, assign) double currentLongitude;

+ (LocationManager*)sharedInstance; // Singleton method

@end
