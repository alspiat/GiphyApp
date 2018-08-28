//
//  GifCollectionViewCell.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifCollectionViewCell.h"
#import "GiphyApp-Swift.h"
#import "UIColor+AppColor.h"

NSString * const gifCellIdentifier = @"gifCollectionViewCellIdentifier";
NSString * const gifCellNibName = @"GifCollectionViewCell";

@interface GifCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation GifCollectionViewCell

- (void)setup:(GifCellViewModel *)viewModel {
    [self.activityIndicator startAnimating];
    self.backgroundColor = [UIColor randomThemeColor];
    self.viewModel = viewModel;
    
    [self bindToViewModel];
    [self.viewModel startImageLoading];
}

- (void)bindToViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.didUpdate = ^{
        [weakSelf viewModelDidUpdate];
    };
}

- (void)viewModelDidUpdate {
    [UIView transitionWithView:self.imageView duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self.activityIndicator stopAnimating];
        self.imageView.image = self.viewModel.image;
    } completion:nil];
}

- (void)prepareForReuse {
    self.imageView.image = nil;
    [self.viewModel cancelImageLoading];
}

@end
