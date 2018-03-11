//
//  SliderImageView.m
//  Yoga
//
//  Created by Mostafizur Rahman on 8/3/18.
//  Copyright © 2018 Mostafizur. All rights reserved.
//

#import "SliderImageView.h"
#import "SliderImageCell.h"

@interface SliderImageView(){
    BOOL startAnimation;
    CGPoint visibleCellCenter;
}
@end
@implementation SliderImageView

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
    [[NSBundle mainBundle] loadNibNamed:@"SliderImageView" owner:self options:nil];
    self.containerView.frame = self.bounds;
    self.containerView.bounds =  self.bounds;
    [self addSubview:self.containerView];
    
    [self.topCollectionView registerClass:SliderImageCell.class forCellWithReuseIdentifier:@"SCell"];
    [self.bottomCollectionView registerClass:SliderImageCell.class forCellWithReuseIdentifier:@"SCell"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.sectionInset = UIEdgeInsetsZero;
    self.topCollectionView.collectionViewLayout = layout;
    self.bottomCollectionView.collectionViewLayout = layout;
    self.imageArray = [NSMutableArray arrayWithObjects:@"image1.jpg",@"image2.jpg",
                       @"image3.jpg",@"image4.jpg",@"image5.jpg",@"image1.jpg", nil];
    visibleCellCenter = self.topCollectionView.center;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.imageArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SliderImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SCell" forIndexPath:indexPath];
    cell.slideImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return ((UICollectionViewFlowLayout *)collectionViewLayout).itemSize;
}

-(void)startAnimation{
        startAnimation = YES;
        UIApplication * application = [UIApplication sharedApplication];
        if([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
            __block UIBackgroundTaskIdentifier background_task;
            background_task = [application beginBackgroundTaskWithExpirationHandler:^{
                [application endBackgroundTask: background_task];
                background_task = UIBackgroundTaskInvalid;
            }];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                while(startAnimation) {
                    [NSThread sleepForTimeInterval:2];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self loadImageAtIndex];
                    });
                }
                [application endBackgroundTask:background_task];
                background_task = UIBackgroundTaskInvalid;
            });
        }
}

-(void)loadImageAtIndex{
    UICollectionView *vc = self.topCollectionView.hidden ? self.bottomCollectionView : self.topCollectionView;
    CGPoint center = [self convertPoint:vc.center toView:vc];
    __block NSIndexPath *indexPath = [vc indexPathForItemAtPoint:center];
    if (indexPath.row + 1 == _imageArray.count ){
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0 ];
        if(_topCollectionView.hidden){
            [self bringSubviewToFront:_topCollectionView];
            _topCollectionView.hidden = NO;
            _bottomCollectionView.hidden = YES;
            [_bottomCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            vc = _topCollectionView;
        } else {
            [self bringSubviewToFront:_bottomCollectionView];
            _bottomCollectionView.hidden = NO;
            _topCollectionView.hidden = YES;
            [_topCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            vc = _bottomCollectionView;
        }
    }
    [vc scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0 ] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

@end
