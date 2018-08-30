//
//  CoreDataManager.m
//  GiphyApp
//
//  Created by Dmitriy Tarelkin on 29/8/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

#import "CoreDataManager.h"
#import "GifManagedObjectEntity+CoreDataClass.h"
#import "GifManagedObjectImage+CoreDataClass.h"

@implementation CoreDataManager
- (AppDelegate *)appDelegate {
    return ((AppDelegate *)UIApplication.sharedApplication.delegate);
}


- (void)addItem:(GifEntity *)item {
    GifManagedObjectEntity *itemMO = [[GifManagedObjectEntity alloc] initWithItem:item context: [self appDelegate].persistentContainer.newBackgroundContext];
    [[self appDelegate].persistentContainer.viewContext insertObject:itemMO];
    
    //checking existance
    //context saving
    [[self appDelegate] saveContext];
}


- (void)deleteItem:(GifEntity *)item {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:gifEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id == %@", item.id];
    
    NSArray<GifManagedObjectEntity *> *itemMOArray = [[self appDelegate].persistentContainer.newBackgroundContext executeFetchRequest:fetchRequest error:nil];
    
    if (!itemMOArray.firstObject) {
        return;
    }
    
    [[self appDelegate].persistentContainer.viewContext deleteObject:itemMOArray.firstObject];
    
    //save context
    [[self appDelegate] saveContext];
}


- (NSArray<GifEntity *> *)getAllItems {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:gifEntityName];
    
    NSArray<GifManagedObjectEntity *> *itemMOArray = [[self appDelegate].persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray<GifEntity *> *items = [[NSMutableArray alloc] init];
    
    for (GifManagedObjectEntity *itemMO in itemMOArray) {
        GifEntity *item = [[GifEntity alloc] initWith:itemMO];
        [items addObject:item];
    }
    
    return items;
}


- (GifEntity *)getItemWithID:(NSString *)itemID {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:gifEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id == %@", itemID];
    
    GifManagedObjectEntity *itemMO = [[self appDelegate].persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil].firstObject;
    GifEntity * item = [[GifEntity alloc] initWith:itemMO];
    return item;
}


- (BOOL)itemExistsWithID:(NSString *)itemID {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:gifEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"id == %@", itemID];
//    NSArray<GifManagedObjectEntity *> *itemMOArray = [[self appDelegate].persistentContainer.newBackgroundContext executeFetchRequest:fetchRequest error:nil];
   
    if ( [[self appDelegate].persistentContainer.viewContext countForFetchRequest:fetchRequest error:nil] > 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
