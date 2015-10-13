//
//  LJAutoScrollView.m
//  Chitu
//
//  Created by Jinxing Liao on 10/13/15.
//  Copyright © 2015 Jinxing. All rights reserved.
//

#import "LJAutoScrollView.h"
#import "LJAutoScrollCell.h"

@interface LJAutoScrollView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LJAutoScrollView

static NSString *kLJAutoScrollCellID = @"kLJAutoScrollCellID";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.scrollsToTop = NO;
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        [self.collectionView registerClass:[LJAutoScrollCell class] forCellWithReuseIdentifier:kLJAutoScrollCellID];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:self.pageControl];

        self.numberOfPages = 0;
        self.itemSize = frame.size;
        self.scrollInterval = 5.0;
        [self startAutoScroll];
    }
    return self;
}

- (void)dealloc
{
    [self stopAutoScroll];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    [self.pageControl setPageIndicatorTintColor:pageIndicatorTintColor];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    [self.pageControl setCurrentPageIndicatorTintColor:currentPageIndicatorTintColor];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    self.pageControl.numberOfPages = numberOfPages;
    self.pageControl.currentPage = 0;
}

- (NSInteger)internalIndexForCollectionIndex:(NSInteger)index
{
    if (index == 0) {
        return self.numberOfPages - 1;
    } else if (index == self.numberOfPages + 1) {
        return 0;
    } else {
        return index - 1;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfPages) {
        return self.numberOfPages + 2;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfPagesInAutoScrollView:)]) {
        NSInteger count = [self.delegate numberOfPagesInAutoScrollView:self];
        [self setNumberOfPages:count];
        return count + 2;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJAutoScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJAutoScrollCellID forIndexPath:indexPath];
    NSInteger index = [self internalIndexForCollectionIndex:indexPath.item];
    if (self.delegate) {
        UIView *customView = [self.delegate autoScrollView:self customViewForIndex:index];
        [cell setCustomView:customView];
    }
    self.pageControl.currentPage = index;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoScrollView:didSelectItemAtIndex:)]) {
        NSInteger index = [self internalIndexForCollectionIndex:indexPath.item];
        [self.delegate autoScrollView:self didSelectItemAtIndex:index];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

- (void)startAutoScroll
{
    [self stopAutoScroll];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval
                                                  target:self
                                                selector:@selector(scrollToNextPage)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopAutoScroll
{
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)scrollToNextPage
{
    CGPoint offset = self.collectionView.contentOffset;
    NSInteger currentPage = floor(offset.x / self.itemSize.width);
    if (currentPage != self.numberOfPages + 1) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage + 1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (void)resetContentOffset
{
    CGPoint offset = self.collectionView.contentOffset;
    NSInteger page = floor(offset.x / self.itemSize.width);
    if (page == 0) {
        CGFloat offset = self.itemSize.width * self.numberOfPages;
        [self.collectionView scrollRectToVisible:CGRectMake(offset, 0, self.itemSize.width, self.itemSize.height) animated:NO];
    }
    else if (page == self.numberOfPages + 1) {
        CGFloat offset = self.itemSize.width;
        [self.collectionView scrollRectToVisible:CGRectMake(offset, 0, self.itemSize.width, self.itemSize.height) animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resetContentOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self resetContentOffset];
}

@end
