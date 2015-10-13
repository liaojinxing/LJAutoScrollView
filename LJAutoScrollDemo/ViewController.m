//
//  ViewController.m
//  LJAutoScrollDemo
//
//  Created by Jinxing Liao on 10/13/15.
//  Copyright © 2015 Jinxing Liao. All rights reserved.
//

#import "ViewController.h"
#import "LJAutoScrollView.h"

@interface ViewController ()<LJAutoScrollViewDelegate>

@property (nonatomic, strong) LJAutoScrollView *autoScrollView;

@end

static const CGFloat kAutoScrollViewHeight = 200;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoScrollView = [[LJAutoScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAutoScrollViewHeight)];
    self.autoScrollView.delegate = self;
    self.autoScrollView.itemSize = CGSizeMake(self.view.frame.size.width, kAutoScrollViewHeight);
    self.autoScrollView.scrollInterval = 3.0f;
    [self.view addSubview:self.autoScrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.autoScrollView startAutoScroll];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.autoScrollView stopAutoScroll];
}

- (UIView *)autoScrollView:(LJAutoScrollView *)autoScrollView customViewForIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAutoScrollViewHeight)];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextColor:[UIColor whiteColor]];
    label.textAlignment = NSTextAlignmentCenter;
    [label setText:@(index).stringValue];
    return label;
}

- (NSInteger)numberOfPagesInAutoScrollView:(LJAutoScrollView *)autoScrollView
{
    return 5;
}

- (void)autoScrollView:(LJAutoScrollView *)autoScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"select item at index:%@", @(index));
}

@end
