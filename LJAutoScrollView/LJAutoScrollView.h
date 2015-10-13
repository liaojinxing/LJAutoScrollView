//
//  LJAutoScrollView.h
//  Chitu
//
//  Created by Jinxing Liao on 10/13/15.
//  Copyright © 2015 Jinxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJAutoScrollView;
@protocol LJAutoScrollViewDelegate <NSObject>

@required
- (UIView *)autoScrollView:(LJAutoScrollView *)autoScrollView customViewForIndex:(NSInteger)index;

@optional
- (NSInteger)numberOfPagesInAutoScrollView:(LJAutoScrollView *)autoScrollView;
- (void)autoScrollView:(LJAutoScrollView *)autoScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LJAutoScrollView : UIView

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) NSInteger numberOfPages;

/* Interval in seconds for scrollView to auto scroll, default is 5.0 */
@property (nonatomic, assign) CGFloat scrollInterval;

@property (nonatomic, weak) id<LJAutoScrollViewDelegate> delegate;

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

- (void)reloadData;

- (void)startAutoScroll;

- (void)stopAutoScroll;

@end
