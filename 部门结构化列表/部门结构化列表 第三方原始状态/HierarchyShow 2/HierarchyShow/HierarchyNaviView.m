//
//  HierarchyNaviView.m
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import "HierarchyNaviView.h"
#import "DirectoryItem.h"

@interface HierarchyNaviView()
@property (nonatomic, assign) CGFloat kHierarchyNaviViewHeigth;
@end

@implementation HierarchyNaviView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        if (frame.size.height < 1) {
            self.kHierarchyNaviViewHeigth = 44;
        }else{
            self.kHierarchyNaviViewHeigth = frame.size.height;
        }
    }
    return self;
}

- (void)setDepartments:(NSArray *)departments{
    _departments = departments;
    if (_departments != nil && _departments.count > 0) {
        CGFloat originalX = 0.0;
        for (int i = 0; i < self.departments.count; i++){
            Department *dep = self.departments[i];
            DirectoryItem *item = [[DirectoryItem alloc] initWithFrame:CGRectMake(originalX, 0, 0, self.kHierarchyNaviViewHeigth)];
            item.index = i;
            item.departMent = dep;
            item.itemClickBlock = ^(DirectoryItem *item){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(hierarchyNaviViewDidClickIndex:)]) {
                        [self.delegate hierarchyNaviViewDidClickIndex:item.index];
                    }
                });
            };
            originalX = CGRectGetMaxX(item.frame);
            [self.scrollView addSubview:item];
        }
        self.scrollView.contentSize = CGSizeMake(originalX, self.kHierarchyNaviViewHeigth);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}



-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.scrollEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

@end
