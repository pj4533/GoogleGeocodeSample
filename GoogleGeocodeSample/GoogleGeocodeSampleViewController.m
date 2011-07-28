//
//  GoogleGeocodeSampleViewController.m
//  GoogleGeocodeSample
//
//  Created by PJ Gray on 7/28/11.
//  Copyright 2011 Say Goodnight Software. All rights reserved.
//

#import "GoogleGeocodeSampleViewController.h"
#import "GoogleGeocodeConnection.h"
#import "SBJson.h"

@implementation GoogleGeocodeSampleViewController
@synthesize mapView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(googleGeocodeDataReady:)
                                                 name:kGeocodeResponseNotif
                                               object:nil];	

    
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMap:)];
    [mapView addGestureRecognizer:tapRec];
    [tapRec release];

}

- (void) didTapMap:(UITapGestureRecognizer *)sender {
    GoogleGeocodeConnection* googleGeocode = [[GoogleGeocodeConnection alloc] initWithSearch:@"Fenway Park Boston"];
    [googleGeocode release];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

- (void)mapView:(MKMapView *)thisMapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 800, 800) animated:YES];
}

- (void)googleGeocodeDataReady:(NSNotification *)notif {
    
    [mapView removeAnnotations:[mapView annotations]];
    
	NSString *jsonString = [[NSString alloc]  initWithBytes:[[[notif userInfo] valueForKey:kGeocodeDataResultsKey] bytes]
                                                     length:[[[notif userInfo] valueForKey:kGeocodeDataResultsKey] length] 
                                                   encoding:NSUTF8StringEncoding];
	

    SBJsonParser* parser = [[SBJsonParser alloc] init];
    NSDictionary* jsonObject = [parser objectWithString:jsonString];
    NSArray* resultsArray = [jsonObject objectForKey:@"results"];
    
    if ([resultsArray count] > 0) {
        NSDictionary* dict = [resultsArray objectAtIndex:0];
        
        double lat = [[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        double lng = [[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        
        
        MKCoordinateRegion newRegion; 
        newRegion.center.latitude = lat;
        newRegion.center.longitude = lng;
        
        newRegion.span.latitudeDelta = 0.007;
        
        newRegion.span.longitudeDelta = 0;
        [mapView setRegion:[mapView regionThatFits:newRegion] animated:YES];
        
        
        MKPointAnnotation* thisLoc = [[MKPointAnnotation alloc] init];
        thisLoc.coordinate = CLLocationCoordinate2DMake(lat, lng);
        thisLoc.title = [dict objectForKey:@"formatted_address"];
        [mapView addAnnotation:thisLoc];
        [mapView selectAnnotation:thisLoc animated:YES];
        [thisLoc release];
    }
    [parser release];
    [jsonString release];
}

@end
