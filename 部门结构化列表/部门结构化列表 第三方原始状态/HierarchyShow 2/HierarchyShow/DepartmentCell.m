//
//  DepartmentCell.m
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import "DepartmentCell.h"

@implementation DepartmentCell

-(void)setDepartment:(Department *)department{
    if (department != nil) {
        _department = department;
        self.deparmentNameLabel.text = department.deparmentName;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
