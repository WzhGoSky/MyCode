//
//  ViewController.m
//  7.Refersh
//
//  Created by Hayder on 2016/10/31.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "ZHPullUpFooterView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) ZHPullUpFooterView *footerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView addSubview: self.footerView];
}


#pragma mark --------------------tableViewDelegate&&dataSource------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}

#pragma mark ------------------------setter && getter------------------------
- (NSMutableArray *)dataList
{
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
        
        for (int i=0; i< 15; i++) {
            
            [_dataList addObject:[NSString stringWithFormat:@"原始数据%d",i]];
        }
    }
    
    return _dataList;
}

- (ZHPullUpFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[ZHPullUpFooterView alloc] init];
    }
    
    return _footerView;
}
@end
