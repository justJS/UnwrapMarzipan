#import <UIKit/UIKit.h>

@protocol UHAMenuItemInterface, UHAMenuInterface, UHAToolbarInterface, UHAWindowInterface, ROCKForwardingInterposableWithRunLoop, _UIValidatedUserInterfaceItem;
typedef void (^CDUnknownBlockType)(void);


@class UIHoverEvent, UITouch;

@interface UIHoverGestureRecognizer : UIGestureRecognizer
{
    UIHoverEvent *_currentHoverEvent;
    UITouch *_currentTouch;
}


- (struct CGPoint)locationInView:(id)arg1;
- (void)_hoverCancelled:(id)arg1 withEvent:(id)arg2;
- (void)_hoverExited:(id)arg1 withEvent:(id)arg2;
- (void)_hoverMoved:(id)arg1 withEvent:(id)arg2;
- (void)_hoverEntered:(id)arg1 withEvent:(id)arg2;
- (BOOL)_shouldReceivePress:(id)arg1;
- (BOOL)_shouldReceiveTouch:(id)arg1 recognizerView:(id)arg2 touchView:(id)arg3;
- (void)reset;
- (BOOL)_wantsHoverEvents;
- (void)setView:(id)arg1;
- (id)initWithTarget:(id)arg1 action:(SEL)arg2;

@end



@interface _UIContextualMenuGestureRecognizer : UIGestureRecognizer
{
}

- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;

@end



@class UILookupEvent;

@interface _UILookupGestureRecognizer : UIGestureRecognizer
{
    UILookupEvent *_lookupEvent;
}


- (struct CGPoint)locationInView:(id)arg1;
- (void)_lookupChangedWithEvent:(id)arg1;
- (BOOL)_shouldReceiveLookupEvent:(id)arg1;
- (void)_resetGestureRecognizer;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;
- (void)_processTouches:(id)arg1 withEvent:(id)arg2;

@end



@class NSArray, NSSet, NSString, UHASTouchBar;

@interface _UITouchBar : NSObject
{
    UHASTouchBar *_touchBar;
    NSSet *_touchBarItems;
}


- (id)backingBar;
@property(nonatomic) BOOL allowsCustomization;
@property(retain, nonatomic) NSSet *templateItems;
@property(retain, nonatomic) NSString *principalItemIdentifier;
@property(copy, nonatomic) NSArray *itemIdentifiers;
@property(readonly, nonatomic) NSString *identifier;
- (void)setIdentifier:(id)arg1;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSMutableOrderedSet, _UITouchBar;

@interface _UITouchBarController : NSObject
{
    _UITouchBar *_presentedBar;
    NSMutableOrderedSet *_registeredResponders;
    NSMutableOrderedSet *_registeredPresentedResponders;
    BOOL _touchBarAvailable;
}


- (void)updateBridgedTouchBar;
- (void)unregisterResponder:(id)arg1;
- (void)registerResponder:(id)arg1;
- (void)_updateForMainWindow:(id)arg1;
- (void)_updateForMainHostWindowDidChangeNotification:(id)arg1;
- (void)dealloc;
- (id)init;

@end



@class NSString, UHASTouchBarItem;

@interface _UITouchBarItem : NSObject
{
    UHASTouchBarItem *_touchBarItem;
}

+ (id)representedClass;

- (id)backingItem;
- (CDUnknownBlockType)actionHandler;
- (void)setActionHandler:(CDUnknownBlockType)arg1;
- (id)itemDescription;
- (void)setItemDescription:(id)arg1;
@property(readonly, copy, nonatomic) NSString *customizationLabel;
@property(readonly, nonatomic) NSString *identifier;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSString, _UITouchBar;

@interface _UIGroupTouchBarItem : _UITouchBarItem
{
    _UITouchBar *_groupTouchBar;
}

+ (id)representedClass;
+ (id)alertStyleGroupItemWithIdentifier:(id)arg1;
+ (id)groupItemWithIdentifier:(id)arg1 items:(id)arg2;

- (void)_setGroupHasAlertStyle:(BOOL)arg1;
- (BOOL)_groupHasAlertStyle;
@property(nonatomic) long long groupUserInterfaceLayoutDirection;
@property(copy, nonatomic) NSString *customizationLabel;
@property(retain, nonatomic) _UITouchBar *groupTouchBar;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSString;

@interface _UIButtonTouchBarItem : _UITouchBarItem
{
    id _target;
    SEL _action;
}

+ (id)representedClass;
@property(nonatomic) SEL action; // @synthesize action=_action;
@property(nonatomic) __weak id target; // @synthesize target=_target;

@property(copy, nonatomic) NSString *customizationLabel;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(nonatomic) BOOL isDefaultButton;
@property(copy, nonatomic) NSString *title;
- (void)performAction;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSArray;

__attribute__((visibility("hidden")))
@interface _UIMenuBarController : NSObject
{
    BOOL _menuChangeShouldRebuildMenu;
    NSArray *__objectsForSharing;
    CDUnknownBlockType _contextMenuDidClose;
}

+ (id)sharedInstance;
@property(nonatomic) BOOL menuChangeShouldRebuildMenu; // @synthesize menuChangeShouldRebuildMenu=_menuChangeShouldRebuildMenu;
@property(copy, nonatomic) CDUnknownBlockType contextMenuDidClose; // @synthesize contextMenuDidClose=_contextMenuDidClose;
@property(copy, nonatomic, setter=_setObjectsForSharing:) NSArray *_objectsForSharing; // @synthesize _objectsForSharing=__objectsForSharing;

- (id)_newSpeechMenuItem;
- (void)_notifyContextMenuClosed;
- (void)_makeContextMenuMoreMacLike:(id)arg1 isTextContextMenu:(BOOL)arg2 textIsEditable:(BOOL)arg3 hasObjectsToShare:(BOOL)arg4;
- (void)showContextMenu:(id)arg1 atLocation:(struct CGPoint)arg2 objectsForServicesAndSharing:(id)arg3 notifyingWhenClosed:(CDUnknownBlockType)arg4;
- (BOOL)shouldDeleteStandardItem:(id)arg1;
- (void)addCustomItemsToMenu:(id)arg1 afterItem:(id)arg2 toItemArray:(id)arg3;
- (void)addCustomMenusAfterMenu:(id)arg1 toItemArray:(id)arg2;
- (void)menuChanged:(id)arg1;
- (void)buildMenuBar;
- (id)init;

@end







@class NSDictionary, NSObject, NSString, _UIMenuBarMenu;

@interface _UIMenuBarItem : NSObject <UHAMenuItemInterface, ROCKForwardingInterposableWithRunLoop, _UIValidatedUserInterfaceItem>
{
    BOOL _alternate;
    BOOL _enabled;
    BOOL _separatorItem;
    BOOL _replacedBySubmenuItems;
    NSString *_title;
    NSString *_keyEquivalent;
    long long _keyEquivalentModifiers;
    long long _state;
    _UIMenuBarMenu *_submenu;
    id _target;
    long long _type;
    id _cachedTarget;
    unsigned long long _targetSearchScopeMask;
    NSString *_actionName;
    NSString *_hostActionName;
}

+ (id)separatorItem;
@property(copy, nonatomic) NSString *hostActionName; // @synthesize hostActionName=_hostActionName;
@property(copy, nonatomic) NSString *actionName; // @synthesize actionName=_actionName;
@property(nonatomic) unsigned long long targetSearchScopeMask; // @synthesize targetSearchScopeMask=_targetSearchScopeMask;
@property(nonatomic) __weak id cachedTarget; // @synthesize cachedTarget=_cachedTarget;
@property(nonatomic) long long type; // @synthesize type=_type;
@property(nonatomic) __weak id target; // @synthesize target=_target;
@property(retain, nonatomic) _UIMenuBarMenu *submenu; // @synthesize submenu=_submenu;
@property(nonatomic) long long state; // @synthesize state=_state;
@property(nonatomic, getter=isReplacedBySubmenuItems) BOOL replacedBySubmenuItems; // @synthesize replacedBySubmenuItems=_replacedBySubmenuItems;
@property(nonatomic, getter=isSeparatorItem) BOOL separatorItem; // @synthesize separatorItem=_separatorItem;
@property(nonatomic, getter=isEnabled) BOOL enabled; // @synthesize enabled=_enabled;
@property(nonatomic, getter=isAlternate) BOOL alternate; // @synthesize alternate=_alternate;
@property(nonatomic) long long keyEquivalentModifiers; // @synthesize keyEquivalentModifiers=_keyEquivalentModifiers;
@property(copy, nonatomic) NSString *keyEquivalent; // @synthesize keyEquivalent=_keyEquivalent;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;

- (id)_stringForFlags:(unsigned long long)arg1;
- (id)_stringForState:(long long)arg1;
@property(readonly, copy) NSString *description;
- (void)_performAction;
- (void)_validate;
@property(readonly, nonatomic) NSDictionary *validatedProperties;
@property(readonly, nonatomic) NSDictionary *properties;
@property(nonatomic) SEL action;
- (id)initWithTitle:(id)arg1 action:(SEL)arg2 keyEquivalent:(id)arg3;
- (id)init;
- (struct __CFString *)forwardingInterposableRunLoopMode;
- (double)forwardingInterposableRunLoopTimeOut;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly, nonatomic) unsigned long long rock_invocationFlags;
@property(readonly, nonatomic) NSObject *rock_invocationQueue;
@property(readonly) Class superclass;

@end






@class NSArray, NSObject, NSString;

@interface _UIMenuBarMenu : NSObject <UHAMenuInterface, ROCKForwardingInterposableWithRunLoop>
{
    NSArray *_items;
    NSString *_title;
}

+ (id)_menuIdentifierForStandardItem:(id)arg1;
+ (BOOL)_isValidMenuIdentifier:(id)arg1;
+ (BOOL)menuBarBuilt;
+ (void)setMenuBarBuilt:(BOOL)arg1;
+ (id)mainMenu;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;

@property(readonly, copy) NSString *description;
- (void)_validate;
- (id)initWithTitle:(id)arg1;
- (id)init;
@property(copy, nonatomic) NSArray *items;
- (void)deleteStandardItems:(id)arg1;
- (void)insertItems:(id)arg1 afterStandardItem:(id)arg2;
- (void)insertItems:(id)arg1 atBeginningOfMenu:(id)arg2;
- (void)insertMenu:(id)arg1 afterStandardMenu:(id)arg2;
- (struct __CFString *)forwardingInterposableRunLoopMode;
- (double)forwardingInterposableRunLoopTimeOut;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly, nonatomic) unsigned long long rock_invocationFlags;
@property(readonly) Class superclass;

@end



@class NSArray, NSSet, NSString;

@interface _UIWindowToolbarController : NSObject
{
    id <UHAToolbarInterface> _toolbar;
    id <UHAWindowInterface> _hostWindow;
    NSArray *_itemIdentifiers;
    NSString *_centeredItemIdentifier;
    NSSet *_templateItems;
    BOOL _hasExplicitToolbar;
}

+ (id)sharedWindowToolbarController;
@property(copy, nonatomic) NSSet *templateItems; // @synthesize templateItems=_templateItems;
@property(copy, nonatomic) NSString *centeredItemIdentifier; // @synthesize centeredItemIdentifier=_centeredItemIdentifier;
@property(copy, nonatomic) NSArray *itemIdentifiers; // @synthesize itemIdentifiers=_itemIdentifiers;

- (void)_refreshToolbar;
@property(nonatomic) BOOL autoHidesToolbarInFullScreen;
- (id)_toolbarCreatingIfNeeded:(BOOL)arg1;
- (BOOL)_hasExplicitToolbar;
- (BOOL)_wantsToolbar;
- (void)updateForMainWindow:(id)arg1;
- (void)updateForMainHostWindowDidChangeNotification:(id)arg1;
- (void)dealloc;
- (id)init;

@end



@class NSString, UHASToolbarItem;

@interface _UIWindowToolbarItem : NSObject
{
    UHASToolbarItem *_toolbarItem;
}

+ (Class)representedClass;

- (id)_backingItem;
- (void)setLabel:(id)arg1;
- (void)setAccessibilityHint:(id)arg1;
- (void)setAccessibilityValue:(id)arg1;
- (void)setAccessibilityLabel:(id)arg1;
@property(readonly, copy, nonatomic) NSString *label;
@property(readonly, copy, nonatomic) NSString *identifier;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSString;

@interface _UIWindowToolbarButtonItem : _UIWindowToolbarItem
{
    id _target;
    SEL _action;
}

+ (Class)representedClass;
@property(nonatomic) SEL action; // @synthesize action=_action;
@property(nonatomic) __weak id target; // @synthesize target=_target;

@property(copy, nonatomic) NSString *imageName;
@property(copy, nonatomic) NSString *label;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(copy, nonatomic) NSString *title;
- (void)performAction;
- (id)_ourBackingItem;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSArray;

@interface _UIWindowToolbarGroupItem : _UIWindowToolbarItem
{
    NSArray *_subitems;
}

+ (Class)representedClass;
@property(copy, nonatomic) NSArray *subitems; // @synthesize subitems=_subitems;

- (id)_ourBackingItem;

@end



@class NSString;

@interface _UIWindowToolbarLabelItem : _UIWindowToolbarItem
{
}

+ (Class)representedClass;
@property(copy, nonatomic) NSString *text;
- (id)_ourBackingItem;

@end



@class NSString, _UIMenuBarMenu;

@interface _UIWindowToolbarPopupButtonItem : _UIWindowToolbarItem
{
}

+ (Class)representedClass;
@property(nonatomic) BOOL showsArrow;
@property(retain, nonatomic) _UIMenuBarMenu *menu;
@property(copy, nonatomic) NSString *label;
@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(copy, nonatomic) NSString *imageName;
@property(copy, nonatomic) NSString *title;
- (id)_ourBackingItem;

@end



@class NSString;

@interface _UIWindowToolbarSearchFieldItem : _UIWindowToolbarItem
{
    id _target;
    SEL _action;
}

+ (Class)representedClass;
@property(nonatomic) SEL action; // @synthesize action=_action;
@property(nonatomic) __weak id target; // @synthesize target=_target;

@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(copy, nonatomic) NSString *text;
@property(copy, nonatomic) NSString *placeholder;
- (void)performAction:(id)arg1;
- (id)_ourBackingItem;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSArray, NSMutableDictionary;

@interface _UIWindowToolbarSegmentedControlItem : _UIWindowToolbarItem
{
    NSMutableDictionary *_segmentsToMenu;
    long long _selectedSegment;
    id _target;
    SEL _action;
}

+ (Class)representedClass;
@property(nonatomic) SEL action; // @synthesize action=_action;
@property(nonatomic) __weak id target; // @synthesize target=_target;

- (void)_setSelectedSegment:(long long)arg1;
@property(readonly, nonatomic) long long selectedSegment;
- (id)menuForSegment:(long long)arg1;
- (void)setMenu:(id)arg1 forSegment:(long long)arg2;
- (BOOL)isEnabledForSegment:(long long)arg1;
- (void)setEnabled:(BOOL)arg1 forSegment:(long long)arg2;
- (BOOL)isSelectedForSegment:(long long)arg1;
- (void)setSelected:(BOOL)arg1 forSegment:(long long)arg2;
@property(nonatomic) long long trackingMode;
@property(copy, nonatomic) NSArray *segmentImageNames;
@property(copy, nonatomic) NSArray *segmentTitles;
- (void)_applyAccessibilityInfoForSegments:(id)arg1;
- (void)performAction:(long long)arg1;
- (id)_ourBackingItem;
- (id)initWithIdentifier:(id)arg1;

@end



@class NSArray;

@interface _UIWindowToolbarShareItem : _UIWindowToolbarItem
{
    CDUnknownBlockType _completionWithItemsHandler;
    NSArray *_iosActivityItems;
}

+ (Class)representedClass;
@property(copy, nonatomic) NSArray *iosActivityItems; // @synthesize iosActivityItems=_iosActivityItems;

@property(nonatomic, getter=isEnabled) BOOL enabled;
@property(copy, nonatomic) CDUnknownBlockType completionWithItemsHandler;
@property(copy, nonatomic) NSArray *activityItems;
- (id)_ourBackingItem;

@end


extern int UITableViewStyleSidebar;

@interface UIWindow (MZToolbar)
- (_UIWindowToolbarController *)_windowToolbarController;
@end

@interface UIApplication (MZTouchBar)
@property(readonly, nonatomic, getter=_touchBarController) _UITouchBarController *touchBarController;
@end

extern NSString *_UIMenuBarStandardMenuIdentifierApplication;
extern NSString *_UIMenuBarStandardMenuIdentifierFile;
extern NSString *_UIMenuBarStandardMenuIdentifierEdit;
extern NSString *_UIMenuBarStandardMenuIdentifierView;
extern NSString *_UIMenuBarStandardMenuIdentifierWindow;
extern NSString *_UIMenuBarStandardMenuIdentifierHelp;
