//
//  MapViewController.m
//  socalMap
//
//  Copyright (c) 2015 Prateek Arora All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "JsonParsing.h"

#define kDirectionsURL @"https://maps.googleapis.com/maps/api/place/autocomplete/json?"
@interface MapViewController ()
{
    GMSMapView *mapView_;
    NSDictionary *jsonDiction;
    double searchLatitude ,searchLongtitude,addressMap;
    NSMutableDictionary *addressDictionary,*dataHold;
    NSString *addValue,*latvalue,*longvalue,*locName;
   
    
}
@property (strong, nonatomic) JsonParsing *parseClass;
@property(nonatomic,retain)NSMutableArray *dataSource;
//@property (strong, nonatomic) NSArray *storeData;
@property (strong, nonatomic) NSMutableDictionary *storeData;

-(void) tableRoladData;
@end
@implementation MapViewController
@synthesize searchBar,storeData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //****************Parsing from JsonParsing Class****************//
    
    storeData=[[NSMutableDictionary alloc]init];
    self.parseClass = [[JsonParsing alloc]init];
    self.storeData =(NSMutableDictionary *)[self.parseClass simpleJsonParsing];
    
    
    NSLog(@"store data %@",[storeData description]);
    
    
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, 300, 250)];
    
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    //***************** putting data from function ********//
    tableData=[self arrJSONName];
    tableData = [[NSMutableArray alloc]init];
    
    
}

//***************************************Table Delegates ****************************************//
#pragma mark Table Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

//*********************************** Marker Customization ***************************************//

-(UIView *)customMapView
{
    UIView * mWindow = [[UIView alloc] initWithFrame: CGRectMake (0, 0, 240, 50)];
    
    
    mWindow.backgroundColor = [UIColor whiteColor];
    
    CGRect locLabelFrame=CGRectMake(5, 5, 225, 20);
    UILabel *locLabel=[[UILabel alloc]initWithFrame:locLabelFrame];
    [locLabel setBackgroundColor:[UIColor whiteColor]];
    
    [locLabel setText:locName];
    [locLabel setFont:[UIFont  systemFontOfSize:12]];
    [mWindow addSubview:locLabel];
    
    
    CGRect addresslabelFrame=CGRectMake(5, 25, 225, 20);
    UILabel *addressLabel=[[UILabel alloc]initWithFrame:addresslabelFrame];
    [addressLabel setBackgroundColor:[UIColor whiteColor]];
    
    [addressLabel setText:addValue];
    [addressLabel setFont:[UIFont systemFontOfSize:12]];
    [mWindow addSubview:addressLabel];
    
    
    return mWindow;
    
}

#pragma  mark -TableView Name Filling
-(NSMutableArray *)arrJSONName
{
    
    NSArray *results=storeData[@"results"];
    
    NSMutableArray *textsteps=[[NSMutableArray alloc] init];
    
    for(int i=0; i< [results count]; i++){
        NSString *name=results[i][@"name"];
        
        [textsteps addObject:name];
    }
    NSLog(@"final steps %@",[textsteps description]);
    return textsteps;
    
    
}


#pragma  mark -TableView Lat Long Filling
-(NSMutableArray *)arrJSONlatLong
{
    NSArray *results=storeData[@"results"];
    NSMutableArray *geometry=[[NSMutableArray alloc] init];
    NSMutableArray *finalLocArr=[[NSMutableArray alloc] init];
    
    
    for(int i=0; i< [results count]; i++){
        
        NSArray *latlong=results[i][@"geometry"];
        [geometry addObject:latlong];
        
        NSArray *location=geometry[i][@"location"];
        [finalLocArr addObject:location];
    }
    
    return finalLocArr;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    locationDictionary=[[NSDictionary alloc]init];
    
    locationDictionary= [[self arrJSONlatLong] objectAtIndex:indexPath.row];
    
    
    latvalue = [locationDictionary objectForKey:@"lat"] ;
    longvalue = [locationDictionary objectForKey:@"lng"] ;
    
    locName=[locationDictionary objectForKey:@"name"];
    
    NSLog(@"address=%@, longitude=%@, lat=%@",addValue,latvalue,longvalue);
    
    searchLatitude = [latvalue doubleValue];
    searchLongtitude = [longvalue doubleValue];
    addressMap=[addValue doubleValue];
    
    [self.mapViewer clear] ;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:searchLatitude
                                                            longitude:searchLongtitude
                                                                 zoom:12];
    self.mapViewer.camera=camera;
    self.mapViewer.mapType = kGMSTypeNormal;
    self.mapViewer.delegate=self;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(searchLatitude, searchLongtitude);
    marker.title = addValue;
    
    marker.map = self.mapViewer;
    
    NSLog(@"Adress data %f", searchLongtitude);
    [myTableView removeFromSuperview];
    
    
}


#pragma mark CUSTOM MARKER
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    return  [self customMapView];
}

//***************************** Marker Tap****************************************************//

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    DetailViewController *dvc=[[DetailViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [tableData count];
}

# pragma mark cell for row at index
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text =[tableData objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont  fontWithName:@"Helvetica Neue" size:14]];
    
    return cell;
}

//***************************************** Search Functionality Implementation *****************************//

#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    self.searchBar.showsCancelButton = YES;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:myTableView];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = NO;
    
}

-(void) tableRoladData{
    
    UITableView * selfTable = myTableView;
    [selfTable reloadData];
    
}

//************************************* Global Search Function   *******************************//


# pragma  mark Global Search IMPLEMENTATION

-(NSMutableArray *)arrGlobalSearch:(NSString *)arrGlobal
{

  
    NSString *geocode=@"geocode";
    NSString *key=@"AIzaSyBImt8LcGzR-qnibiOhjvU_xebLiz9yCkY";
    
    
    NSHTTPURLResponse *response = nil;
    
    NSString *jsonUrlString = [NSString stringWithFormat:@"%@input=%@&types=%@&key=%@", kDirectionsURL, arrGlobal, geocode,key];
    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    dataHold = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers  error:nil];
    NSLog(@"Result = %@",result);
    
    
    jsonDiction =[(NSDictionary *)result objectForKey:@"predictions"];
    
    
    NSArray *results=dataHold[@"predictions"];
    
    NSMutableArray *textsteps=[[NSMutableArray alloc] init];
    
    for(int i=0; i< [results count]; i++){
        NSString *name=results[i][@"description"];
        
        [textsteps addObject:name];
    }
    
    
    NSLog(@"final steps %@",[textsteps description]);
    
    return textsteps;
}
//************************************** End of Function ****************************************//



# pragma  mark SEARCH BAR IMPLEMENTATION
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
    
    if([searchText isEqualToString:@""]){
        
        NSString *cap;
        cap=searchText;
        
        _isFiltered = FALSE;
        [myTableView reloadData];
        return;
    }
    else
    
    {
        _isFiltered=TRUE;
    
        
        //************************************* Global Search Function Call  *******************************//
        [self arrGlobalSearch:searchText];
        

        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchText];
        
        tableData=(NSMutableArray*)[[self arrGlobalSearch:searchText] filteredArrayUsingPredicate:predicate];
        
        NSMutableArray *sortedArray = [[NSMutableArray alloc]initWithArray: [tableData
                                                                             sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
        NSLog(@" TABLE DATA %@",[sortedArray description]);
        
        myTableView.hidden=FALSE;
        
        [self tableRoladData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [self.searchBar resignFirstResponder];
    _isFiltered = FALSE;
    self.searchBar.text = @"";
    [myTableView removeFromSuperview];
    [myTableView reloadData];
    
    
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

