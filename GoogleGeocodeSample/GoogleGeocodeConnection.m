//
//  GooglePlacesConnection.m
//  GovConTrack
//
//  Created by PJ Gray on 6/29/11.
//  Copyright 2011 Say Goodnight Software. All rights reserved.
//

#import "GoogleGeocodeConnection.h"


@implementation GoogleGeocodeConnection

NSString *kGeocodeResponseNotif = @"GeocodeResponseNotif";
NSString *kGeocodeDataResultsKey = @"ServiceDataResultsKey";

- (id) initWithSearch:(NSString*) searchString {
	
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSMutableString* stringForURL = [NSMutableString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",searchString];
    	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringForURL]];
	
	thisAction = [NSString stringWithString:kGeocodeResponseNotif];
	self = [super initWithRequest:request];
	
	return self;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[super connectionDidFinishLoading:connection];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:thisAction
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:incomingData
                                                                                           forKey:kGeocodeDataResultsKey]]; 
}


@end
