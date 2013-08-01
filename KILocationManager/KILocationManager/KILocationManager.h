//
//  KILocationManager.h
//  KILocationManager
//
//  Created by Marcus Kida on 01.08.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface KILocationManager : NSObject

+ (id) sharedManager;

- (void) startUpdatingLocation:(void (^)(NSArray *locations))updateBlock;
- (void) stopUpdatingLocation;

- (CLLocationManager *)locationManager;
- (CLAuthorizationStatus)authorizationStatus;

@end
