//
//  FlickrDataModel.h
//  TopPlaces
//
//  Created by Jose Luis Lucini Reviriego on 05/10/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrFetcher.h"

@interface FlickrDataModel : NSObject

// TopPlaces API
-(void) initPlacesByCountry ;
-(NSInteger) countTopCountries;
-(NSInteger) countPlacesAtIndex:(NSInteger)index;
-(NSDictionary*)getCellData:(NSInteger)section index:(NSInteger)index;

// Fotos API
-(void) initLinksByPlace:(id)place_id ;
-(NSDictionary*)getPhotoAtIndex:(NSInteger)index;
-(NSInteger) countNumberOfLinks;

@end
