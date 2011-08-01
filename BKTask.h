#import <Foundation/Foundation.h>

@interface BKTask : NSOperation
{
	NSTask *task;
	NSData *result;
	NSData *errData;
}
- (id)initWithProgram: (NSString*)aProgram
            arguments: (NSArray*)args;
- (int)exitCode;
- (NSData*)standardOutput;
- (NSData*)standardError;
@end
