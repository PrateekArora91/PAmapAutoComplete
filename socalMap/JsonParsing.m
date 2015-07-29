    //
    //  JsonParsing.m
    //
    //
    //  Created by matrix on 2/26/15.
    //  Copyright (c) 2015 Prateek Arora All rights reserved.
    //

#import "JsonParsing.h"
#define kDirectionsURL @"https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    @implementation JsonParsing

    {
        NSDictionary *jsonDiction;
        double searchLatitude;
        double searchLongtitude;
        double addressMap;
        float radiusMeters;
        NSMutableArray *filteredResult;
        NSMutableDictionary *addressDictionary;
        NSString *addValue,*latvalue,*longvalue,*locName;
        
        
        NSString *_apiKey;
        NSString *_language;
        
    }

    //************************************** Fetching data from URL And Parsing ***********************************//



    -(NSData *)jsonData
    {
        //-- Make URL request with server
        NSHTTPURLResponse *response = nil;
        NSString *jsonUrlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.748234,-73.987454&radius=4000&types=parking&key=AIzaSyCFVoho8PC86L6eaLBbkl88cdLBZfbxLRA"];
        NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        //-- Get request and response though URL
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];

        return responseData;

    }

    //************************************** Data return ***********************************//

    - (NSMutableDictionary *)simpleJsonParsing
    {
        result = [NSJSONSerialization JSONObjectWithData: [self jsonData] options:NSJSONReadingMutableContainers  error:nil];
        NSLog(@"Result = %@",result);
        
        
        jsonDiction =[(NSDictionary *)result objectForKey:@"results"];
       
        
//        
//        lhi        
        return result;

        
}
-(NSMutableArray *)arrGlobalSearch:(NSString *)arrGlobal
{
    
    
    NSString *geocode=@"geocode";
    NSString *key=@"AIzaSyCFVoho8PC86L6eaLBbkl88cdLBZfbxLRA";
    
    
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


@end
