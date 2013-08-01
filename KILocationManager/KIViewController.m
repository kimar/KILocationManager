//
//  KIViewController.m
//  KILocationManager
//
//  Created by Marcus Kida on 01.08.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "KIViewController.h"
#import "KILocationManager.h"

@implementation KIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[KILocationManager sharedManager] startUpdatingLocation:^(NSArray *locations) {
        NSLog(@"Locations: %@", locations);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
