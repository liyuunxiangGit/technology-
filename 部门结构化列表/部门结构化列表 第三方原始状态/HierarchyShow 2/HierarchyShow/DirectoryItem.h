//
//  DirectoryItem.h
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@interface DirectoryItem : UIView
@property (nonatomic, strong) void (^itemClickBlock)(DirectoryItem *item);
@property (nonatomic, strong) Department *departMent;
@property (nonatomic, assign) int index;
@end
