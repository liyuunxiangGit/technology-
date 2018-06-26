//
//  HierarchyController.m
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import "HierarchyController.h"
#import "DepartmentCell.h"
#import "UserCell.h"
#import "HierarchyNaviView.h"

@interface HierarchyController ()<UITableViewDelegate,UITableViewDataSource,HierarchyNaviViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSArray *deparmentArray;
@property (nonatomic, strong) HierarchyNaviView *hierarchView;

// 搜索视图及控制器
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UIViewController *resultsTableController;

@end


#define KHierarchViewHeight 44

#define DepartmentCellIdentifer @"DepartmentCellIdentifer"
#define UserCellIcdentifier @"UserCellIcdentifier"

@implementation HierarchyController

-(UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = YES;
        self.definesPresentationContext = true;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.deparment == nil) {
        self.title = @"Root";
    }else{
        self.title = self.deparment.deparmentName;
    }
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DepartmentCell" bundle:nil] forCellReuseIdentifier:DepartmentCellIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:UserCellIcdentifier];
    [self.tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"HeaderNvaigationCell"];
    
    if (self.navigationController.viewControllers.count == 1) {
        Department *dep= [[Department alloc] init];
        dep.deparmentName = @"开发部";
        
        Department *dep1= [[Department alloc] init];
        dep1.deparmentName = @"技术部";
        
        Department *dep2= [[Department alloc] init];
        dep2.deparmentName = @"观影部";
        
        self.deparmentArray = @[dep,dep1,dep2];
        [self.tableView reloadData];
    }else if (self.deparmentArray.count == 0) {
        Department *dep= [[Department alloc] init];
        dep.deparmentName = @"语文组";
        
        Department *dep1= [[Department alloc] init];
        dep1.deparmentName = @"数学部";
        
        Department *dep2= [[Department alloc] init];
        dep2.deparmentName = @"数据库组";
        
        Department *dep3= [[Department alloc] init];
        dep3.deparmentName = @"飞天组";
        
        Department *dep4= [[Department alloc] init];
        dep4.deparmentName = @"下地组";
        
        self.deparmentArray = @[dep,dep1,dep2,dep3,dep4];
        [self.tableView reloadData];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.hierarchView != nil) {
        if (self.hierarchView.scrollView.contentSize.width > self.hierarchView.frame.size.width) {
            CGPoint offsetPoint = CGPointMake(self.hierarchView.scrollView.contentSize.width - self.hierarchView.frame.size.width, 0);
            [self.hierarchView.scrollView setContentOffset:offsetPoint animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.navigationController.viewControllers.count > 1) {
        return self.deparmentArray.count + 1;
    }else{
        return self.deparmentArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && self.navigationController.viewControllers.count > 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderNvaigationCell" forIndexPath:indexPath];
        HierarchyNaviView *hierarchView = [[HierarchyNaviView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, KHierarchViewHeight)];
        self.hierarchView = hierarchView;
        hierarchView.delegate = self;
        NSMutableArray *departmentArray = [NSMutableArray array];
        for (int i = 0; i < self.navigationController.viewControllers.count; i ++) {
            HierarchyController *hierarchController = self.navigationController.viewControllers[i];
            if (hierarchController.deparment != nil) {
                [departmentArray addObject:hierarchController.deparment];
            }
        }
        hierarchView.departments = departmentArray;
        [cell.contentView addSubview:hierarchView];
        return cell;
    }else{
        DepartmentCell *cell = [tableView dequeueReusableCellWithIdentifier:DepartmentCellIdentifer forIndexPath:indexPath];
        Department *dep;
        if (self.navigationController.viewControllers.count > 1) {
            dep = self.deparmentArray[indexPath.row - 1];
        }else{
            dep = self.deparmentArray[indexPath.row];
        }
        cell.department = dep;
        cell.deparmentCountLabel.text = [NSString stringWithFormat:@"%ld",self.deparmentArray.count];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
    }else{
        Department *dep = self.deparmentArray[indexPath.row - 1];
        HierarchyController *hierarController = [[HierarchyController alloc] init];
        hierarController.deparment = dep;
        [self.navigationController pushViewController:hierarController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KHierarchViewHeight;
    }else{
        return 60;
    }

}

#pragma -mark HierarchyNaviViewDelegate

- (void)hierarchyNaviViewDidClickIndex:(NSInteger)index{
    HierarchyController *cocntroller = self.navigationController.viewControllers[index + 1];
    [self.navigationController popToViewController:cocntroller animated:YES];
}

- (void)gotoRootViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController {

}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

@end
