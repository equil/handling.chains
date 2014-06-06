//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CCommonAccessorFactory.h"
#import "CAdaptedCommonPresented.h"
#import "CAdaptedCommonGetter.h"
#import "CAdaptedCommonSetter.h"

@interface CCommonAccessorFactory ()
- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;
- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation CCommonAccessorFactory
{
@protected
    BOOL _needPresentedAccessor;
    ARHCPropertyInfo *_propertyInfo;
}

@synthesize needPresentedAccessor = _needPresentedAccessor;
@synthesize propertyInfo = _propertyInfo;

- (instancetype)initWithPropertyInfo:(ARHCPropertyInfo *)propertyInfo
               needPresentedAccessor:(BOOL)needPresentedAccessor
{
    self = [super init];
    if (self)
    {
        _needPresentedAccessor = needPresentedAccessor;
        _propertyInfo = propertyInfo;
    }

    return self;
}

#pragma mark - Public interface behavior

- (id <IAdaptedPropertyAccessor>)createPresentedAccessor
{
    if (!_needPresentedAccessor)
    {
        return nil;
    }

    return [[CAdaptedCommonPresented alloc] initWithPropertyName:_propertyInfo.name];
}

- (id <IAdaptedPropertyAccessor>)createSetterAccessor
{
    if (_propertyInfo.readonly) {
        return nil;
    }

    return [self internalCreateSetterAccessor];
}

- (id <IAdaptedPropertyAccessor>)createGetterAccessor
{
    return [self internalCreateGetterAccessor];
}

#pragma mark - Internal overriding elements


- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedCommonGetter *result = [[CAdaptedCommonGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedCommonSetter *result = [[CAdaptedCommonSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return nil;
}

@end