    //
    //  HomeViewController.m
    //  dummyMapApp
    //
    //  Copyright (c) 2015 Prateek Arora All rights reserved.
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
