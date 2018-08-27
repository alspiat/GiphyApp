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
@property(nonatomic, strong) GifCellViewModel *viewModel;

@end

@implementation GifCollectionViewCell

- (void)setup:(GifCellViewModel *)viewModel {
    self.viewModel = viewModel;
    self.backgroundColor = [UIColor randomThemeColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.viewModel.gifEntity.originImage.url]];
        UIImage *image = [UIImage animatedImageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

@end
