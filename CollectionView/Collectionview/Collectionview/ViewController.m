//
//  ViewController.m
//  Collectionview
//
//  Created by Hayder on 16/8/4.
//  Copyright © 2016年 wangzhenhai. All rights reserved.

//  整理一个关于collectionView用法的Demo

#import "ViewController.h"
#import "header.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CollectionView的使用";
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
}

#pragma mark ------------------------tableviewDelegate------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataArr[section] objectForKey:@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSArray *data = [self.dataArr[indexPath.section] objectForKey:@"data"];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionNameLabel = [[UILabel alloc] init];
    sectionNameLabel.text = [self.dataArr[section] objectForKey:@"sectionName"];
    
    return sectionNameLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[self getCntrollerClassWithIndexPath:indexPath]);
    
    Class cls = [self getCntrollerClassWithIndexPath:indexPath];
    
    [self.navigationController pushViewController:[[cls alloc] init] animated:YES];
}

#pragma mark ------------------------lazyLoading------------------------
- (NSArray *)dataArr
{
    if (!_dataArr) {
        
        _dataArr = @[@{@"sectionName":@"基础",@"data":@[@"普通用法 ZHNormalController",@"瀑布流 ZHWaterFlowController"]},
                     @{@"sectionName":@"高级",@"data":@[]}];
    }
    return _dataArr;
}

- (Class)getCntrollerClassWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *target = self.dataArr[indexPath.section][@"data"][indexPath.row];
    NSArray *components = [target componentsSeparatedByString:@" "];
    return NSClassFromString(components[1]);
}

@end
