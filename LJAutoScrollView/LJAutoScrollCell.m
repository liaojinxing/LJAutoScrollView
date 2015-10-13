//
//  LJAutoScrollCell.m
//  Chitu
//
//  Created by Jinxing Liao on 10/13/15.
//  Copyright © 2015 linkedin. All rights reserved.
//

#import "LJAutoScrollCell.h"

@implementation LJAutoScrollCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)setCustomView:(UIView *)customView
{
    if (_customView) {
        [_customView removeFromSuperview];
    }
    _customView = customView;
    [customView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.contentView addSubview:customView];
}

@end
