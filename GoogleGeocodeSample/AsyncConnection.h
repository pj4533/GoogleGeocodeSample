//
//  AsyncConnection.h
//  
//
//  Created by PJ Gray on 10/9/10.
//  Copyright 2010 Say Goodnight Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncConnection : NSObject {

    NSURLConnection *urlConnection;
    NSMutableData *incomingData;	
}

@property (nonatomic, retain) NSURLConnection *urlConnection;
@property (nonatomic, retain) NSMutableData *incomingData;    // the data returned from the NSURLConnection

- (void)handleError:(NSError *)error;
- (id) initWithRequest:(NSURLRequest*) inRequest;

@end
