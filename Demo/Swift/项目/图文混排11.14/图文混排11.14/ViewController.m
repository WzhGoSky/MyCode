//
//  ViewController.m
//  图文混排11.14
//
//  Created by WZH on 16/11/14.
//  Copyright © 2016年 limpid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

//目标: 我[爱你]
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //Attachment - 附件
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    attachment.image = [UIImage imageNamed:@"d_aini"];
    //提示 lineHeight 大致和字体的大小相等
    CGFloat height = self.label.font.lineHeight;
    attachment.bounds = CGRectMake(0, -4, height, height);
    
    /**
     frame 和 bounds 区别
     
     frame:x,y 决定当前控件相对于父控件的位置
     bounds: x,y 决定内部子控件相对于远点的位置，就是scrollview的contentOffset
     
     
     */
    //2.图像字符串
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    //3.定义一个可变的属性字符串
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"我"];
    
    //4.拼接图片文本
    [attrStrM appendAttributedString:imageStr];
    
    //设置属性文本
    self.label.attributedText = attrStrM;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
