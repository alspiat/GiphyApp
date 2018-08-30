//
//  GifManagedObjectEntity+CoreDataClass.m
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/30/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//
//

#import "GifManagedObjectEntity+CoreDataClass.h"
#import "GifManagedObjectImage+CoreDataClass.h"
#import "GiphyApp-Swift.h"

NSString * const gifEntityName = @"GifManagedObjectEntity";

@implementation GifManagedObjectEntity

@dynamic id;
@dynamic publishingDate;
@dynamic title;
@dynamic trendingDate;
@dynamic username;
@dynamic originalImage;
@dynamic previewImage;

+ (NSFetchRequest<GifManagedObjectEntity *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:gifEntityName];
}

- (GifManagedObjectEntity*)initWithItem:(GifEntity *)item context:(NSManagedObjectContext *)context {
    
    GifManagedObjectEntity *gifMO = [NSEntityDescription insertNewObjectForEntityForName:gifEntityName inManagedObjectContext:context];
    
    //properties
    [gifMO setId: item.id];
    gifMO.title = item.title;
    gifMO.username = item.username;
    gifMO.publishingDate = item.publishingDate;
    gifMO.trendingDate = item.trendingDate;
    
    //images
    gifMO.originalImage = [[GifManagedObjectImage alloc] initWithImage:item.originalImage context:context];
    gifMO.previewImage = [[GifManagedObjectImage alloc] initWithImage:item.previewImage context:context];
    return gifMO;
}

@end
