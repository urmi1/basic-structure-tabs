//
//  LocationManager.m
//  BasicStructure
//
//  Created by __CompanyName__ on 27/05/13.
//  Copyright (c) 2013 __CompanyName__. All rights reserved.
//

#import "LocationManager.h"

static LocationManager* sharedLocation = nil;

@implementation LocationManager

#define kLatitude 23.012231
#define kLongitude 72.511569

+ (LocationManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocation = [[LocationManager alloc] init];
    });
    return sharedLocation;
}

- (id)init {
 	self = [super init];
	if (self != nil)  {
		_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
		_locationDefined = NO;
		_locationDenied = NO;
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.distanceFilter = 1000.0;   //1609.344 (1 Mile)
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		
		if([Helper isSimulator]) {
			_currentLatitude = kLatitude;
			_currentLongitude = kLongitude;
            [self updateAddress];
		}
		else
			[_locationManager startUpdatingLocation];
	}
	return self;
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
	_locationDefined = YES;
	_locationDenied = NO;
	_currentLatitude = newLocation.coordinate.latitude;
	_currentLongitude = newLocation.coordinate.longitude;    
    [self updateAddress];
}

- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error {
	if([error code]== kCLErrorDenied)
		self.locationDenied = YES;
	
	switch ([error code]) {
        case kCLErrorDenied:
        default:
            break;
    }
	self.locationDefined = NO;	
}

#pragma mark - Address update

-(void)updateAddress{
    [SVGeocoder reverseGeocode:CLLocationCoordinate2DMake(_currentLatitude, _currentLongitude) completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (placemarks.count>0)
            _objPlaceMark = [placemarks objectAtIndex:0];
    }];
}

@end
