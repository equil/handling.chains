//
// Created by Alexey Rogatkin on 01.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCITestSuperPropertyDescriptor.h"

typedef struct
{
    int a;
    int b;
} TestStruct;

@protocol ARHCITestPropertyDescriptor <ARHCITestSuperPropertyDescriptor>

@property (strong, getter=getSO, setter=setSO:) NSObject *strongObject;
@property (nonatomic, retain) NSObject *retainObject;
@property (atomic, copy) NSObject *copyObject;
@property (weak) NSObject *weakObject;
@property (nonatomic, assign) NSObject *assignObject;
@property (nonatomic, readonly) NSObject *readonlyObject;

@property (assign) unsigned long assignUnsignedLong;
@property (nonatomic, readonly) long readonlyLong;
@property (nonatomic, assign) TestStruct assignStructure;
@property (nonatomic, readonly) TestStruct readonlyStructure;
@property (nonatomic, assign) Class assignClass;
@property (nonatomic, readonly) Class readonlyClass;
@property (nonatomic, assign) SEL assignSelector;
@property (nonatomic, readonly) SEL readonlySelector;

@property (nonatomic, readonly) BOOL strongObjectPresented;
@property (nonatomic, readonly) BOOL retainObjectPresented;
@property (nonatomic, readonly) BOOL assignUnsignedLongPP; // Not special Presented accessor: not end with Presented
@property (nonatomic, readonly) int readonlyLongPresented; //Not special Presented accessor: type must be BOOL
@property (nonatomic, readonly) BOOL unknownPresented; // Not special Presented accessor: property unknown undefined


@end