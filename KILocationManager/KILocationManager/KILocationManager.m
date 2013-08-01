//
//  KILocationManager.m
//  KILocationManager
//
//  Created by Marcus Kida on 01.08.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "KILocationManager.h"
#import <objc/objc-runtime.h>

@interface KILocationManager () <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (copy) void (^updateBlock)(NSArray *locations);

@end

@implementation KILocationManager

+ (id) sharedManager
{
    static KILocationManager *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[KILocationManager alloc] init];
    });
    return locationManager;
}

- (CLLocationManager *)locationManager
{
    if(!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    return _locationManager;
}

- (CLAuthorizationStatus)authorizationStatus
{
    return [CLLocationManager authorizationStatus];
}

- (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

- (void) startUpdatingLocation:(void (^)(NSArray *locations))updateBlock
{
    [self setUpdateBlock:updateBlock];
    [[self locationManager] startUpdatingLocation];
}

- (void) stopUpdatingLocation
{
    [self setUpdateBlock:nil];
    [[self locationManager] stopUpdatingLocation];
}
- (void) setUpdateBlock:(void (^)(NSArray *locations))updateBlock {
	objc_setAssociatedObject(self, @"updateBlock", [updateBlock copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)(NSArray *locations)) updateBlock {
	return objc_getAssociatedObject(self, @"updateBlock");
}

#pragma mark - CLLocationManager Delegate
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(self.updateBlock)
    {
        self.updateBlock(locations);
    }
}

@end
