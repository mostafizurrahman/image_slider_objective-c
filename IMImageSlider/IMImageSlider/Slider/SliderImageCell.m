//
//  SliderImageCell.m
//  Yoga
//
//  Created by Mostafizur Rahman on 8/3/18.
//  Copyright © 2018 Mostafizur. All rights reserved.
//

#import "SliderImageCell.h"

@implementation SliderImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupXib];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self setupXib];
    return self;
}

-(void)setupXib{
    [[NSBundle mainBundle] loadNibNamed:@"SliderImageCell" owner:self options:nil];
    self.containerView.frame = self.bounds;
    self.containerView.bounds =  self.bounds;
    [self addSubview:self.containerView];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
