//
//  ZHNormalController.m
//  Collectionview
//
//  Created by Hayder on 16/8/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ZHNormalController.h"

static NSString *ID = @"normalCollection";

@interface ZHNormalController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ZHNormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"普通用法";
    
    //1.创建一个布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //1.1设置布局的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //1.2设置每个item的大小
    layout.itemSize = CGSizeMake(60, 60 + arc4random() % 100);
    //1.2.1设置item的估计大小，用于动态设置item的大小，结合自动布局使用
//    layout.estimatedItemSize = CGSizeMake(60, 60);
    //1.3设置列间距
    layout.minimumInteritemSpacing = 10;
    //1.4设置行间距
    layout.minimumLineSpacing = 10;
    //1.5设置头部视图的大小
    layout.headerReferenceSize = CGSizeMake(KSCREENW, 44);
    //1.6设置尾部视图的大小
    layout.footerReferenceSize = CGSizeMake(KSCREENW, 44);
    //1.7设置组的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //1.8设置组的头视图和尾视图是否始终固定在屏幕上边和下边
    layout.sectionHeadersPinToVisibleBounds = NO;
    layout.sectionFootersPinToVisibleBounds = NO;
    
    //2.创建一个collectionView
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENW, KSCREENH) collectionViewLayout:layout];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.backgroundColor = [UIColor whiteColor];
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionview];
}

#pragma mark ------------------------dataSource------------------------
//设置有多少行
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//每组有多少个item 必须实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

//设置每个item的属性  必须实现
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = kRandomColor;
    
    return cell;
}

/**
 *  对头视图或者尾视图进行设置
 *
 *  @param collectionView collectionView
 *  @param kind           用来分别是头部视图还是尾部视图
 *  @param indexPath      位置
 *
 *  @return 头部或者尾部视图对象
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusableViewID = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableViewID = @"headerView";
    } else {
        reusableViewID = @"footerView";
    }
    
    //创建一个头部视图或尾部视图
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusableViewID forIndexPath:indexPath];
    view.backgroundColor = kRandomColor;
    
    return view;
}

//是否允许移动Item
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//移动Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}
#pragma mark ------------------------layoutDelegate------------------------
//设置不同位置Item的大小（如果item大小相同，可以直接利用layout属性实现）
//如果同时实现了属性和代理方法，最后结果以代理方法为主
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//设置item的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5, 5, 5);
}
//设置不同组的列边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
        return 10;
    }else
    {
        return 20;
    }
    
}
//设置不同行的列边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
        return 10;
    }else
    {
        return 20;
    }
}
//设置不同组的itemHeaderView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return  CGSizeMake(KSCREENW, 44);
    }else
    {
        return CGSizeMake(KSCREENW, 88);
    }
    
}
//设置不同组的itemFooterView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        return  CGSizeMake(KSCREENW, 44);
    }else
    {
        return CGSizeMake(KSCREENW, 88);
    }
}

#pragma mark ------------------------Delegate------------------------
//是否可以选中Item，返回NO，则不能选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//是否可以取消选中Item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//已经选中某个item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath; {
    
}

//取消选中某个Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath; {
    
}

//将要加载某个Item时调用的方法
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//将要加载头尾视图时调用的方法
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
}

//已经展示某个Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath; {
    
}

//已经展示某个头尾视图时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath; {
    
}

//是否允许某个Item的高亮，返回NO，则不能进入高亮状态
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath; {
    return YES;
}

//当item高亮时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath; {
    
}

//结束高亮状态时触发的方法
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath; {
    
}

//这个方法设置是否展示长按菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return YES;
}

//这个方法用于设置要展示的菜单选项
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender; {
    return YES;
}

//这个方法用于实现点击菜单按钮后的触发方法,通过测试，只有copy，cut和paste三个方法可以使用
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender; {
    //通过下面的方式可以将点击按钮的方法名打印出来：
    NSLog(@"%@",NSStringFromSelector(action));
}

@end
