//
//  GooglePlacesConnection.h
//  GovConTrack
//
//  Created by PJ Gray on 6/29/11.
//  Copyright 2011 Say Goodnight Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncConnection.h"

extern NSString *kGeocodeResponseNotif;
extern NSString *kGeocodeDataResultsKey;

@interface GoogleGeocodeConnection : AsyncConnection {
  	NSString* thisAction;  
}
- (id) initWithSearch:(NSString*) searchString;

@end
