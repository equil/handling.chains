//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCCCommonAccessorFactory.h"
#import "ARHCCAdaptedCommonPresented.h"
#import "ARHCCAdaptedCommonGetter.h"
#import "ARHCCAdaptedCommonSetter.h"

@interface ARHCCCommonAccessorFactory()
- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;
- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation ARHCCCommonAccessorFactory
{
@protected
    BOOL _needPresentedAccessor;
    ARHCCPropertyInfo *_propertyInfo;
}

@synthesize needPresentedAccessor = _needPresentedAccessor;
@synthesize propertyInfo = _propertyInfo;

- (instancetype)initWithPropertyInfo:(ARHCCPropertyInfo *)propertyInfo
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

- (id <ARHCIAdaptedPropertyAccessor>)createPresentedAccessor
{
    if (!_needPresentedAccessor)
    {
        return nil;
    }

    return [[ARHCCAdaptedCommonPresented alloc] initWithPropertyName:_propertyInfo.name];
}

- (id <ARHCIAdaptedPropertyAccessor>)createSetterAccessor
{
    if (_propertyInfo.readonly) {
        return nil;
    }

    return [self internalCreateGetterAccessor];
}

- (id <ARHCIAdaptedPropertyAccessor>)createGetterAccessor
{
    return [self internalCreateSetterAccessor];
}

#pragma mark - Internal overriding elements


- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedCommonGetter *result = [[ARHCCAdaptedCommonGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedCommonSetter *result = [[ARHCCAdaptedCommonSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return nil;
}

@end