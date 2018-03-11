//
//  SliderImageCell.h
//  Yoga
//
//  Created by Mostafizur Rahman on 8/3/18.
//  Copyright © 2018 Mostafizur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderImageCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *slideImageView;
-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(instancetype)initWithFrame:(CGRect)frame;
@property (readwrite) NSString *imageName;

@end
