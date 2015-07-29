    //
    //  JsonParsing.h
    //
    //  Created by matrix on 2/26/15.
    //  Copyright (c) 2015 Prateek Arora All rights reserved.


    #import <Foundation/Foundation.h>
    #import <CoreLocation/CoreLocation.h>
    @interface JsonParsing : NSObject
    {
        NSMutableDictionary *mapData,*result,*dataHold;
    }
    -(NSMutableArray *)simpleJsonParsing;
-(NSMutableArray *)arrGlobalSearch:(NSString *)arrGlobal;
@property(nonatomic) CLLocationCoordinate2D location;

    -(NSData *)jsonData;
    @end

