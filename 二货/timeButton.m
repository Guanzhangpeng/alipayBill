//
//  timeButton.m
//  二货
//
//  Created by 管章鹏 on 2018/8/14.
//  Copyright © 2018年 管章鹏. All rights reserved.
//

#import "timeButton.h"

@implementation timeButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 2);
    
    self.imageView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 2);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
