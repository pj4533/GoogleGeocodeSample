//
//  GoogleGeocodeSampleViewController.h
//  GoogleGeocodeSample
//
//  Created by PJ Gray on 7/28/11.
//  Copyright 2011 Say Goodnight Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GoogleGeocodeSampleViewController : UIViewController <MKMapViewDelegate> {
    MKMapView *mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end
