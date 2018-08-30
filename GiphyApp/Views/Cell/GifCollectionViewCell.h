//
//  GifCollectionViewCell.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/24/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifCellViewModel;

extern NSString * const gifCellIdentifier;
extern NSString * const gifCellNibName;

@interface GifCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) GifCellViewModel *viewModel;

- (void)setup:(GifCellViewModel *)viewModel;

@end
