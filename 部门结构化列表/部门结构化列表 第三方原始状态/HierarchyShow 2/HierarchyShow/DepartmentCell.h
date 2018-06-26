//
//  DepartmentCell.h
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@interface DepartmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deparmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deparmentCountLabel;

@property (nonatomic, strong) Department *department;

-(void)setDepartment:(Department *)department;
@end
