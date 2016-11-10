//
//  ViewController.m
//  7.Refersh
//
//  Created by Hayder on 2016/10/31.
//  Copyright © 2016年 wangzhenhai. All rights reserved.
//

#import "ViewController.h"
#import "ZHRefersh.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    __weak typeof(self) weakSwlf = self;
    [self.tableView.footerView setFooterRefersh:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSwlf.tableView.footerView endRefershing];
            
            for (int i=0; i< 15; i++) {
                
                [weakSwlf.dataList addObject:[NSString stringWithFormat:@"添加数据%d",i]];
            }
            
            [weakSwlf.tableView reloadData];
            
            
        });
    }];
    
    [self.tableView.headerView setHeaderRefersh:^{
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSwlf.tableView.headerView endRefershing];
            
            for (int i=0; i< 15; i++) {
                
                [weakSwlf.dataList insertObject:[NSString stringWithFormat:@"插入数据%d",i] atIndex:0];
            }
            
            [weakSwlf.tableView reloadData];
            
            
        });
    }];
   
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

- (void)dealloc
{
    NSLog(@"我被释放了");
}
@end
