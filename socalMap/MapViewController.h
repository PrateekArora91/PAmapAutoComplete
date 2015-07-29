//
//  MapViewController.h
//
//  Copyright (c) 2015 Prateek Arora All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "SelectedLocation.h"

@class JsonParsing;
@interface MapViewController : UIViewController<GMSMapViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

    {
        UITableView *myTableView;
        NSMutableArray *tableData;//will be storing data that will be displayed in table
        NSMutableArray *result;
        NSDictionary *locationDictionary;
        
    }
@property SelectedLocation *selectedLocation;
@property (weak, nonatomic) IBOutlet GMSMapView *mapViewer;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;
@end
