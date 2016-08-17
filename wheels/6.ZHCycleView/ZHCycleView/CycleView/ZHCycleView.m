//
//  EPCycleView.m
//  FisheryMarket
//
//  Created by WZH on 16/5/18.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ZHCycleView.h"
#import "ZHCycleCell.h"


static CGFloat const Section = 100;
static CGFloat pageControlWith = 120;
static CGFloat pageControlHieght = 30;

@interface ZHCycleView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger _currentItem;
    NSInteger _currentSection;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ZHCycleView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        
        [self addSubview:self.pageControl];
    }
    
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:Section/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    _currentItem = 0;
    
    // 添加定时器
    [self addTimer];
    
    [self setUpPageControl];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.frame = CGRectMake(self.bounds.size.width - pageControlWith, self.bounds.size.height - pageControlHieght, pageControlWith, pageControlHieght);
    self.pageControl.numberOfPages = self.imageArr.count == 0?self.urlArr.count : self.imageArr.count;
}
#pragma mark --------------------------CollectionViewdelegate-----------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return Section;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.urlArr ? self.urlArr.count : self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cycleCell";
    ZHCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.showImage = self.urlArr ? self.urlArr[indexPath.item] : self.imageArr[indexPath.item];
    
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectedViewAtIndex:)]) {
        
        [self.delegate cycleView:self didSelectedViewAtIndex:indexPath.row];
    }
}
#pragma mark --------------------------scrollviewDelegate----------------------------------------

/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
    
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count = self.imageArr.count == 0?self.urlArr.count : self.imageArr.count;
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width + 0.5)%count;
    self.pageControl.currentPage = page;
}

#pragma mark --------------------------privateFunc-----------------------------------------
- (void)setUpPageControl
{
    //pageControl 颜色
    if(self.currentTintColor)
    {
        self.pageControl.currentPageIndicatorTintColor = self.currentTintColor;
    }
    
    if (self.indicatorTintColor) {
        
        self.pageControl.pageIndicatorTintColor = self.indicatorTintColor;
    }
}
/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    
    if (nextItem ==  (self.urlArr == nil ? self.imageArr.count : self.urlArr.count)) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    //4.设置页码
    self.pageControl.currentPage = nextItem;
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:Section/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPathReset;
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark --------------------------lazyLoading-----------------------------------------
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.userInteractionEnabled = NO;
    }
    
    return _pageControl;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        
        static NSString *cellID = @"cycleCell";
        [_collectionView registerClass:[ZHCycleCell class] forCellWithReuseIdentifier:cellID];
    }
    
    return _collectionView;
}

@end
