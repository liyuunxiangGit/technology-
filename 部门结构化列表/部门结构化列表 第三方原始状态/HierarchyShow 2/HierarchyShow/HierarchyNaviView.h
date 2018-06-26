//
//  HierarchyNaviView.h
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HierarchyNaviViewDelegate <NSObject>
- (void)hierarchyNaviViewDidClickIndex:(NSInteger)index;
@end

@interface HierarchyNaviView : UIView
@property (nonatomic, strong)NSArray *departments;
@property (nonatomic, weak) id<HierarchyNaviViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@end
