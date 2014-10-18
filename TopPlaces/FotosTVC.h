//
//  FotosTVC.h
//  TopPlaces
//
//  Created by Jose Luis Lucini Reviriego on 12/10/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrDataModel.h"
#import "VisorFotosViewController.h"


@interface FotosTVC : UITableViewController

-(void) initListOfPlaces:(id)place_id withDataModel:(FlickrDataModel*) dataModel;

@end
