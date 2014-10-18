//
//  FlickrDataModel.m
//  TopPlaces
//
//  Created by Jose Luis Lucini Reviriego on 05/10/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "FlickrDataModel.h"

@interface FlickrDataModel()

// TopPlaces API

@property (strong, nonatomic) NSMutableDictionary *photosByCountry;
@property (strong, nonatomic) NSArray *sortedCountries;
@property (strong, nonatomic) NSMutableDictionary *photosByCity;

//Fotos
@property (strong, nonatomic) NSArray *arFlickrPhotos;

@end

@implementation FlickrDataModel

// TopPlaces API

-(void)initPlacesByCountry
{
    NSURL *url = [FlickrFetcher URLforTopPlaces];
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSDictionary *flickrPhotos = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
    NSLog(@"Flickr results = %@", flickrPhotos);
    
    self.photosByCountry = [[NSMutableDictionary alloc] init];
    NSDictionary *places = flickrPhotos[@"places"];
    NSArray *aPlaces = places[@"place"];
    for (id place in aPlaces){
        NSDictionary *dict = [self buildPlaceFromInfo:place];
        NSMutableArray *nsma = self.photosByCountry[dict[@"country"]];
        if (nsma){
            [nsma addObject:dict];
        }else{
            NSMutableArray *aux = [[NSMutableArray alloc] initWithObjects:dict, nil];
            self.photosByCountry[dict[@"country"]] = aux;
        }
    }
    
    NSArray *nsa = [self.photosByCountry allKeys];
    
    self.sortedCountries = [nsa sortedArrayUsingSelector:@selector(compare:)];
}

-(NSInteger)countTopCountries
{
    return [[self.photosByCountry allKeys] count];
}

-(NSInteger)countPlacesAtIndex:(NSInteger)index
{
    NSString *country = self.sortedCountries[index];
    return [self.photosByCountry[country] count];
}

-(NSDictionary*)getCellData:(NSInteger)section index:(NSInteger)index
{
    NSString *country = self.sortedCountries[section];
    return self.photosByCountry[country][index];
}

-(NSDictionary *)buildPlaceFromInfo:(NSDictionary *)place
{
    NSString *city = place[@"woe_name"];
    NSString *province = place[@"_content"];
    NSString *full_address = place[@"place_url"];
    NSString *place_id = place[@"place_id"];
    NSString *country = [full_address componentsSeparatedByString:@"/"][1];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          city, @"city",
                          country, @"country",
                          province, @"province",
                          place_id, @"place_id",
                          nil];
    return dict;
}

// FotosAPI

-(void) initLinksByPlace:(id)place_id
{
    NSURL *url = [FlickrFetcher URLforPhotosInPlace:place_id maxResults:50];
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSDictionary *flickrPhotos = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
    NSLog(@"Flickr results = %@", flickrPhotos);
    
    NSDictionary *photos = flickrPhotos[@"photos"];
    self.arFlickrPhotos = photos[@"photo"];
}

-(NSDictionary*)getPhotoAtIndex:(NSInteger)index
{
    return self.arFlickrPhotos[index];
}

-(NSInteger)countNumberOfLinks
{
    return self.arFlickrPhotos.count;
}

@end
