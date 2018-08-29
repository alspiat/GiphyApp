//
//  GifListViewController+CollectionView.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/29/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "GifListViewController+CollectionView.h"
#import "GifListViewController.h"
#import "GifCollectionViewCell.h"

@implementation GifListViewController (CollectionView)

// MARK: - Collection View DataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.numberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gifCellIdentifier forIndexPath:indexPath];
    [cell setup:[self.viewModel viewModelForCellAt:indexPath.row]];
    
    [self.viewModel loadDataIfNeededFromIndex:indexPath.row];
    
    return cell;
}

// MARK: - Collection View Delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// MARK: - GifCollectionViewLayout Delegate methods

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForContentAtIndexPath:(NSIndexPath *)indexPath {
    GifCollectionViewLayout *layout = (GifCollectionViewLayout *)self.collectionView.collectionViewLayout;
    CGSize contentSize = [self.viewModel contentSizeAt:indexPath.row];
    return contentSize.height * layout.columnWidth / contentSize.width;
}

@end
