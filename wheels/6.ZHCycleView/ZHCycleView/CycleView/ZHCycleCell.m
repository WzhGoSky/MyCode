//
//  EPCycleCell.m
//  FisheryMarket
//
//  Created by WZH on 16/5/19.
//  Copyright © 2016年 王振海. All rights reserved.
//

#import "ZHCycleCell.h"
#import "UIImageView+Download.h"

@interface ZHCycleCell()

@property (nonatomic, weak) UIImageView *imageview;

@end
@implementation ZHCycleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageview = [[UIImageView alloc] init];
        [self addSubview:imageview];
        self.imageview = imageview;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageview.frame = self.bounds;
}

- (void)setShowImage:(NSString *)showImage
{
    _showImage = showImage;
    
    if ([showImage containsString:@"http"]) {
        
        [self.imageview setImageWithUrl:showImage placeholderImage:[UIImage imageNamed:@"greenColor"]];
        
    }else{
    
        self.imageview.image = [UIImage imageNamed:showImage];
    }
}
@end
