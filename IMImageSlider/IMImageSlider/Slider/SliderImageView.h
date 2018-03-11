//
//  SliderImageView.h
//  Yoga
//
//  Created by Mostafizur Rahman on 8/3/18.
//  Copyright © 2018 Mostafizur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderImageView : UIView<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *bottomCollectionView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (readwrite) NSMutableArray *imageArray;
-(void)startAnimation;
@end
