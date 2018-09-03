//
//  GifModel.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * _Nonnull const gifIdField = @"id";
static NSString * _Nonnull const gifTitleField = @"title";
static NSString * _Nonnull const gifUsernameField = @"username";
static NSString * _Nonnull const gifPubDateField = @"import_datetime";
static NSString * _Nonnull const gifTrendDateField = @"trending_datetime";
static NSString * _Nonnull const gifRatingField = @"rating";
static NSString * _Nonnull const gifImagesField = @"images";
static NSString * _Nonnull const gifOriginalField = @"original";
static NSString * _Nonnull const gifSizeField = @"size";
static NSString * _Nonnull const gifPreviewField = @"preview_gif";
static NSString * _Nonnull const gifUrlField = @"url";
static NSString * _Nonnull const gifHeightField = @"height";
static NSString * _Nonnull const gifWidthField = @"width";

@protocol GifImageModel <NSObject>

@property (nonnull, nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;

@end

@protocol GifModel <NSObject>

@property (nonnull, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSDate *publishingDate;
@property (nullable, nonatomic, copy) NSDate *trendingDate;
@property (nonnull, nonatomic, retain) id<GifImageModel> previewImage;
@property (nonnull, nonatomic, retain) id<GifImageModel> originalImage;

@end
