//
//  GifManagedObjectEntity+CoreDataProperties.h
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GifManagedObjectEntity (CoreDataProperties)

+ (NSFetchRequest<GifManagedObjectEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *id;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *rating;
@property (nullable, nonatomic, copy) NSDate *publishingDate;
@property (nullable, nonatomic, copy) NSDate *trendingDate;
@property (nullable, nonatomic, retain) GifManagedObjectImage *previewImage;
@property (nullable, nonatomic, retain) GifManagedObjectImage *originalImage;

@end

NS_ASSUME_NONNULL_END
