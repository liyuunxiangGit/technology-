//
//  ViewController.m
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import "ViewController.h"
#import "HierarchyController.h"
#import "Department.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)pushHierarchy:(id)sender {
    HierarchyController *hierarController = [[HierarchyController alloc] init];
    UINavigationController *hierarchyNavi = [[UINavigationController alloc] initWithRootViewController:hierarController];
    
    [self presentViewController:hierarchyNavi animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
