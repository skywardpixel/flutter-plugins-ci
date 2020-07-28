#import "FortyTwoPlugin.h"
#if __has_include(<forty_two/forty_two-Swift.h>)
#import <forty_two/forty_two-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "forty_two-Swift.h"
#endif

@implementation FortyTwoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFortyTwoPlugin registerWithRegistrar:registrar];
}
@end
