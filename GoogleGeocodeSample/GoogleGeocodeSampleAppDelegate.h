//
//  GoogleGeocodeSampleAppDelegate.h
//  GoogleGeocodeSample
//
//  Created by PJ Gray on 7/28/11.
//  Copyright 2011 Say Goodnight Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoogleGeocodeSampleViewController;

@interface GoogleGeocodeSampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GoogleGeocodeSampleViewController *viewController;

@end
