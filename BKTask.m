#import "BKTask.h"
#include <unistd.h>

@implementation BKTask
- (id)initWithProgram: (NSString*)aProgram
            arguments: (NSArray*)args
{
	if (nil == (self = [super init])) { return nil; }
	task = [NSTask new];
	NSFileManager *fm = [NSFileManager defaultManager];
	// If the program name works as a path, use it.  Otherwise look for the
	// program in the environment
	if ([fm isExecutableFileAtPath: aProgram])
	{
		[task setLaunchPath: aProgram];
	}
	else
	{
		NSString *pathenv = [[[NSProcessInfo processInfo] environment] objectForKey: @"PATH"];
		NSArray *paths = [pathenv componentsSeparatedByString: @":"];
		for (NSString *path in paths)
		{
			path = [path stringByAppendingPathComponent: aProgram];
			if ([fm isExecutableFileAtPath: path])
			{
				[task setLaunchPath: path];
				break;
			}
		}
	}
	[task setArguments: args];
	NSPipe *out = [NSPipe new];
	NSPipe *err = [NSPipe new];
	[task setStandardOutput: out];
	[task setStandardError: err];
	[out release];
	[err release];
	return self;
}
- (void)dealloc
{
	[task release];
	[result release];
	[errData release];
	[super dealloc];
}
- (void)main
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	for (BKTask *dep in [self dependencies])
	{
		if ([dep exitCode] != 0)
		{
			NSLog(@"Dependency %@ failed!", dep);
		}
	}
	@try
	{
		NSLog(@"Launching %@", self);
		[task launch];
		while ([task isRunning])
		{
			if ([self isCancelled])
			{
				[task terminate];
			}
			// Don't compete with the task itself for CPU time...
			usleep(100);
		}
		result = [[[[task standardOutput] fileHandleForReading] readDataToEndOfFile] retain];
		errData = [[[[task standardError] fileHandleForReading] readDataToEndOfFile] retain];
	}
	// Ignore invalid argument exception
	@catch(id e) {}
	@finally
	{
		[pool release];
	}
}
- (NSString*)description
{
	NSMutableString *str = [[task launchPath] mutableCopy];
	for (NSString *arg in [task arguments])
	{
		[str appendString: @" "];
		[str appendString: arg];
	}
	return [str autorelease];
}
- (int)exitCode
{
	return [task terminationStatus];
}
- (NSData*)standardOutput
{
	return result;
}
- (NSData*)standardError
{
	return errData;
}
- (BOOL)isConcurrent
{
	return NO;
}
@end
