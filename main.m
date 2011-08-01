#import "BKTask.h"

int main(void)
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	BKTask *task = [[BKTask alloc] initWithProgram: @"ls" arguments: nil];
	BKTask *task1 = [[BKTask alloc] initWithProgram: @"echo" arguments: [NSArray arrayWithObject: @"foo"]];
	BKTask *task2 = [[BKTask alloc] initWithProgram: @"echo" arguments: [NSArray arrayWithObject: @"bar"]];
	[task addDependency: task1];
	[task addDependency: task2];
	[task1 addDependency: task2];
	NSOperationQueue *q = [NSOperationQueue new];
	[q addOperation: task];
	[q addOperation: task1];
	[q addOperation: task2];
	[q waitUntilAllOperationsAreFinished];
	return 0;
}
