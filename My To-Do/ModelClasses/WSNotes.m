//
//  WSNotes.m
//
//  Created by   on 12/5/18
//  Copyright (c) 2018 __MyCompanyName__. All rights reserved.
//

#import "WSNotes.h"


NSString *const kWSNotesDate = @"date";
NSString *const kWSNotesId = @"id";
NSString *const kWSNotesNote = @"note";


@interface WSNotes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WSNotes

@synthesize date = _date;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize note = _note;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.date = [self objectOrNilForKey:kWSNotesDate fromDictionary:dict];
        self.internalBaseClassIdentifier = [self objectOrNilForKey:kWSNotesId fromDictionary:dict] ;
        self.note = [self objectOrNilForKey:kWSNotesNote fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.date forKey:kWSNotesDate];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kWSNotesId];
    [mutableDict setValue:self.note forKey:kWSNotesNote];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.date = [aDecoder decodeObjectForKey:kWSNotesDate];
    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kWSNotesId];
    self.note = [aDecoder decodeObjectForKey:kWSNotesNote];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_date forKey:kWSNotesDate];
    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kWSNotesId];
    [aCoder encodeObject:_note forKey:kWSNotesNote];
}

- (id)copyWithZone:(NSZone *)zone {
    WSNotes *copy = [[WSNotes alloc] init];
    
    
    
    if (copy) {
        
        copy.date = [self.date copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.note = [self.note copyWithZone:zone];
    }
    
    return copy;
}


@end

