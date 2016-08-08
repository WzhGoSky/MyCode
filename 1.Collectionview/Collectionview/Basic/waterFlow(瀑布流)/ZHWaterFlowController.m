//
//  ZHWaterFlowController.m
//  Collectionview
//
//  Created by Hayder on 16/8/6.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ZHWaterFlowController.h"

static NSString *ID = @"waterFlowCollection";
static CGFloat const minimumInteritemSpacing = 10;
static CGFloat const minimumLineSpacing  = 10;
static NSInteger maxColumns = 3;

@interface ZHWaterFlowController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 *  所有高度的数组
 */
@property (nonatomic, strong) NSMutableArray *heightArr;

@end

@implementation ZHWaterFlowController

- (NSMutableArray *)heightArr
{
    if (!_heightArr) {
        
        _heightArr = [NSMutableArray array];
    }
    return _heightArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"瀑布流";
    
    //1.创建一个布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    layout.minimumLineSpacing = minimumLineSpacing;
    
    //2.创建一个collectionView
    UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KSCREENW, KSCREENH) collectionViewLayout:layout];
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.backgroundColor = [UIColor whiteColor];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionview];
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
    
    //重新设置cell的frame
    NSInteger remainder=indexPath.row%maxColumns; // y
    NSInteger currentRow=indexPath.row/maxColumns; //x
    
    CGFloat width = (KSCREENW - (maxColumns + 1) * minimumLineSpacing) / maxColumns;
    CGFloat currentHeight=[self.heightArr[indexPath.row] floatValue];
    
    CGFloat positonX=width*remainder + minimumLineSpacing*(remainder+1);
    CGFloat positionY=(currentRow+1) * minimumInteritemSpacing;
    
    for (NSInteger i=0; i<currentRow; i++) {
        
        NSInteger position=remainder+i*maxColumns;
        positionY+=[self.heightArr[position] floatValue];
    }
    cell.frame = CGRectMake(positonX, positionY,width,currentHeight) ;
    cell.backgroundColor = kRandomColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (KSCREENW - (maxColumns+1) * minimumLineSpacing) / maxColumns;
    //设置每个item width相同 高度不同
    CGFloat height = width + arc4random() % 80;
    
    //保存高度
    [self.heightArr addObject:@(height)];
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
@end
