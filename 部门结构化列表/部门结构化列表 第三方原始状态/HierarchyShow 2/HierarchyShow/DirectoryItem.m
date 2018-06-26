//
//  DirectoryItem.m
//  HierarchyShow
//
//  Created by linkapp on 2016/12/1.
//  Copyright © 2016年 linkapp. All rights reserved.
//

#import "DirectoryItem.h"

@interface DirectoryItem()
@property (nonatomic, assign) CGFloat itemHeight;
@end

@implementation DirectoryItem


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _itemHeight = frame.size.height;
    }
    return self;
}

-(void)setDepartMent:(Department *)departMent{
    _departMent = departMent;
    // 计算文本一行显示需要的长度
    CGSize maximumLabelSize = CGSizeMake(FLT_MAX, 20);
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    UIColor *color = [UIColor blackColor];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          color, NSForegroundColorAttributeName,
                                          nil];
    CGRect expectedLabelRect = [_departMent.deparmentName boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributesDictionary context:nil];
    CGFloat originX = self.frame.origin.x;
    CGFloat originY = self.frame.origin.y;
    
    UIImageView *hintImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, 6, 12)];
    hintImageView.center = CGPointMake(hintImageView.center.x, self.itemHeight/2);
    hintImageView.image = [UIImage imageNamed:@"geren-back"];
    [self addSubview:hintImageView];
    
    CGFloat maxHintImageX = CGRectGetMaxX(hintImageView.frame);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(maxHintImageX + 3, 0, expectedLabelRect.size.width + 15, self.itemHeight)];
    nameLabel.text = _departMent.deparmentName;
    nameLabel.textColor = [UIColor blackColor];
    [self addSubview:nameLabel];
    
    CGFloat maxhintImageX = CGRectGetMaxX(nameLabel.frame);
    self.frame = CGRectMake(originX, originY, maxhintImageX, self.itemHeight);
    
    self.backgroundColor = [UIColor colorWithRed:((float)((0xf2f2f2 & 0xFF0000) >> 16))/255.0 green:((float)((0xf2f2f2 & 0xFF00) >> 8))/255.0 blue:((float)(0xf2f2f2 & 0xFF))/255.0 alpha:1.0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    NSLog(@"department xxxx : %@",self.departMent.deparmentName);
    switch (tapCount) {
        case 1:
            if (self.itemClickBlock) {
                self.itemClickBlock(self);
            }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
}

@end
