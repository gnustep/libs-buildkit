#import <Foundation/Foundation.h>

@interface BKTaskBuilder : NSObject
{
	NSDictionary *template;
}
- (id)initWithTemplate: (NSDictionary*)aDictionary;
- (BKTask*)taskWithDependencies: (NSArray*)deps
                          input: (id)input
                         output: (out id*)output;
@end

@implementation BKTaskBuilder
- (id)initWithTemplate: (NSDictionary*)aDictionary
{
	if (nil == (self = [super init])) { return nil; }
	ASSIGN(template, aDictionary);
	return self;
}
- (BKTask*)taskWithDependencies: (NSArray*)deps
                          input: (id)input
                         output: (out id*)output;
{

}
@end
