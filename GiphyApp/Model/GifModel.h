//
//  GifModel.h
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import <Foundation/Foundation.h>

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
