#import <AppKit/AppKit.h>
#import <ScreenSaver/ScreenSaver.h>

@interface PHWallpaperHost : NSObject <NSApplicationDelegate>
@property (nonatomic, copy) NSString *saverBundlePath;
@property (nonatomic, strong) NSMutableArray<NSWindow *> *windows;
@property (nonatomic, strong) NSMutableArray<ScreenSaverView *> *saverViews;
@end

@implementation PHWallpaperHost

- (instancetype)initWithSaverBundlePath:(NSString *)saverBundlePath
{
    self = [super init];
    if (self) {
        _saverBundlePath = [saverBundlePath copy];
        _windows = [NSMutableArray array];
        _saverViews = [NSMutableArray array];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    (void)notification;
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];

    Class saverClass = [self loadSaverClass];
    if (!saverClass) {
        [NSApp terminate:nil];
        return;
    }

    [self installDesktopWindowsWithSaverClass:saverClass];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(screenConfigurationChanged:)
                                                 name:NSApplicationDidChangeScreenParametersNotification
                                               object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    (void)notification;
    for (ScreenSaverView *view in self.saverViews) {
        [view stopAnimation];
    }
}

- (Class)loadSaverClass
{
    NSBundle *saverBundle = [NSBundle bundleWithPath:self.saverBundlePath];
    if (!saverBundle) {
        fprintf(stderr, "error: could not open saver bundle at %s\n", self.saverBundlePath.UTF8String);
        return Nil;
    }

    NSError *error = nil;
    if (![saverBundle loadAndReturnError:&error]) {
        fprintf(stderr, "error: failed to load saver bundle at %s (%s)\n",
                self.saverBundlePath.UTF8String,
                error.localizedDescription.UTF8String ?: "unknown error");
        return Nil;
    }

    Class principalClass = saverBundle.principalClass;
    if (![principalClass isSubclassOfClass:[ScreenSaverView class]]) {
        fprintf(stderr, "error: NSPrincipalClass is not a ScreenSaverView subclass in %s\n", self.saverBundlePath.UTF8String);
        return Nil;
    }

    return principalClass;
}

- (void)screenConfigurationChanged:(NSNotification *)notification
{
    (void)notification;

    for (ScreenSaverView *view in self.saverViews) {
        [view stopAnimation];
    }

    [self.windows removeAllObjects];
    [self.saverViews removeAllObjects];

    Class saverClass = [self loadSaverClass];
    if (saverClass) {
        [self installDesktopWindowsWithSaverClass:saverClass];
    }
}

- (void)installDesktopWindowsWithSaverClass:(Class)saverClass
{
    for (NSScreen *screen in NSScreen.screens) {
        NSRect frame = screen.frame;
        ScreenSaverView *view = [[saverClass alloc] initWithFrame:frame isPreview:NO];

        NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
                                                       styleMask:NSWindowStyleMaskBorderless
                                                         backing:NSBackingStoreBuffered
                                                           defer:NO
                                                          screen:screen];

        window.collectionBehavior = NSWindowCollectionBehaviorCanJoinAllSpaces |
                                    NSWindowCollectionBehaviorStationary |
                                    NSWindowCollectionBehaviorIgnoresCycle;
        window.opaque = YES;
        window.backgroundColor = NSColor.blackColor;
        window.ignoresMouseEvents = YES;
        window.hasShadow = NO;

        // Put the animation above static wallpaper and below desktop icons.
        NSInteger desktopLevel = CGWindowLevelForKey(kCGDesktopWindowLevelKey);
        window.level = desktopLevel + 1;

        window.contentView = view;
        [window orderBack:nil];

        [view startAnimation];

        [self.windows addObject:window];
        [self.saverViews addObject:view];
    }
}

@end

static NSString *PHDefaultSaverPath(void)
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *homeSaver = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Screen Savers/Polyhedra.saver"];
    if ([fm fileExistsAtPath:homeSaver]) {
        return homeSaver;
    }

    NSString *workspaceBuild = [fm.currentDirectoryPath stringByAppendingPathComponent:@"build/Release/Polyhedra.saver"];
    if ([fm fileExistsAtPath:workspaceBuild]) {
        return workspaceBuild;
    }

    return homeSaver;
}

int main(int argc, const char *argv[])
{
    @autoreleasepool {
        NSString *bundlePath = (argc > 1)
            ? [NSString stringWithUTF8String:argv[1]]
            : PHDefaultSaverPath();

        NSApplication *app = [NSApplication sharedApplication];
        PHWallpaperHost *delegate = [[PHWallpaperHost alloc] initWithSaverBundlePath:bundlePath];
        app.delegate = delegate;
        [app run];
    }

    return 0;
}
