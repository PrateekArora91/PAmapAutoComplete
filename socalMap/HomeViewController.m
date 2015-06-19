    //
    //  HomeViewController.m
    //  dummyMapApp
    //
    //  Created by Brillio Mac Mini 5 on 2/12/15.
    //  Copyright (c) 2015 Brillio. All rights reserved.
    //

    #import "HomeViewController.h"
    #import "MapViewController.h"
    @interface HomeViewController ()

    @end

    @implementation HomeViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
    }

    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    //************************************** Button Event *****************************//

    - (IBAction)mapBtn:(id)sender {
        
       MapViewController *map=[[MapViewController alloc]init];
      
       [self.navigationController pushViewController:map animated:YES];
    }
    @end
