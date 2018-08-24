//
//  GifCollectionViewCell.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifCollectionViewCell.h"
#import "GiphyApp-Swift.h"

NSString * const gifCellIdentifier = @"gifCollectionViewCellIdentifier";
NSString * const gifCellNibName = @"GifCollectionViewCell";

@interface GifCollectionViewCell()

@property(nonatomic, strong) GifCellViewModel *viewModel;

@end

@implementation GifCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (void)setup:(GifCellViewModel *)viewModel {
    self.viewModel = viewModel;
}

@end
