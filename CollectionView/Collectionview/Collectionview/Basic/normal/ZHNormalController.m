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
    
    //1.创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, KSCREENW, KSCREENH - 20) collectionViewLayout:layout];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.backgroundColor = [UIColor whiteColor];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionview];

}

#pragma mark collectionDelegate && dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = kRandomColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (KSCREENW - 20)/2;
    CGFloat height = width * 0.8 + 112;
    return  CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5, 5, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



@end
