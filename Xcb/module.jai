helper_get_intern_atom :: (
    connection : *Connection,
    onlyIfExists : bool,
    str : string
) -> Atom
{
    cookie := intern_atom(connection, cast(u8) onlyIfExists, cast(u16) str.count, str.data);
    reply := intern_atom_reply(connection, cookie, null);
    defer c_free(reply);
    return reply.atom;
}

libc :: #system_library "libc";
c_free :: (data : *void) -> *void #foreign libc "free";

// libxcb-render

libxcbrender :: #system_library "libxcb-render";

Render :: struct {
    Pictformat :: u32;
    Picture :: u32;

    PictType :: enum s32 {
        Indexed :: 0;
        Direct :: 1;
    }

    Directformat :: struct {
        redShift : u16;
        redMask : u16;
        greenShift : u16;
        greenMask : u16;
        blueShift : u16;
        blueMask : u16;
        alphaShift : u16;
        alphaMask : u16;
    }

    Pictforminfo :: struct {
        id : Pictformat;
        type : u8;
        depth : u8;
        pad0 : [2]u8;
        direct : Directformat;
        colormap : Colormap;
    }

    PictforminfoIterator :: struct {
        data : *Pictforminfo;
        rem : s32;
        index : s32;
    }

    QueryPictFormatsCookie :: struct {
        sequence : u32;
    }

    QueryPictFormatsReply :: struct {
        response_type : u8;
        pad0 : u8;
        sequence : u16;
        length : u32;
        numFormats : u32;
        numScreens : u32;
        numDepths : u32;
        numVisuals : u32;
        numSubpixel : u32;
        pad1 : [4]u8;
    }

    create_cursor :: (
        c : *Connection,
        cid : Cursor,
        source : Picture,
        x : u16,
        y : u16
    ) -> VoidCookie #foreign libxcbrender "xcb_render_create_cursor";

    create_picture :: (
        c : *Connection,
        pid : Picture,
        drawable : Drawable,
        format : Pictformat,
        value_mask : u32,
        value_list : *void
    ) -> VoidCookie #foreign libxcbrender "xcb_render_create_picture";

    free_picture :: (
        c : *Connection,
        picture : Picture
    ) -> VoidCookie #foreign libxcbrender "xcb_render_free_picture";

    pictforminfo_next :: (
        i : *PictforminfoIterator
    ) #foreign libxcbrender "xcb_render_pictforminfo_next";

    query_pict_formats :: (
        c : *Connection
    ) -> QueryPictFormatsCookie #foreign libxcbrender "xcb_render_query_pict_formats";

    query_pict_formats_formats_iterator :: (
        r : *QueryPictFormatsReply
    ) -> PictforminfoIterator #foreign libxcbrender "xcb_render_query_pict_formats_formats_iterator";

    query_pict_formats_reply :: (
        c : *Connection,
        cookie : QueryPictFormatsCookie,
        e : *VoidCookie
    ) -> *QueryPictFormatsReply #foreign libxcbrender "xcb_render_query_pict_formats_reply";
}

// libxcb
// Below was auto-generated.

libxcb :: #system_library "libxcb";

__XCB_H__ :: 1;
X_PROTOCOL :: 11;
X_PROTOCOL_REVISION :: 0;
X_TCP_PORT :: 6000;
NONE :: 0;
COPY_FROM_PARENT :: 0;
CURRENT_TIME :: 0;
NO_SYMBOL :: 0;
__XPROTO_H :: 1;
KEY_PRESS :: 2;
KEY_RELEASE :: 3;
BUTTON_PRESS :: 4;
BUTTON_RELEASE :: 5;
MOTION_NOTIFY :: 6;
ENTER_NOTIFY :: 7;
LEAVE_NOTIFY :: 8;
FOCUS_IN :: 9;
FOCUS_OUT :: 10;
KEYMAP_NOTIFY :: 11;
EXPOSE :: 12;
GRAPHICS_EXPOSURE :: 13;
NO_EXPOSURE :: 14;
VISIBILITY_NOTIFY :: 15;
CREATE_NOTIFY :: 16;
DESTROY_NOTIFY :: 17;
UNMAP_NOTIFY :: 18;
MAP_NOTIFY :: 19;
MAP_REQUEST :: 20;
REPARENT_NOTIFY :: 21;
CONFIGURE_NOTIFY :: 22;
CONFIGURE_REQUEST :: 23;
GRAVITY_NOTIFY :: 24;
RESIZE_REQUEST :: 25;
CIRCULATE_NOTIFY :: 26;
CIRCULATE_REQUEST :: 27;
PROPERTY_NOTIFY :: 28;
SELECTION_CLEAR :: 29;
SELECTION_REQUEST :: 30;
SELECTION_NOTIFY :: 31;
COLORMAP_NOTIFY :: 32;
CLIENT_MESSAGE :: 33;
MAPPING_NOTIFY :: 34;
GE_GENERIC :: 35;
REQUEST :: 1;
VALUE :: 2;
WINDOW :: 3;
PIXMAP :: 4;
ATOM :: 5;
CURSOR :: 6;
FONT :: 7;
MATCH :: 8;
DRAWABLE :: 9;
ACCESS :: 10;
ALLOC :: 11;
COLORMAP :: 12;
G_CONTEXT :: 13;
ID_CHOICE :: 14;
NAME :: 15;
LENGTH :: 16;
IMPLEMENTATION :: 17;
CREATE_WINDOW :: 1;
CHANGE_WINDOW_ATTRIBUTES :: 2;
GET_WINDOW_ATTRIBUTES :: 3;
DESTROY_WINDOW :: 4;
DESTROY_SUBWINDOWS :: 5;
CHANGE_SAVE_SET :: 6;
REPARENT_WINDOW :: 7;
MAP_WINDOW :: 8;
MAP_SUBWINDOWS :: 9;
UNMAP_WINDOW :: 10;
UNMAP_SUBWINDOWS :: 11;
CONFIGURE_WINDOW :: 12;
CIRCULATE_WINDOW :: 13;
GET_GEOMETRY :: 14;
QUERY_TREE :: 15;
INTERN_ATOM :: 16;
GET_ATOM_NAME :: 17;
CHANGE_PROPERTY :: 18;
DELETE_PROPERTY :: 19;
GET_PROPERTY :: 20;
LIST_PROPERTIES :: 21;
SET_SELECTION_OWNER :: 22;
GET_SELECTION_OWNER :: 23;
CONVERT_SELECTION :: 24;
SEND_EVENT :: 25;
GRAB_POINTER :: 26;
UNGRAB_POINTER :: 27;
GRAB_BUTTON :: 28;
UNGRAB_BUTTON :: 29;
CHANGE_ACTIVE_POINTER_GRAB :: 30;
GRAB_KEYBOARD :: 31;
UNGRAB_KEYBOARD :: 32;
GRAB_KEY :: 33;
UNGRAB_KEY :: 34;
ALLOW_EVENTS :: 35;
GRAB_SERVER :: 36;
UNGRAB_SERVER :: 37;
QUERY_POINTER :: 38;
GET_MOTION_EVENTS :: 39;
TRANSLATE_COORDINATES :: 40;
WARP_POINTER :: 41;
SET_INPUT_FOCUS :: 42;
GET_INPUT_FOCUS :: 43;
QUERY_KEYMAP :: 44;
OPEN_FONT :: 45;
CLOSE_FONT :: 46;
QUERY_FONT :: 47;
QUERY_TEXT_EXTENTS :: 48;
LIST_FONTS :: 49;
LIST_FONTS_WITH_INFO :: 50;
SET_FONT_PATH :: 51;
GET_FONT_PATH :: 52;
CREATE_PIXMAP :: 53;
FREE_PIXMAP :: 54;
CREATE_GC :: 55;
CHANGE_GC :: 56;
COPY_GC :: 57;
SET_DASHES :: 58;
SET_CLIP_RECTANGLES :: 59;
FREE_GC :: 60;
CLEAR_AREA :: 61;
COPY_AREA :: 62;
COPY_PLANE :: 63;
POLY_POINT :: 64;
POLY_LINE :: 65;
POLY_SEGMENT :: 66;
POLY_RECTANGLE :: 67;
POLY_ARC :: 68;
FILL_POLY :: 69;
POLY_FILL_RECTANGLE :: 70;
POLY_FILL_ARC :: 71;
PUT_IMAGE :: 72;
GET_IMAGE :: 73;
POLY_TEXT_8 :: 74;
POLY_TEXT_16 :: 75;
IMAGE_TEXT_8 :: 76;
IMAGE_TEXT_16 :: 77;
CREATE_COLORMAP :: 78;
FREE_COLORMAP :: 79;
COPY_COLORMAP_AND_FREE :: 80;
INSTALL_COLORMAP :: 81;
UNINSTALL_COLORMAP :: 82;
LIST_INSTALLED_COLORMAPS :: 83;
ALLOC_COLOR :: 84;
ALLOC_NAMED_COLOR :: 85;
ALLOC_COLOR_CELLS :: 86;
ALLOC_COLOR_PLANES :: 87;
FREE_COLORS :: 88;
STORE_COLORS :: 89;
STORE_NAMED_COLOR :: 90;
QUERY_COLORS :: 91;
LOOKUP_COLOR :: 92;
CREATE_CURSOR :: 93;
CREATE_GLYPH_CURSOR :: 94;
FREE_CURSOR :: 95;
RECOLOR_CURSOR :: 96;
QUERY_BEST_SIZE :: 97;
QUERY_EXTENSION :: 98;
LIST_EXTENSIONS :: 99;
CHANGE_KEYBOARD_MAPPING :: 100;
GET_KEYBOARD_MAPPING :: 101;
CHANGE_KEYBOARD_CONTROL :: 102;
GET_KEYBOARD_CONTROL :: 103;
BELL :: 104;
CHANGE_POINTER_CONTROL :: 105;
GET_POINTER_CONTROL :: 106;
SET_SCREEN_SAVER :: 107;
GET_SCREEN_SAVER :: 108;
CHANGE_HOSTS :: 109;
LIST_HOSTS :: 110;
SET_ACCESS_CONTROL :: 111;
SET_CLOSE_DOWN_MODE :: 112;
KILL_CLIENT :: 113;
ROTATE_PROPERTIES :: 114;
FORCE_SCREEN_SAVER :: 115;
SET_POINTER_MAPPING :: 116;
GET_POINTER_MAPPING :: 117;
SET_MODIFIER_MAPPING :: 118;
GET_MODIFIER_MAPPING :: 119;
NO_OPERATION :: 127;

Window :: u32;
Pixmap :: u32;
Cursor :: u32;
Font :: u32;
Gcontext :: u32;
Colormap :: u32;
Atom :: u32;
Drawable :: u32;
Fontable :: u32;
Bool32 :: u32;
Visualid :: u32;
Timestamp :: u32;
Keysym :: u32;
Keycode :: u8;
Keycode32 :: u32;
Button :: u8;
KeyReleaseEvent :: KeyPressEvent;
ButtonReleaseEvent :: ButtonPressEvent;
LeaveNotifyEvent :: EnterNotifyEvent;
FocusOutEvent :: FocusInEvent;
CirculateRequestEvent :: CirculateNotifyEvent;
WindowError :: ValueError;
PixmapError :: ValueError;
AtomError :: ValueError;
CursorError :: ValueError;
FontError :: ValueError;
MatchError :: RequestError;
DrawableError :: ValueError;
AccessError :: RequestError;
AllocError :: RequestError;
ColormapError :: ValueError;
G_contextError :: ValueError;
IdChoiceError :: ValueError;
NameError :: RequestError;
LengthError :: RequestError;
ImplementationError :: RequestError;

VisualClass :: enum s32 {
    StaticGray :: 0;
    GrayScale :: 1;
    StaticColor :: 2;
    PseudoColor :: 3;
    TrueColor :: 4;
    DirectColor :: 5;
}

EventMask :: enum s32 {
    NoEvent :: 0;
    KeyPress :: 1;
    KeyRelease :: 2;
    ButtonPress :: 4;
    ButtonRelease :: 8;
    EnterWindow :: 16;
    LeaveWindow :: 32;
    PointerMotion :: 64;
    PointerMotionHint :: 128;
    Button1_motion :: 256;
    Button2_motion :: 512;
    Button3_motion :: 1024;
    Button4_motion :: 2048;
    Button5_motion :: 4096;
    ButtonMotion :: 8192;
    KeymapState :: 16384;
    Exposure :: 32768;
    VisibilityChange :: 65536;
    StructureNotify :: 131072;
    ResizeRedirect :: 262144;
    SubstructureNotify :: 524288;
    SubstructureRedirect :: 1048576;
    FocusChange :: 2097152;
    PropertyChange :: 4194304;
    ColorMapChange :: 8388608;
    OwnerGrabButton :: 16777216;
}

BackingStore :: enum s32 {
    NotUseful :: 0;
    WhenMapped :: 1;
    Always :: 2;
}

ImageOrder :: enum s32 {
    LsbFirst :: 0;
    MsbFirst :: 1;
}

ModMask :: enum s32 {
    Shift :: 1;
    Lock :: 2;
    Control :: 4;
    _1 :: 8;
    _2 :: 16;
    _3 :: 32;
    _4 :: 64;
    _5 :: 128;
    Any :: 32768;
}

KeyButMask :: enum s32 {
    Shift :: 1;
    Lock :: 2;
    Control :: 4;
    Mod1 :: 8;
    Mod2 :: 16;
    Mod3 :: 32;
    Mod4 :: 64;
    Mod5 :: 128;
    Button1 :: 256;
    Button2 :: 512;
    Button3 :: 1024;
    Button4 :: 2048;
    Button5 :: 4096;
}

WindowEnum :: enum s32 {
    WindowNone :: 0;
}

ButtonMask :: enum s32 {
    _1 :: 256;
    _2 :: 512;
    _3 :: 1024;
    _4 :: 2048;
    _5 :: 4096;
    Any :: 32768;
}

Motion :: enum s32 {
    Normal :: 0;
    Hint :: 1;
}

NotifyDetail :: enum s32 {
    Ancestor :: 0;
    Virtual :: 1;
    Inferior :: 2;
    Nonlinear :: 3;
    NonlinearVirtual :: 4;
    Pointer :: 5;
    PointerRoot :: 6;
    None :: 7;
}

NotifyMode :: enum s32 {
    Normal :: 0;
    Grab :: 1;
    Ungrab :: 2;
    WhileGrabbed :: 3;
}

Visibility :: enum s32 {
    Unobscured :: 0;
    PartiallyObscured :: 1;
    FullyObscured :: 2;
}

Place :: enum s32 {
    OnTop :: 0;
    OnBottom :: 1;
}

Property :: enum s32 {
    NewValue :: 0;
    Delete :: 1;
}

Time :: enum s32 {
    CurrentTime :: 0;
}

AtomEnum :: enum s32 {
    None :: 0;
    Any :: 0;
    Primary :: 1;
    Secondary :: 2;
    Arc :: 3;
    Atom :: 4;
    Bitmap :: 5;
    Cardinal :: 6;
    Colormap :: 7;
    Cursor :: 8;
    CutBuffer0 :: 9;
    CutBuffer1 :: 10;
    CutBuffer2 :: 11;
    CutBuffer3 :: 12;
    CutBuffer4 :: 13;
    CutBuffer5 :: 14;
    CutBuffer6 :: 15;
    CutBuffer7 :: 16;
    Drawable :: 17;
    Font :: 18;
    Integer :: 19;
    Pixmap :: 20;
    Point :: 21;
    Rectangle :: 22;
    ResourceManager :: 23;
    RgbColorMap :: 24;
    RgbBestMap :: 25;
    RgbBlueMap :: 26;
    RgbDefaultMap :: 27;
    RgbGrayMap :: 28;
    RgbGreenMap :: 29;
    RgbRedMap :: 30;
    String :: 31;
    Visualid :: 32;
    Window :: 33;
    WmCommand :: 34;
    WmHints :: 35;
    WmClientMachine :: 36;
    WmIconName :: 37;
    WmIconSize :: 38;
    WmName :: 39;
    WmNormalHints :: 40;
    WmSizeHints :: 41;
    WmZoomHints :: 42;
    MinSpace :: 43;
    NormSpace :: 44;
    MaxSpace :: 45;
    EndSpace :: 46;
    SuperscriptX :: 47;
    SuperscriptY :: 48;
    SubscriptX :: 49;
    SubscriptY :: 50;
    UnderlinePosition :: 51;
    UnderlineThickness :: 52;
    StrikeoutAscent :: 53;
    StrikeoutDescent :: 54;
    ItalicAngle :: 55;
    X_height :: 56;
    QuadWidth :: 57;
    Weight :: 58;
    PointSize :: 59;
    Resolution :: 60;
    Copyright :: 61;
    Notice :: 62;
    FontName :: 63;
    FamilyName :: 64;
    FullName :: 65;
    CapHeight :: 66;
    WmClass :: 67;
    WmTransientFor :: 68;
}

ColormapState :: enum s32 {
    Uninstalled :: 0;
    Installed :: 1;
}

ColormapEnum :: enum s32 {
    ColormapNone :: 0;
}

Mapping :: enum s32 {
    Modifier :: 0;
    Keyboard :: 1;
    Pointer :: 2;
}

WindowClass :: enum s32 {
    CopyFromParent :: 0;
    InputOutput :: 1;
    InputOnly :: 2;
}

Cw :: enum s32 {
    BackPixmap :: 1;
    BackPixel :: 2;
    BorderPixmap :: 4;
    BorderPixel :: 8;
    BitGravity :: 16;
    WinGravity :: 32;
    BackingStore :: 64;
    BackingPlanes :: 128;
    BackingPixel :: 256;
    OverrideRedirect :: 512;
    SaveUnder :: 1024;
    EventMask :: 2048;
    DontPropagate :: 4096;
    Colormap :: 8192;
    Cursor :: 16384;
}

BackPixmap :: enum s32 {
    None :: 0;
    ParentRelative :: 1;
}

Gravity :: enum s32 {
    BitForget :: 0;
    WinUnmap :: 0;
    NorthWest :: 1;
    North :: 2;
    NorthEast :: 3;
    West :: 4;
    Center :: 5;
    East :: 6;
    SouthWest :: 7;
    South :: 8;
    SouthEast :: 9;
    Static :: 10;
}

MapState :: enum s32 {
    Unmapped :: 0;
    Unviewable :: 1;
    Viewable :: 2;
}

SetMode :: enum s32 {
    Insert :: 0;
    Delete :: 1;
}

ConfigWindow :: enum s32 {
    X :: 1;
    Y :: 2;
    Width :: 4;
    Height :: 8;
    BorderWidth :: 16;
    Sibling :: 32;
    StackMode :: 64;
}

StackMode :: enum s32 {
    Above :: 0;
    Below :: 1;
    TopIf :: 2;
    BottomIf :: 3;
    Opposite :: 4;
}

Circulate :: enum s32 {
    RaiseLowest :: 0;
    LowerHighest :: 1;
}

PropMode :: enum s32 {
    Replace :: 0;
    Prepend :: 1;
    Append :: 2;
}

GetPropertyType :: enum s32 {
    Any :: 0;
}

SendEventDest :: enum s32 {
    PointerWindow :: 0;
    ItemFocus :: 1;
}

GrabMode :: enum s32 {
    Sync :: 0;
    Async :: 1;
}

GrabStatus :: enum s32 {
    Success :: 0;
    AlreadyGrabbed :: 1;
    InvalidTime :: 2;
    NotViewable :: 3;
    Frozen :: 4;
}

CursorEnum :: enum s32 {
    CursorNone :: 0;
}

ButtonIndex :: enum s32 {
    Any :: 0;
    _1 :: 1;
    _2 :: 2;
    _3 :: 3;
    _4 :: 4;
    _5 :: 5;
}

Grab :: enum s32 {
    Any :: 0;
}

Allow :: enum s32 {
    AsyncPointer :: 0;
    SyncPointer :: 1;
    ReplayPointer :: 2;
    AsyncKeyboard :: 3;
    SyncKeyboard :: 4;
    ReplayKeyboard :: 5;
    AsyncBoth :: 6;
    SyncBoth :: 7;
}

InputFocus :: enum s32 {
    None :: 0;
    PointerRoot :: 1;
    Parent :: 2;
    FollowKeyboard :: 3;
}

FontDraw :: enum s32 {
    LeftToRight :: 0;
    RightToLeft :: 1;
}

Gc :: enum s32 {
    Function :: 1;
    PlaneMask :: 2;
    Foreground :: 4;
    Background :: 8;
    LineWidth :: 16;
    LineStyle :: 32;
    CapStyle :: 64;
    JoinStyle :: 128;
    FillStyle :: 256;
    FillRule :: 512;
    Tile :: 1024;
    Stipple :: 2048;
    TileStippleOriginX :: 4096;
    TileStippleOriginY :: 8192;
    Font :: 16384;
    SubwindowMode :: 32768;
    GraphicsExposures :: 65536;
    ClipOriginX :: 131072;
    ClipOriginY :: 262144;
    ClipMask :: 524288;
    DashOffset :: 1048576;
    DashList :: 2097152;
    ArcMode :: 4194304;
}

Gx :: enum s32 {
    Clear :: 0;
    And :: 1;
    AndReverse :: 2;
    Copy :: 3;
    AndInverted :: 4;
    Noop :: 5;
    Xor :: 6;
    Or :: 7;
    Nor :: 8;
    Equiv :: 9;
    Invert :: 10;
    OrReverse :: 11;
    CopyInverted :: 12;
    OrInverted :: 13;
    Nand :: 14;
    Set :: 15;
}

LineStyle :: enum s32 {
    Solid :: 0;
    OnOffDash :: 1;
    DoubleDash :: 2;
}

CapStyle :: enum s32 {
    NotLast :: 0;
    Butt :: 1;
    Round :: 2;
    Projecting :: 3;
}

JoinStyle :: enum s32 {
    Miter :: 0;
    Round :: 1;
    Bevel :: 2;
}

FillStyle :: enum s32 {
    Solid :: 0;
    Tiled :: 1;
    Stippled :: 2;
    OpaqueStippled :: 3;
}

FillRule :: enum s32 {
    EvenOdd :: 0;
    Winding :: 1;
}

SubwindowMode :: enum s32 {
    ClipByChildren :: 0;
    IncludeInferiors :: 1;
}

ArcMode :: enum s32 {
    Chord :: 0;
    PieSlice :: 1;
}

ClipOrdering :: enum s32 {
    Unsorted :: 0;
    Y_sorted :: 1;
    YxSorted :: 2;
    YxBanded :: 3;
}

CoordMode :: enum s32 {
    Origin :: 0;
    Previous :: 1;
}

PolyShape :: enum s32 {
    Complex :: 0;
    Nonconvex :: 1;
    Convex :: 2;
}

ImageFormat :: enum s32 {
    XyBitmap :: 0;
    XyPixmap :: 1;
    Z_pixmap :: 2;
}

ColormapAlloc :: enum s32 {
    None :: 0;
    All :: 1;
}

ColorFlag :: enum s32 {
    Red :: 1;
    Green :: 2;
    Blue :: 4;
}

PixmapEnum :: enum s32 {
    PixmapNone :: 0;
}

FontEnum :: enum s32 {
    FontNone :: 0;
}

QueryShapeOf :: enum s32 {
    LargestCursor :: 0;
    FastestTile :: 1;
    FastestStipple :: 2;
}

Kb :: enum s32 {
    KeyClickPercent :: 1;
    BellPercent :: 2;
    BellPitch :: 4;
    BellDuration :: 8;
    Led :: 16;
    LedMode :: 32;
    Key :: 64;
    AutoRepeatMode :: 128;
}

LedMode :: enum s32 {
    Off :: 0;
    On :: 1;
}

AutoRepeatMode :: enum s32 {
    Off :: 0;
    On :: 1;
    Default :: 2;
}

Blanking :: enum s32 {
    NotPreferred :: 0;
    Preferred :: 1;
    Default :: 2;
}

Exposures :: enum s32 {
    NotAllowed :: 0;
    Allowed :: 1;
    Default :: 2;
}

HostMode :: enum s32 {
    Insert :: 0;
    Delete :: 1;
}

Family :: enum s32 {
    Internet :: 0;
    Decnet :: 1;
    Chaos :: 2;
    ServerInterpreted :: 5;
    Internet6 :: 6;
}

AccessControl :: enum s32 {
    Disable :: 0;
    Enable :: 1;
}

CloseDown :: enum s32 {
    DestroyAll :: 0;
    RetainPermanent :: 1;
    RetainTemporary :: 2;
}

Kill :: enum s32 {
    AllTemporary :: 0;
}

ScreenSaver :: enum s32 {
    Reset :: 0;
    Active :: 1;
}

MappingStatus :: enum s32 {
    Success :: 0;
    Busy :: 1;
    Failure :: 2;
}

MapIndex :: enum s32 {
    Shift :: 0;
    Lock :: 1;
    Control :: 2;
    _1 :: 3;
    _2 :: 4;
    _3 :: 5;
    _4 :: 6;
    _5 :: 7;
}

Connection :: struct {}

GenericIterator :: struct {
    data : *void;
    rem : s32;
    index : s32;
}

GenericReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
}

GenericEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    pad : [7]u32;
    fullSequence : u32;
}

GeEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    eventType : u16;
    pad1 : u16;
    pad : [5]u32;
    fullSequence : u32;
}

GenericError :: struct {
    responseType : u8;
    errorCode : u8;
    sequence : u16;
    resourceId : u32;
    minorCode : u16;
    majorCode : u8;
    pad0 : u8;
    pad : [5]u32;
    fullSequence : u32;
}

VoidCookie :: struct {
    sequence : u32;
}

AuthInfo :: struct {
    namelen : s32;
    name : *u8;
    datalen : s32;
    data : *u8;
}

Extension :: struct {}

Char2B :: struct {
    byte1 : u8;
    byte2 : u8;
}

Char2BIterator :: struct {
    data : *Char2B;
    rem : s32;
    index : s32;
}

WindowIterator :: struct {
    data : *Window;
    rem : s32;
    index : s32;
}

PixmapIterator :: struct {
    data : *Pixmap;
    rem : s32;
    index : s32;
}

CursorIterator :: struct {
    data : *Cursor;
    rem : s32;
    index : s32;
}

FontIterator :: struct {
    data : *Font;
    rem : s32;
    index : s32;
}

GcontextIterator :: struct {
    data : *Gcontext;
    rem : s32;
    index : s32;
}

ColormapIterator :: struct {
    data : *Colormap;
    rem : s32;
    index : s32;
}

AtomIterator :: struct {
    data : *Atom;
    rem : s32;
    index : s32;
}

DrawableIterator :: struct {
    data : *Drawable;
    rem : s32;
    index : s32;
}

FontableIterator :: struct {
    data : *Fontable;
    rem : s32;
    index : s32;
}

Bool32Iterator :: struct {
    data : *Bool32;
    rem : s32;
    index : s32;
}

VisualidIterator :: struct {
    data : *Visualid;
    rem : s32;
    index : s32;
}

TimestampIterator :: struct {
    data : *Timestamp;
    rem : s32;
    index : s32;
}

KeysymIterator :: struct {
    data : *Keysym;
    rem : s32;
    index : s32;
}

KeycodeIterator :: struct {
    data : *Keycode;
    rem : s32;
    index : s32;
}

Keycode32Iterator :: struct {
    data : *Keycode32;
    rem : s32;
    index : s32;
}

ButtonIterator :: struct {
    data : *Button;
    rem : s32;
    index : s32;
}

Point :: struct {
    x : s16;
    y : s16;
}

PointIterator :: struct {
    data : *Point;
    rem : s32;
    index : s32;
}

Rectangle :: struct {
    x : s16;
    y : s16;
    width : u16;
    height : u16;
}

RectangleIterator :: struct {
    data : *Rectangle;
    rem : s32;
    index : s32;
}

Arc :: struct {
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    angle1 : s16;
    angle2 : s16;
}

ArcIterator :: struct {
    data : *Arc;
    rem : s32;
    index : s32;
}

Format :: struct {
    depth : u8;
    bitsPerPixel : u8;
    scanlinePad : u8;
    pad0 : [5]u8;
}

FormatIterator :: struct {
    data : *Format;
    rem : s32;
    index : s32;
}

Visualtype :: struct {
    visualId : Visualid;
    class : u8;
    bitsPerRgbValue : u8;
    colormapEntries : u16;
    redMask : u32;
    greenMask : u32;
    blueMask : u32;
    pad0 : [4]u8;
}

VisualtypeIterator :: struct {
    data : *Visualtype;
    rem : s32;
    index : s32;
}

Depth :: struct {
    depth : u8;
    pad0 : u8;
    visualsLen : u16;
    pad1 : [4]u8;
}

DepthIterator :: struct {
    data : *Depth;
    rem : s32;
    index : s32;
}

Screen :: struct {
    root : Window;
    defaultColormap : Colormap;
    whitePixel : u32;
    blackPixel : u32;
    currentInputMasks : u32;
    widthInPixels : u16;
    heightInPixels : u16;
    widthInMillimeters : u16;
    heightInMillimeters : u16;
    minInstalledMaps : u16;
    maxInstalledMaps : u16;
    rootVisual : Visualid;
    backingStores : u8;
    saveUnders : u8;
    rootDepth : u8;
    allowedDepthsLen : u8;
}

ScreenIterator :: struct {
    data : *Screen;
    rem : s32;
    index : s32;
}

SetupRequest :: struct {
    byteOrder : u8;
    pad0 : u8;
    protocolMajorVersion : u16;
    protocolMinorVersion : u16;
    authorizationProtocolNameLen : u16;
    authorizationProtocolDataLen : u16;
    pad1 : [2]u8;
}

SetupRequestIterator :: struct {
    data : *SetupRequest;
    rem : s32;
    index : s32;
}

SetupFailed :: struct {
    status : u8;
    reasonLen : u8;
    protocolMajorVersion : u16;
    protocolMinorVersion : u16;
    length : u16;
}

SetupFailedIterator :: struct {
    data : *SetupFailed;
    rem : s32;
    index : s32;
}

SetupAuthenticate :: struct {
    status : u8;
    pad0 : [5]u8;
    length : u16;
}

SetupAuthenticateIterator :: struct {
    data : *SetupAuthenticate;
    rem : s32;
    index : s32;
}

Setup :: struct {
    status : u8;
    pad0 : u8;
    protocolMajorVersion : u16;
    protocolMinorVersion : u16;
    length : u16;
    releaseNumber : u32;
    resourceIdBase : u32;
    resourceIdMask : u32;
    motionBufferSize : u32;
    vendorLen : u16;
    maximumRequestLength : u16;
    rootsLen : u8;
    pixmapFormatsLen : u8;
    imageByteOrder : u8;
    bitmapFormatBitOrder : u8;
    bitmapFormatScanlineUnit : u8;
    bitmapFormatScanlinePad : u8;
    minKeycode : Keycode;
    maxKeycode : Keycode;
    pad1 : [4]u8;
}

SetupIterator :: struct {
    data : *Setup;
    rem : s32;
    index : s32;
}

KeyPressEvent :: struct {
    responseType : u8;
    detail : Keycode;
    sequence : u16;
    time : Timestamp;
    root : Window;
    event : Window;
    child : Window;
    rootX : s16;
    rootY : s16;
    eventX : s16;
    eventY : s16;
    state : u16;
    sameScreen : u8;
    pad0 : u8;
}

ButtonPressEvent :: struct {
    responseType : u8;
    detail : Button;
    sequence : u16;
    time : Timestamp;
    root : Window;
    event : Window;
    child : Window;
    rootX : s16;
    rootY : s16;
    eventX : s16;
    eventY : s16;
    state : u16;
    sameScreen : u8;
    pad0 : u8;
}

MotionNotifyEvent :: struct {
    responseType : u8;
    detail : u8;
    sequence : u16;
    time : Timestamp;
    root : Window;
    event : Window;
    child : Window;
    rootX : s16;
    rootY : s16;
    eventX : s16;
    eventY : s16;
    state : u16;
    sameScreen : u8;
    pad0 : u8;
}

EnterNotifyEvent :: struct {
    responseType : u8;
    detail : u8;
    sequence : u16;
    time : Timestamp;
    root : Window;
    event : Window;
    child : Window;
    rootX : s16;
    rootY : s16;
    eventX : s16;
    eventY : s16;
    state : u16;
    mode : u8;
    sameScreenFocus : u8;
}

FocusInEvent :: struct {
    responseType : u8;
    detail : u8;
    sequence : u16;
    event : Window;
    mode : u8;
    pad0 : [3]u8;
}

KeymapNotifyEvent :: struct {
    responseType : u8;
    keys : [31]u8;
}

ExposeEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    window : Window;
    x : u16;
    y : u16;
    width : u16;
    height : u16;
    count : u16;
    pad1 : [2]u8;
}

GraphicsExposureEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    drawable : Drawable;
    x : u16;
    y : u16;
    width : u16;
    height : u16;
    minorOpcode : u16;
    count : u16;
    majorOpcode : u8;
    pad1 : [3]u8;
}

NoExposureEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    drawable : Drawable;
    minorOpcode : u16;
    majorOpcode : u8;
    pad1 : u8;
}

VisibilityNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    window : Window;
    state : u8;
    pad1 : [3]u8;
}

CreateNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    parent : Window;
    window : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    borderWidth : u16;
    overrideRedirect : u8;
    pad1 : u8;
}

DestroyNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
}

UnmapNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    fromConfigure : u8;
    pad1 : [3]u8;
}

MapNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    overrideRedirect : u8;
    pad1 : [3]u8;
}

MapRequestEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    parent : Window;
    window : Window;
}

ReparentNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    parent : Window;
    x : s16;
    y : s16;
    overrideRedirect : u8;
    pad1 : [3]u8;
}

ConfigureNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    aboveSibling : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    borderWidth : u16;
    overrideRedirect : u8;
    pad1 : u8;
}

ConfigureRequestEvent :: struct {
    responseType : u8;
    stackMode : u8;
    sequence : u16;
    parent : Window;
    window : Window;
    sibling : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    borderWidth : u16;
    valueMask : u16;
}

GravityNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    x : s16;
    y : s16;
}

ResizeRequestEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    window : Window;
    width : u16;
    height : u16;
}

CirculateNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    event : Window;
    window : Window;
    pad1 : [4]u8;
    place : u8;
    pad2 : [3]u8;
}

PropertyNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    window : Window;
    atom : Atom;
    time : Timestamp;
    state : u8;
    pad1 : [3]u8;
}

SelectionClearEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    time : Timestamp;
    owner : Window;
    selection : Atom;
}

SelectionRequestEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    time : Timestamp;
    owner : Window;
    requestor : Window;
    selection : Atom;
    target : Atom;
    property : Atom;
}

SelectionNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    time : Timestamp;
    requestor : Window;
    selection : Atom;
    target : Atom;
    property : Atom;
}

ColormapNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    window : Window;
    colormap : Colormap;
    new : u8;
    state : u8;
    pad1 : [2]u8;
}

ClientMessageDataIterator :: struct {
    data : *ClientMessageData;
    rem : s32;
    index : s32;
}

ClientMessageEvent :: struct {
    responseType : u8;
    format : u8;
    sequence : u16;
    window : Window;
    type : Atom;
    data : ClientMessageData;
}

MappingNotifyEvent :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    request : u8;
    firstKeycode : Keycode;
    count : u8;
    pad1 : u8;
}

GeGenericEvent :: struct {
    responseType : u8;
    extension : u8;
    sequence : u16;
    length : u32;
    eventType : u16;
    pad0 : [22]u8;
    fullSequence : u32;
}

RequestError :: struct {
    responseType : u8;
    errorCode : u8;
    sequence : u16;
    badValue : u32;
    minorOpcode : u16;
    majorOpcode : u8;
    pad0 : u8;
}

ValueError :: struct {
    responseType : u8;
    errorCode : u8;
    sequence : u16;
    badValue : u32;
    minorOpcode : u16;
    majorOpcode : u8;
    pad0 : u8;
}

CreateWindowValueList :: struct {
    backgroundPixmap : Pixmap;
    backgroundPixel : u32;
    borderPixmap : Pixmap;
    borderPixel : u32;
    bitGravity : u32;
    winGravity : u32;
    backingStore : u32;
    backingPlanes : u32;
    backingPixel : u32;
    overrideRedirect : Bool32;
    saveUnder : Bool32;
    eventMask : u32;
    doNotPropogateMask : u32;
    colormap : Colormap;
    cursor : Cursor;
}

CreateWindowRequest :: struct {
    majorOpcode : u8;
    depth : u8;
    length : u16;
    wid : Window;
    parent : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    borderWidth : u16;
    class : u16;
    visual : Visualid;
    valueMask : u32;
}

ChangeWindowAttributesValueList :: struct {
    backgroundPixmap : Pixmap;
    backgroundPixel : u32;
    borderPixmap : Pixmap;
    borderPixel : u32;
    bitGravity : u32;
    winGravity : u32;
    backingStore : u32;
    backingPlanes : u32;
    backingPixel : u32;
    overrideRedirect : Bool32;
    saveUnder : Bool32;
    eventMask : u32;
    doNotPropogateMask : u32;
    colormap : Colormap;
    cursor : Cursor;
}

ChangeWindowAttributesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    valueMask : u32;
}

GetWindowAttributesCookie :: struct {
    sequence : u32;
}

GetWindowAttributesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

GetWindowAttributesReply :: struct {
    responseType : u8;
    backingStore : u8;
    sequence : u16;
    length : u32;
    visual : Visualid;
    class : u16;
    bitGravity : u8;
    winGravity : u8;
    backingPlanes : u32;
    backingPixel : u32;
    saveUnder : u8;
    mapIsInstalled : u8;
    mapState : u8;
    overrideRedirect : u8;
    colormap : Colormap;
    allEventMasks : u32;
    yourEventMask : u32;
    doNotPropagateMask : u16;
    pad0 : [2]u8;
}

DestroyWindowRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

DestroySubwindowsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

ChangeSaveSetRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
    window : Window;
}

ReparentWindowRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    parent : Window;
    x : s16;
    y : s16;
}

MapWindowRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

MapSubwindowsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

UnmapWindowRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

UnmapSubwindowsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

ConfigureWindowValueList :: struct {
    x : s32;
    y : s32;
    width : u32;
    height : u32;
    borderWidth : u32;
    sibling : Window;
    stackMode : u32;
}

ConfigureWindowRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    valueMask : u16;
    pad1 : [2]u8;
}

CirculateWindowRequest :: struct {
    majorOpcode : u8;
    direction : u8;
    length : u16;
    window : Window;
}

GetGeometryCookie :: struct {
    sequence : u32;
}

GetGeometryRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
}

GetGeometryReply :: struct {
    responseType : u8;
    depth : u8;
    sequence : u16;
    length : u32;
    root : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    borderWidth : u16;
    pad0 : [2]u8;
}

QueryTreeCookie :: struct {
    sequence : u32;
}

QueryTreeRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

QueryTreeReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    root : Window;
    parent : Window;
    childrenLen : u16;
    pad1 : [14]u8;
}

InternAtomCookie :: struct {
    sequence : u32;
}

InternAtomRequest :: struct {
    majorOpcode : u8;
    onlyIfExists : u8;
    length : u16;
    nameLen : u16;
    pad0 : [2]u8;
}

InternAtomReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    atom : Atom;
}

GetAtomNameCookie :: struct {
    sequence : u32;
}

GetAtomNameRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    atom : Atom;
}

GetAtomNameReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    nameLen : u16;
    pad1 : [22]u8;
}

ChangePropertyRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
    window : Window;
    property : Atom;
    type : Atom;
    format : u8;
    pad0 : [3]u8;
    dataLen : u32;
}

DeletePropertyRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    property : Atom;
}

GetPropertyCookie :: struct {
    sequence : u32;
}

GetPropertyRequest :: struct {
    majorOpcode : u8;
    delete : u8;
    length : u16;
    window : Window;
    property : Atom;
    type : Atom;
    longOffset : u32;
    longLength : u32;
}

GetPropertyReply :: struct {
    responseType : u8;
    format : u8;
    sequence : u16;
    length : u32;
    type : Atom;
    bytesAfter : u32;
    valueLen : u32;
    pad0 : [12]u8;
}

ListPropertiesCookie :: struct {
    sequence : u32;
}

ListPropertiesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

ListPropertiesReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    atomsLen : u16;
    pad1 : [22]u8;
}

SetSelectionOwnerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    owner : Window;
    selection : Atom;
    time : Timestamp;
}

GetSelectionOwnerCookie :: struct {
    sequence : u32;
}

GetSelectionOwnerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    selection : Atom;
}

GetSelectionOwnerReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    owner : Window;
}

ConvertSelectionRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    requestor : Window;
    selection : Atom;
    target : Atom;
    property : Atom;
    time : Timestamp;
}

SendEventRequest :: struct {
    majorOpcode : u8;
    propagate : u8;
    length : u16;
    destination : Window;
    eventMask : u32;
    event : [32]u8;
}

GrabPointerCookie :: struct {
    sequence : u32;
}

GrabPointerRequest :: struct {
    majorOpcode : u8;
    ownerEvents : u8;
    length : u16;
    grabWindow : Window;
    eventMask : u16;
    pointerMode : u8;
    keyboardMode : u8;
    confineTo : Window;
    cursor : Cursor;
    time : Timestamp;
}

GrabPointerReply :: struct {
    responseType : u8;
    status : u8;
    sequence : u16;
    length : u32;
}

UngrabPointerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    time : Timestamp;
}

GrabButtonRequest :: struct {
    majorOpcode : u8;
    ownerEvents : u8;
    length : u16;
    grabWindow : Window;
    eventMask : u16;
    pointerMode : u8;
    keyboardMode : u8;
    confineTo : Window;
    cursor : Cursor;
    button : u8;
    pad0 : u8;
    modifiers : u16;
}

UngrabButtonRequest :: struct {
    majorOpcode : u8;
    button : u8;
    length : u16;
    grabWindow : Window;
    modifiers : u16;
    pad0 : [2]u8;
}

ChangeActivePointerGrabRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cursor : Cursor;
    time : Timestamp;
    eventMask : u16;
    pad1 : [2]u8;
}

GrabKeyboardCookie :: struct {
    sequence : u32;
}

GrabKeyboardRequest :: struct {
    majorOpcode : u8;
    ownerEvents : u8;
    length : u16;
    grabWindow : Window;
    time : Timestamp;
    pointerMode : u8;
    keyboardMode : u8;
    pad0 : [2]u8;
}

GrabKeyboardReply :: struct {
    responseType : u8;
    status : u8;
    sequence : u16;
    length : u32;
}

UngrabKeyboardRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    time : Timestamp;
}

GrabKeyRequest :: struct {
    majorOpcode : u8;
    ownerEvents : u8;
    length : u16;
    grabWindow : Window;
    modifiers : u16;
    key : Keycode;
    pointerMode : u8;
    keyboardMode : u8;
    pad0 : [3]u8;
}

UngrabKeyRequest :: struct {
    majorOpcode : u8;
    key : Keycode;
    length : u16;
    grabWindow : Window;
    modifiers : u16;
    pad0 : [2]u8;
}

AllowEventsRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
    time : Timestamp;
}

GrabServerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

UngrabServerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

QueryPointerCookie :: struct {
    sequence : u32;
}

QueryPointerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

QueryPointerReply :: struct {
    responseType : u8;
    sameScreen : u8;
    sequence : u16;
    length : u32;
    root : Window;
    child : Window;
    rootX : s16;
    rootY : s16;
    winX : s16;
    winY : s16;
    mask : u16;
    pad0 : [2]u8;
}

Timecoord :: struct {
    time : Timestamp;
    x : s16;
    y : s16;
}

TimecoordIterator :: struct {
    data : *Timecoord;
    rem : s32;
    index : s32;
}

GetMotionEventsCookie :: struct {
    sequence : u32;
}

GetMotionEventsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    start : Timestamp;
    stop : Timestamp;
}

GetMotionEventsReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    eventsLen : u32;
    pad1 : [20]u8;
}

TranslateCoordinatesCookie :: struct {
    sequence : u32;
}

TranslateCoordinatesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    srcWindow : Window;
    dstWindow : Window;
    srcX : s16;
    srcY : s16;
}

TranslateCoordinatesReply :: struct {
    responseType : u8;
    sameScreen : u8;
    sequence : u16;
    length : u32;
    child : Window;
    dstX : s16;
    dstY : s16;
}

WarpPointerRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    srcWindow : Window;
    dstWindow : Window;
    srcX : s16;
    srcY : s16;
    srcWidth : u16;
    srcHeight : u16;
    dstX : s16;
    dstY : s16;
}

SetInputFocusRequest :: struct {
    majorOpcode : u8;
    revertTo : u8;
    length : u16;
    focus : Window;
    time : Timestamp;
}

GetInputFocusCookie :: struct {
    sequence : u32;
}

GetInputFocusRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetInputFocusReply :: struct {
    responseType : u8;
    revertTo : u8;
    sequence : u16;
    length : u32;
    focus : Window;
}

QueryKeymapCookie :: struct {
    sequence : u32;
}

QueryKeymapRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

QueryKeymapReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    keys : [32]u8;
}

OpenFontRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    fid : Font;
    nameLen : u16;
    pad1 : [2]u8;
}

CloseFontRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    font : Font;
}

Fontprop :: struct {
    name : Atom;
    value : u32;
}

FontpropIterator :: struct {
    data : *Fontprop;
    rem : s32;
    index : s32;
}

Charinfo :: struct {
    leftSideBearing : s16;
    rightSideBearing : s16;
    characterWidth : s16;
    ascent : s16;
    descent : s16;
    attributes : u16;
}

CharinfoIterator :: struct {
    data : *Charinfo;
    rem : s32;
    index : s32;
}

QueryFontCookie :: struct {
    sequence : u32;
}

QueryFontRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    font : Fontable;
}

QueryFontReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    minBounds : Charinfo;
    pad1 : [4]u8;
    maxBounds : Charinfo;
    pad2 : [4]u8;
    minCharOrByte2 : u16;
    maxCharOrByte2 : u16;
    defaultChar : u16;
    propertiesLen : u16;
    drawDirection : u8;
    minByte1 : u8;
    maxByte1 : u8;
    allCharsExist : u8;
    fontAscent : s16;
    fontDescent : s16;
    charInfosLen : u32;
}

QueryTextExtentsCookie :: struct {
    sequence : u32;
}

QueryTextExtentsRequest :: struct {
    majorOpcode : u8;
    oddLength : u8;
    length : u16;
    font : Fontable;
}

QueryTextExtentsReply :: struct {
    responseType : u8;
    drawDirection : u8;
    sequence : u16;
    length : u32;
    fontAscent : s16;
    fontDescent : s16;
    overallAscent : s16;
    overallDescent : s16;
    overallWidth : s32;
    overallLeft : s32;
    overallRight : s32;
}

Str :: struct {
    nameLen : u8;
}

StrIterator :: struct {
    data : *Str;
    rem : s32;
    index : s32;
}

ListFontsCookie :: struct {
    sequence : u32;
}

ListFontsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    maxNames : u16;
    patternLen : u16;
}

ListFontsReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    namesLen : u16;
    pad1 : [22]u8;
}

ListFontsWithInfoCookie :: struct {
    sequence : u32;
}

ListFontsWithInfoRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    maxNames : u16;
    patternLen : u16;
}

ListFontsWithInfoReply :: struct {
    responseType : u8;
    nameLen : u8;
    sequence : u16;
    length : u32;
    minBounds : Charinfo;
    pad0 : [4]u8;
    maxBounds : Charinfo;
    pad1 : [4]u8;
    minCharOrByte2 : u16;
    maxCharOrByte2 : u16;
    defaultChar : u16;
    propertiesLen : u16;
    drawDirection : u8;
    minByte1 : u8;
    maxByte1 : u8;
    allCharsExist : u8;
    fontAscent : s16;
    fontDescent : s16;
    repliesHint : u32;
}

SetFontPathRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    fontQty : u16;
    pad1 : [2]u8;
}

GetFontPathCookie :: struct {
    sequence : u32;
}

GetFontPathRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetFontPathReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    pathLen : u16;
    pad1 : [22]u8;
}

CreatePixmapRequest :: struct {
    majorOpcode : u8;
    depth : u8;
    length : u16;
    pid : Pixmap;
    drawable : Drawable;
    width : u16;
    height : u16;
}

FreePixmapRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    pixmap : Pixmap;
}

CreateGcValueList :: struct {
    function : u32;
    planeMask : u32;
    foreground : u32;
    background : u32;
    lineWidth : u32;
    lineStyle : u32;
    capStyle : u32;
    joinStyle : u32;
    fillStyle : u32;
    fillRule : u32;
    tile : Pixmap;
    stipple : Pixmap;
    tileStippleX_origin : s32;
    tileStippleY_origin : s32;
    font : Font;
    subwindowMode : u32;
    graphicsExposures : Bool32;
    clipX_origin : s32;
    clipY_origin : s32;
    clipMask : Pixmap;
    dashOffset : u32;
    dashes : u32;
    arcMode : u32;
}

CreateGcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cid : Gcontext;
    drawable : Drawable;
    valueMask : u32;
}

ChangeGcValueList :: struct {
    function : u32;
    planeMask : u32;
    foreground : u32;
    background : u32;
    lineWidth : u32;
    lineStyle : u32;
    capStyle : u32;
    joinStyle : u32;
    fillStyle : u32;
    fillRule : u32;
    tile : Pixmap;
    stipple : Pixmap;
    tileStippleX_origin : s32;
    tileStippleY_origin : s32;
    font : Font;
    subwindowMode : u32;
    graphicsExposures : Bool32;
    clipX_origin : s32;
    clipY_origin : s32;
    clipMask : Pixmap;
    dashOffset : u32;
    dashes : u32;
    arcMode : u32;
}

ChangeGcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    gc : Gcontext;
    valueMask : u32;
}

CopyGcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    srcGc : Gcontext;
    dstGc : Gcontext;
    valueMask : u32;
}

SetDashesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    gc : Gcontext;
    dashOffset : u16;
    dashesLen : u16;
}

SetClipRectanglesRequest :: struct {
    majorOpcode : u8;
    ordering : u8;
    length : u16;
    gc : Gcontext;
    clipX_origin : s16;
    clipY_origin : s16;
}

FreeGcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    gc : Gcontext;
}

ClearAreaRequest :: struct {
    majorOpcode : u8;
    exposures : u8;
    length : u16;
    window : Window;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
}

CopyAreaRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    srcDrawable : Drawable;
    dstDrawable : Drawable;
    gc : Gcontext;
    srcX : s16;
    srcY : s16;
    dstX : s16;
    dstY : s16;
    width : u16;
    height : u16;
}

CopyPlaneRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    srcDrawable : Drawable;
    dstDrawable : Drawable;
    gc : Gcontext;
    srcX : s16;
    srcY : s16;
    dstX : s16;
    dstY : s16;
    width : u16;
    height : u16;
    bitPlane : u32;
}

PolyPointRequest :: struct {
    majorOpcode : u8;
    coordinateMode : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

PolyLineRequest :: struct {
    majorOpcode : u8;
    coordinateMode : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

Segment :: struct {
    x1 : s16;
    y1 : s16;
    x2 : s16;
    y2 : s16;
}

SegmentIterator :: struct {
    data : *Segment;
    rem : s32;
    index : s32;
}

PolySegmentRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

PolyRectangleRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

PolyArcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

FillPolyRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    shape : u8;
    coordinateMode : u8;
    pad1 : [2]u8;
}

PolyFillRectangleRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

PolyFillArcRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
}

PutImageRequest :: struct {
    majorOpcode : u8;
    format : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    width : u16;
    height : u16;
    dstX : s16;
    dstY : s16;
    leftPad : u8;
    depth : u8;
    pad0 : [2]u8;
}

GetImageCookie :: struct {
    sequence : u32;
}

GetImageRequest :: struct {
    majorOpcode : u8;
    format : u8;
    length : u16;
    drawable : Drawable;
    x : s16;
    y : s16;
    width : u16;
    height : u16;
    planeMask : u32;
}

GetImageReply :: struct {
    responseType : u8;
    depth : u8;
    sequence : u16;
    length : u32;
    visual : Visualid;
    pad0 : [20]u8;
}

PolyText8_request :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    x : s16;
    y : s16;
}

PolyText16Request :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    x : s16;
    y : s16;
}

ImageText8_request :: struct {
    majorOpcode : u8;
    stringLen : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    x : s16;
    y : s16;
}

ImageText16Request :: struct {
    majorOpcode : u8;
    stringLen : u8;
    length : u16;
    drawable : Drawable;
    gc : Gcontext;
    x : s16;
    y : s16;
}

CreateColormapRequest :: struct {
    majorOpcode : u8;
    alloc : u8;
    length : u16;
    mid : Colormap;
    window : Window;
    visual : Visualid;
}

FreeColormapRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
}

CopyColormapAndFreeRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    mid : Colormap;
    srcCmap : Colormap;
}

InstallColormapRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
}

UninstallColormapRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
}

ListInstalledColormapsCookie :: struct {
    sequence : u32;
}

ListInstalledColormapsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
}

ListInstalledColormapsReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    cmapsLen : u16;
    pad1 : [22]u8;
}

AllocColorCookie :: struct {
    sequence : u32;
}

AllocColorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
    red : u16;
    green : u16;
    blue : u16;
    pad1 : [2]u8;
}

AllocColorReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    red : u16;
    green : u16;
    blue : u16;
    pad1 : [2]u8;
    pixel : u32;
}

AllocNamedColorCookie :: struct {
    sequence : u32;
}

AllocNamedColorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
    nameLen : u16;
    pad1 : [2]u8;
}

AllocNamedColorReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    pixel : u32;
    exactRed : u16;
    exactGreen : u16;
    exactBlue : u16;
    visualRed : u16;
    visualGreen : u16;
    visualBlue : u16;
}

AllocColorCellsCookie :: struct {
    sequence : u32;
}

AllocColorCellsRequest :: struct {
    majorOpcode : u8;
    contiguous : u8;
    length : u16;
    cmap : Colormap;
    colors : u16;
    planes : u16;
}

AllocColorCellsReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    pixelsLen : u16;
    masksLen : u16;
    pad1 : [20]u8;
}

AllocColorPlanesCookie :: struct {
    sequence : u32;
}

AllocColorPlanesRequest :: struct {
    majorOpcode : u8;
    contiguous : u8;
    length : u16;
    cmap : Colormap;
    colors : u16;
    reds : u16;
    greens : u16;
    blues : u16;
}

AllocColorPlanesReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    pixelsLen : u16;
    pad1 : [2]u8;
    redMask : u32;
    greenMask : u32;
    blueMask : u32;
    pad2 : [8]u8;
}

FreeColorsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
    planeMask : u32;
}

Coloritem :: struct {
    pixel : u32;
    red : u16;
    green : u16;
    blue : u16;
    flags : u8;
    pad0 : u8;
}

ColoritemIterator :: struct {
    data : *Coloritem;
    rem : s32;
    index : s32;
}

StoreColorsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
}

StoreNamedColorRequest :: struct {
    majorOpcode : u8;
    flags : u8;
    length : u16;
    cmap : Colormap;
    pixel : u32;
    nameLen : u16;
    pad0 : [2]u8;
}

Rgb :: struct {
    red : u16;
    green : u16;
    blue : u16;
    pad0 : [2]u8;
}

RgbIterator :: struct {
    data : *Rgb;
    rem : s32;
    index : s32;
}

QueryColorsCookie :: struct {
    sequence : u32;
}

QueryColorsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
}

QueryColorsReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    colorsLen : u16;
    pad1 : [22]u8;
}

LookupColorCookie :: struct {
    sequence : u32;
}

LookupColorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cmap : Colormap;
    nameLen : u16;
    pad1 : [2]u8;
}

LookupColorReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    exactRed : u16;
    exactGreen : u16;
    exactBlue : u16;
    visualRed : u16;
    visualGreen : u16;
    visualBlue : u16;
}

CreateCursorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cid : Cursor;
    source : Pixmap;
    mask : Pixmap;
    foreRed : u16;
    foreGreen : u16;
    foreBlue : u16;
    backRed : u16;
    backGreen : u16;
    backBlue : u16;
    x : u16;
    y : u16;
}

CreateGlyphCursorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cid : Cursor;
    sourceFont : Font;
    maskFont : Font;
    sourceChar : u16;
    maskChar : u16;
    foreRed : u16;
    foreGreen : u16;
    foreBlue : u16;
    backRed : u16;
    backGreen : u16;
    backBlue : u16;
}

FreeCursorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cursor : Cursor;
}

RecolorCursorRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    cursor : Cursor;
    foreRed : u16;
    foreGreen : u16;
    foreBlue : u16;
    backRed : u16;
    backGreen : u16;
    backBlue : u16;
}

QueryBestSizeCookie :: struct {
    sequence : u32;
}

QueryBestSizeRequest :: struct {
    majorOpcode : u8;
    class : u8;
    length : u16;
    drawable : Drawable;
    width : u16;
    height : u16;
}

QueryBestSizeReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    width : u16;
    height : u16;
}

QueryExtensionCookie :: struct {
    sequence : u32;
}

QueryExtensionRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    nameLen : u16;
    pad1 : [2]u8;
}

QueryExtensionReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    present : u8;
    majorOpcode : u8;
    firstEvent : u8;
    firstError : u8;
}

ListExtensionsCookie :: struct {
    sequence : u32;
}

ListExtensionsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

ListExtensionsReply :: struct {
    responseType : u8;
    namesLen : u8;
    sequence : u16;
    length : u32;
    pad0 : [24]u8;
}

ChangeKeyboardMappingRequest :: struct {
    majorOpcode : u8;
    keycodeCount : u8;
    length : u16;
    firstKeycode : Keycode;
    keysymsPerKeycode : u8;
    pad0 : [2]u8;
}

GetKeyboardMappingCookie :: struct {
    sequence : u32;
}

GetKeyboardMappingRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    firstKeycode : Keycode;
    count : u8;
}

GetKeyboardMappingReply :: struct {
    responseType : u8;
    keysymsPerKeycode : u8;
    sequence : u16;
    length : u32;
    pad0 : [24]u8;
}

ChangeKeyboardControlValueList :: struct {
    keyClickPercent : s32;
    bellPercent : s32;
    bellPitch : s32;
    bellDuration : s32;
    led : u32;
    ledMode : u32;
    key : Keycode32;
    autoRepeatMode : u32;
}

ChangeKeyboardControlRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    valueMask : u32;
}

GetKeyboardControlCookie :: struct {
    sequence : u32;
}

GetKeyboardControlRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetKeyboardControlReply :: struct {
    responseType : u8;
    globalAutoRepeat : u8;
    sequence : u16;
    length : u32;
    ledMask : u32;
    keyClickPercent : u8;
    bellPercent : u8;
    bellPitch : u16;
    bellDuration : u16;
    pad0 : [2]u8;
    autoRepeats : [32]u8;
}

BellRequest :: struct {
    majorOpcode : u8;
    percent : s8;
    length : u16;
}

ChangePointerControlRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    accelerationNumerator : s16;
    accelerationDenominator : s16;
    threshold : s16;
    doAcceleration : u8;
    doThreshold : u8;
}

GetPointerControlCookie :: struct {
    sequence : u32;
}

GetPointerControlRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetPointerControlReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    accelerationNumerator : u16;
    accelerationDenominator : u16;
    threshold : u16;
    pad1 : [18]u8;
}

SetScreenSaverRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    timeout : s16;
    interval : s16;
    preferBlanking : u8;
    allowExposures : u8;
}

GetScreenSaverCookie :: struct {
    sequence : u32;
}

GetScreenSaverRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetScreenSaverReply :: struct {
    responseType : u8;
    pad0 : u8;
    sequence : u16;
    length : u32;
    timeout : u16;
    interval : u16;
    preferBlanking : u8;
    allowExposures : u8;
    pad1 : [18]u8;
}

ChangeHostsRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
    family : u8;
    pad0 : u8;
    addressLen : u16;
}

Host :: struct {
    family : u8;
    pad0 : u8;
    addressLen : u16;
}

HostIterator :: struct {
    data : *Host;
    rem : s32;
    index : s32;
}

ListHostsCookie :: struct {
    sequence : u32;
}

ListHostsRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

ListHostsReply :: struct {
    responseType : u8;
    mode : u8;
    sequence : u16;
    length : u32;
    hostsLen : u16;
    pad0 : [22]u8;
}

SetAccessControlRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
}

SetCloseDownModeRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
}

KillClientRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    resource : u32;
}

RotatePropertiesRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
    window : Window;
    atomsLen : u16;
    delta : s16;
}

ForceScreenSaverRequest :: struct {
    majorOpcode : u8;
    mode : u8;
    length : u16;
}

SetPointerMappingCookie :: struct {
    sequence : u32;
}

SetPointerMappingRequest :: struct {
    majorOpcode : u8;
    mapLen : u8;
    length : u16;
}

SetPointerMappingReply :: struct {
    responseType : u8;
    status : u8;
    sequence : u16;
    length : u32;
}

GetPointerMappingCookie :: struct {
    sequence : u32;
}

GetPointerMappingRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetPointerMappingReply :: struct {
    responseType : u8;
    mapLen : u8;
    sequence : u16;
    length : u32;
    pad0 : [24]u8;
}

SetModifierMappingCookie :: struct {
    sequence : u32;
}

SetModifierMappingRequest :: struct {
    majorOpcode : u8;
    keycodesPerModifier : u8;
    length : u16;
}

SetModifierMappingReply :: struct {
    responseType : u8;
    status : u8;
    sequence : u16;
    length : u32;
}

GetModifierMappingCookie :: struct {
    sequence : u32;
}

GetModifierMappingRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

GetModifierMappingReply :: struct {
    responseType : u8;
    keycodesPerModifier : u8;
    sequence : u16;
    length : u32;
    pad0 : [24]u8;
}

NoOperationRequest :: struct {
    majorOpcode : u8;
    pad0 : u8;
    length : u16;
}

ClientMessageData :: union {
    data8 : [20]u8;
    data16 : [10]u16;
    data32 : [5]u32;
}

flush :: (c : *Connection) -> s32 #foreign libxcb "xcb_flush";

get_maximum_request_length :: (c : *Connection) -> u32 #foreign libxcb "xcb_get_maximum_request_length";

prefetch_maximum_request_length :: (c : *Connection) -> void #foreign libxcb "xcb_prefetch_maximum_request_length";

wait_for_event :: (c : *Connection) -> *GenericEvent #foreign libxcb "xcb_wait_for_event";

poll_for_event :: (c : *Connection) -> *GenericEvent #foreign libxcb "xcb_poll_for_event";

poll_for_queued_event :: (c : *Connection) -> *GenericEvent #foreign libxcb "xcb_poll_for_queued_event";

request_check :: (
    c : *Connection,
    cookie : VoidCookie
) -> *GenericError #foreign libxcb "xcb_request_check";

discard_reply :: (
    c : *Connection,
    sequence : u32
) -> void #foreign libxcb "xcb_discard_reply";

get_extension_data :: (
    c : *Connection,
    ext : *Extension
) -> *QueryExtensionReply #foreign libxcb "xcb_get_extension_data";

prefetch_extension_data :: (
    c : *Connection,
    ext : *Extension
) -> void #foreign libxcb "xcb_prefetch_extension_data";

get_setup :: (c : *Connection) -> *Setup #foreign libxcb "xcb_get_setup";

get_file_descriptor :: (c : *Connection) -> s32 #foreign libxcb "xcb_get_file_descriptor";

connection_has_error :: (c : *Connection) -> s32 #foreign libxcb "xcb_connection_has_error";

connect_to_fd :: (
    fd : s32,
    authInfo : *AuthInfo
) -> *Connection #foreign libxcb "xcb_connect_to_fd";

disconnect :: (c : *Connection) -> void #foreign libxcb "xcb_disconnect";

parse_display :: (
    name : *u8,
    host : **u8,
    display : *s32,
    screen : *s32
) -> s32 #foreign libxcb "xcb_parse_display";

connect :: (
    displayname : *u8,
    screenp : *s32
) -> *Connection #foreign libxcb "xcb_connect";

connect_to_display_with_auth_info :: (
    display : *u8,
    auth : *AuthInfo,
    screen : *s32
) -> *Connection #foreign libxcb "xcb_connect_to_display_with_auth_info";

generate_id :: (c : *Connection) -> u32 #foreign libxcb "xcb_generate_id";

char2b_next :: (i : *Char2BIterator) -> void #foreign libxcb "xcb_char2b_next";

char2b_end :: (i : Char2BIterator) -> GenericIterator #foreign libxcb "xcb_char2b_end";

window_next :: (i : *WindowIterator) -> void #foreign libxcb "xcb_window_next";

window_end :: (i : WindowIterator) -> GenericIterator #foreign libxcb "xcb_window_end";

pixmap_next :: (i : *PixmapIterator) -> void #foreign libxcb "xcb_pixmap_next";

pixmap_end :: (i : PixmapIterator) -> GenericIterator #foreign libxcb "xcb_pixmap_end";

cursor_next :: (i : *CursorIterator) -> void #foreign libxcb "xcb_cursor_next";

cursor_end :: (i : CursorIterator) -> GenericIterator #foreign libxcb "xcb_cursor_end";

font_next :: (i : *FontIterator) -> void #foreign libxcb "xcb_font_next";

font_end :: (i : FontIterator) -> GenericIterator #foreign libxcb "xcb_font_end";

gcontext_next :: (i : *GcontextIterator) -> void #foreign libxcb "xcb_gcontext_next";

gcontext_end :: (i : GcontextIterator) -> GenericIterator #foreign libxcb "xcb_gcontext_end";

colormap_next :: (i : *ColormapIterator) -> void #foreign libxcb "xcb_colormap_next";

colormap_end :: (i : ColormapIterator) -> GenericIterator #foreign libxcb "xcb_colormap_end";

atom_next :: (i : *AtomIterator) -> void #foreign libxcb "xcb_atom_next";

atom_end :: (i : AtomIterator) -> GenericIterator #foreign libxcb "xcb_atom_end";

drawable_next :: (i : *DrawableIterator) -> void #foreign libxcb "xcb_drawable_next";

drawable_end :: (i : DrawableIterator) -> GenericIterator #foreign libxcb "xcb_drawable_end";

fontable_next :: (i : *FontableIterator) -> void #foreign libxcb "xcb_fontable_next";

fontable_end :: (i : FontableIterator) -> GenericIterator #foreign libxcb "xcb_fontable_end";

bool32_next :: (i : *Bool32Iterator) -> void #foreign libxcb "xcb_bool32_next";

bool32_end :: (i : Bool32Iterator) -> GenericIterator #foreign libxcb "xcb_bool32_end";

visualid_next :: (i : *VisualidIterator) -> void #foreign libxcb "xcb_visualid_next";

visualid_end :: (i : VisualidIterator) -> GenericIterator #foreign libxcb "xcb_visualid_end";

timestamp_next :: (i : *TimestampIterator) -> void #foreign libxcb "xcb_timestamp_next";

timestamp_end :: (i : TimestampIterator) -> GenericIterator #foreign libxcb "xcb_timestamp_end";

keysym_next :: (i : *KeysymIterator) -> void #foreign libxcb "xcb_keysym_next";

keysym_end :: (i : KeysymIterator) -> GenericIterator #foreign libxcb "xcb_keysym_end";

keycode_next :: (i : *KeycodeIterator) -> void #foreign libxcb "xcb_keycode_next";

keycode_end :: (i : KeycodeIterator) -> GenericIterator #foreign libxcb "xcb_keycode_end";

keycode32_next :: (i : *Keycode32Iterator) -> void #foreign libxcb "xcb_keycode32_next";

keycode32_end :: (i : Keycode32Iterator) -> GenericIterator #foreign libxcb "xcb_keycode32_end";

button_next :: (i : *ButtonIterator) -> void #foreign libxcb "xcb_button_next";

button_end :: (i : ButtonIterator) -> GenericIterator #foreign libxcb "xcb_button_end";

point_next :: (i : *PointIterator) -> void #foreign libxcb "xcb_point_next";

point_end :: (i : PointIterator) -> GenericIterator #foreign libxcb "xcb_point_end";

rectangle_next :: (i : *RectangleIterator) -> void #foreign libxcb "xcb_rectangle_next";

rectangle_end :: (i : RectangleIterator) -> GenericIterator #foreign libxcb "xcb_rectangle_end";

arc_next :: (i : *ArcIterator) -> void #foreign libxcb "xcb_arc_next";

arc_end :: (i : ArcIterator) -> GenericIterator #foreign libxcb "xcb_arc_end";

format_next :: (i : *FormatIterator) -> void #foreign libxcb "xcb_format_next";

format_end :: (i : FormatIterator) -> GenericIterator #foreign libxcb "xcb_format_end";

visualtype_next :: (i : *VisualtypeIterator) -> void #foreign libxcb "xcb_visualtype_next";

visualtype_end :: (i : VisualtypeIterator) -> GenericIterator #foreign libxcb "xcb_visualtype_end";

depth_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_depth_sizeof";

depth_visuals :: (r : *Depth) -> *Visualtype #foreign libxcb "xcb_depth_visuals";

depth_visuals_length :: (r : *Depth) -> s32 #foreign libxcb "xcb_depth_visuals_length";

depth_visuals_iterator :: (r : *Depth) -> VisualtypeIterator #foreign libxcb "xcb_depth_visuals_iterator";

depth_next :: (i : *DepthIterator) -> void #foreign libxcb "xcb_depth_next";

depth_end :: (i : DepthIterator) -> GenericIterator #foreign libxcb "xcb_depth_end";

screen_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_screen_sizeof";

screen_allowed_depths_length :: (r : *Screen) -> s32 #foreign libxcb "xcb_screen_allowed_depths_length";

screen_allowed_depths_iterator :: (r : *Screen) -> DepthIterator #foreign libxcb "xcb_screen_allowed_depths_iterator";

screen_next :: (i : *ScreenIterator) -> void #foreign libxcb "xcb_screen_next";

screen_end :: (i : ScreenIterator) -> GenericIterator #foreign libxcb "xcb_screen_end";

setup_request_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_setup_request_sizeof";

setup_request_authorization_protocol_name :: (r : *SetupRequest) -> *u8 #foreign libxcb "xcb_setup_request_authorization_protocol_name";

setup_request_authorization_protocol_name_length :: (r : *SetupRequest) -> s32 #foreign libxcb "xcb_setup_request_authorization_protocol_name_length";

setup_request_authorization_protocol_name_end :: (r : *SetupRequest) -> GenericIterator #foreign libxcb "xcb_setup_request_authorization_protocol_name_end";

setup_request_authorization_protocol_data :: (r : *SetupRequest) -> *u8 #foreign libxcb "xcb_setup_request_authorization_protocol_data";

setup_request_authorization_protocol_data_length :: (r : *SetupRequest) -> s32 #foreign libxcb "xcb_setup_request_authorization_protocol_data_length";

setup_request_authorization_protocol_data_end :: (r : *SetupRequest) -> GenericIterator #foreign libxcb "xcb_setup_request_authorization_protocol_data_end";

setup_request_next :: (i : *SetupRequestIterator) -> void #foreign libxcb "xcb_setup_request_next";

setup_request_end :: (i : SetupRequestIterator) -> GenericIterator #foreign libxcb "xcb_setup_request_end";

setup_failed_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_setup_failed_sizeof";

setup_failed_reason :: (r : *SetupFailed) -> *u8 #foreign libxcb "xcb_setup_failed_reason";

setup_failed_reason_length :: (r : *SetupFailed) -> s32 #foreign libxcb "xcb_setup_failed_reason_length";

setup_failed_reason_end :: (r : *SetupFailed) -> GenericIterator #foreign libxcb "xcb_setup_failed_reason_end";

setup_failed_next :: (i : *SetupFailedIterator) -> void #foreign libxcb "xcb_setup_failed_next";

setup_failed_end :: (i : SetupFailedIterator) -> GenericIterator #foreign libxcb "xcb_setup_failed_end";

setup_authenticate_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_setup_authenticate_sizeof";

setup_authenticate_reason :: (r : *SetupAuthenticate) -> *u8 #foreign libxcb "xcb_setup_authenticate_reason";

setup_authenticate_reason_length :: (r : *SetupAuthenticate) -> s32 #foreign libxcb "xcb_setup_authenticate_reason_length";

setup_authenticate_reason_end :: (r : *SetupAuthenticate) -> GenericIterator #foreign libxcb "xcb_setup_authenticate_reason_end";

setup_authenticate_next :: (i : *SetupAuthenticateIterator) -> void #foreign libxcb "xcb_setup_authenticate_next";

setup_authenticate_end :: (i : SetupAuthenticateIterator) -> GenericIterator #foreign libxcb "xcb_setup_authenticate_end";

setup_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_setup_sizeof";

setup_vendor :: (r : *Setup) -> *u8 #foreign libxcb "xcb_setup_vendor";

setup_vendor_length :: (r : *Setup) -> s32 #foreign libxcb "xcb_setup_vendor_length";

setup_vendor_end :: (r : *Setup) -> GenericIterator #foreign libxcb "xcb_setup_vendor_end";

setup_pixmap_formats :: (r : *Setup) -> *Format #foreign libxcb "xcb_setup_pixmap_formats";

setup_pixmap_formats_length :: (r : *Setup) -> s32 #foreign libxcb "xcb_setup_pixmap_formats_length";

setup_pixmap_formats_iterator :: (r : *Setup) -> FormatIterator #foreign libxcb "xcb_setup_pixmap_formats_iterator";

setup_roots_length :: (r : *Setup) -> s32 #foreign libxcb "xcb_setup_roots_length";

setup_roots_iterator :: (r : *Setup) -> ScreenIterator #foreign libxcb "xcb_setup_roots_iterator";

setup_next :: (i : *SetupIterator) -> void #foreign libxcb "xcb_setup_next";

setup_end :: (i : SetupIterator) -> GenericIterator #foreign libxcb "xcb_setup_end";

client_message_data_next :: (i : *ClientMessageDataIterator) -> void #foreign libxcb "xcb_client_message_data_next";

client_message_data_end :: (i : ClientMessageDataIterator) -> GenericIterator #foreign libxcb "xcb_client_message_data_end";

create_window_value_list_serialize :: (
    buffer : **void,
    valueMask : u32,
    aux : *CreateWindowValueList
) -> s32 #foreign libxcb "xcb_create_window_value_list_serialize";

create_window_value_list_unpack :: (
    buffer : *void,
    valueMask : u32,
    aux : *CreateWindowValueList
) -> s32 #foreign libxcb "xcb_create_window_value_list_unpack";

create_window_value_list_sizeof :: (
    buffer : *void,
    valueMask : u32
) -> s32 #foreign libxcb "xcb_create_window_value_list_sizeof";

create_window_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_create_window_sizeof";

create_window_checked :: (
    c : *Connection,
    depth : u8,
    wid : Window,
    parent : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    borderWidth : u16,
    class : u16,
    visual : Visualid,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_create_window_checked";

create_window :: (
    c : *Connection,
    depth : u8,
    wid : Window,
    parent : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    borderWidth : u16,
    class : u16,
    visual : Visualid,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_create_window";

create_window_aux_checked :: (
    c : *Connection,
    depth : u8,
    wid : Window,
    parent : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    borderWidth : u16,
    class : u16,
    visual : Visualid,
    valueMask : u32,
    valueList : *CreateWindowValueList
) -> VoidCookie #foreign libxcb "xcb_create_window_aux_checked";

create_window_aux :: (
    c : *Connection,
    depth : u8,
    wid : Window,
    parent : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    borderWidth : u16,
    class : u16,
    visual : Visualid,
    valueMask : u32,
    valueList : *CreateWindowValueList
) -> VoidCookie #foreign libxcb "xcb_create_window_aux";

create_window_value_list :: (r : *CreateWindowRequest) -> *void #foreign libxcb "xcb_create_window_value_list";

change_window_attributes_value_list_serialize :: (
    buffer : **void,
    valueMask : u32,
    aux : *ChangeWindowAttributesValueList
) -> s32 #foreign libxcb "xcb_change_window_attributes_value_list_serialize";

change_window_attributes_value_list_unpack :: (
    buffer : *void,
    valueMask : u32,
    aux : *ChangeWindowAttributesValueList
) -> s32 #foreign libxcb "xcb_change_window_attributes_value_list_unpack";

change_window_attributes_value_list_sizeof :: (
    buffer : *void,
    valueMask : u32
) -> s32 #foreign libxcb "xcb_change_window_attributes_value_list_sizeof";

change_window_attributes_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_window_attributes_sizeof";

change_window_attributes_checked :: (
    c : *Connection,
    window : Window,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_window_attributes_checked";

change_window_attributes :: (
    c : *Connection,
    window : Window,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_window_attributes";

change_window_attributes_aux_checked :: (
    c : *Connection,
    window : Window,
    valueMask : u32,
    valueList : *ChangeWindowAttributesValueList
) -> VoidCookie #foreign libxcb "xcb_change_window_attributes_aux_checked";

change_window_attributes_aux :: (
    c : *Connection,
    window : Window,
    valueMask : u32,
    valueList : *ChangeWindowAttributesValueList
) -> VoidCookie #foreign libxcb "xcb_change_window_attributes_aux";

change_window_attributes_value_list :: (r : *ChangeWindowAttributesRequest) -> *void #foreign libxcb "xcb_change_window_attributes_value_list";

get_window_attributes :: (
    c : *Connection,
    window : Window
) -> GetWindowAttributesCookie #foreign libxcb "xcb_get_window_attributes";

get_window_attributes_unchecked :: (
    c : *Connection,
    window : Window
) -> GetWindowAttributesCookie #foreign libxcb "xcb_get_window_attributes_unchecked";

get_window_attributes_reply :: (
    c : *Connection,
    cookie : GetWindowAttributesCookie,
    e : **GenericError
) -> *GetWindowAttributesReply #foreign libxcb "xcb_get_window_attributes_reply";

destroy_window_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_destroy_window_checked";

destroy_window :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_destroy_window";

destroy_subwindows_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_destroy_subwindows_checked";

destroy_subwindows :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_destroy_subwindows";

change_save_set_checked :: (
    c : *Connection,
    mode : u8,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_change_save_set_checked";

change_save_set :: (
    c : *Connection,
    mode : u8,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_change_save_set";

reparent_window_checked :: (
    c : *Connection,
    window : Window,
    parent : Window,
    x : s16,
    y : s16
) -> VoidCookie #foreign libxcb "xcb_reparent_window_checked";

reparent_window :: (
    c : *Connection,
    window : Window,
    parent : Window,
    x : s16,
    y : s16
) -> VoidCookie #foreign libxcb "xcb_reparent_window";

map_window_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_map_window_checked";

map_window :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_map_window";

map_subwindows_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_map_subwindows_checked";

map_subwindows :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_map_subwindows";

unmap_window_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_unmap_window_checked";

unmap_window :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_unmap_window";

unmap_subwindows_checked :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_unmap_subwindows_checked";

unmap_subwindows :: (
    c : *Connection,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_unmap_subwindows";

configure_window_value_list_serialize :: (
    buffer : **void,
    valueMask : u16,
    aux : *ConfigureWindowValueList
) -> s32 #foreign libxcb "xcb_configure_window_value_list_serialize";

configure_window_value_list_unpack :: (
    buffer : *void,
    valueMask : u16,
    aux : *ConfigureWindowValueList
) -> s32 #foreign libxcb "xcb_configure_window_value_list_unpack";

configure_window_value_list_sizeof :: (
    buffer : *void,
    valueMask : u16
) -> s32 #foreign libxcb "xcb_configure_window_value_list_sizeof";

configure_window_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_configure_window_sizeof";

configure_window_checked :: (
    c : *Connection,
    window : Window,
    valueMask : u16,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_configure_window_checked";

configure_window :: (
    c : *Connection,
    window : Window,
    valueMask : u16,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_configure_window";

configure_window_aux_checked :: (
    c : *Connection,
    window : Window,
    valueMask : u16,
    valueList : *ConfigureWindowValueList
) -> VoidCookie #foreign libxcb "xcb_configure_window_aux_checked";

configure_window_aux :: (
    c : *Connection,
    window : Window,
    valueMask : u16,
    valueList : *ConfigureWindowValueList
) -> VoidCookie #foreign libxcb "xcb_configure_window_aux";

configure_window_value_list :: (r : *ConfigureWindowRequest) -> *void #foreign libxcb "xcb_configure_window_value_list";

circulate_window_checked :: (
    c : *Connection,
    direction : u8,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_circulate_window_checked";

circulate_window :: (
    c : *Connection,
    direction : u8,
    window : Window
) -> VoidCookie #foreign libxcb "xcb_circulate_window";

get_geometry :: (
    c : *Connection,
    drawable : Drawable
) -> GetGeometryCookie #foreign libxcb "xcb_get_geometry";

get_geometry_unchecked :: (
    c : *Connection,
    drawable : Drawable
) -> GetGeometryCookie #foreign libxcb "xcb_get_geometry_unchecked";

get_geometry_reply :: (
    c : *Connection,
    cookie : GetGeometryCookie,
    e : **GenericError
) -> *GetGeometryReply #foreign libxcb "xcb_get_geometry_reply";

query_tree_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_query_tree_sizeof";

query_tree :: (
    c : *Connection,
    window : Window
) -> QueryTreeCookie #foreign libxcb "xcb_query_tree";

query_tree_unchecked :: (
    c : *Connection,
    window : Window
) -> QueryTreeCookie #foreign libxcb "xcb_query_tree_unchecked";

query_tree_children :: (r : *QueryTreeReply) -> *Window #foreign libxcb "xcb_query_tree_children";

query_tree_children_length :: (r : *QueryTreeReply) -> s32 #foreign libxcb "xcb_query_tree_children_length";

query_tree_children_end :: (r : *QueryTreeReply) -> GenericIterator #foreign libxcb "xcb_query_tree_children_end";

query_tree_reply :: (
    c : *Connection,
    cookie : QueryTreeCookie,
    e : **GenericError
) -> *QueryTreeReply #foreign libxcb "xcb_query_tree_reply";

intern_atom_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_intern_atom_sizeof";

intern_atom :: (
    c : *Connection,
    onlyIfExists : u8,
    nameLen : u16,
    name : *u8
) -> InternAtomCookie #foreign libxcb "xcb_intern_atom";

intern_atom_unchecked :: (
    c : *Connection,
    onlyIfExists : u8,
    nameLen : u16,
    name : *u8
) -> InternAtomCookie #foreign libxcb "xcb_intern_atom_unchecked";

intern_atom_reply :: (
    c : *Connection,
    cookie : InternAtomCookie,
    e : **GenericError
) -> *InternAtomReply #foreign libxcb "xcb_intern_atom_reply";

get_atom_name_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_atom_name_sizeof";

get_atom_name :: (
    c : *Connection,
    atom : Atom
) -> GetAtomNameCookie #foreign libxcb "xcb_get_atom_name";

get_atom_name_unchecked :: (
    c : *Connection,
    atom : Atom
) -> GetAtomNameCookie #foreign libxcb "xcb_get_atom_name_unchecked";

get_atom_name_name :: (r : *GetAtomNameReply) -> *u8 #foreign libxcb "xcb_get_atom_name_name";

get_atom_name_name_length :: (r : *GetAtomNameReply) -> s32 #foreign libxcb "xcb_get_atom_name_name_length";

get_atom_name_name_end :: (r : *GetAtomNameReply) -> GenericIterator #foreign libxcb "xcb_get_atom_name_name_end";

get_atom_name_reply :: (
    c : *Connection,
    cookie : GetAtomNameCookie,
    e : **GenericError
) -> *GetAtomNameReply #foreign libxcb "xcb_get_atom_name_reply";

change_property_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_property_sizeof";

change_property_checked :: (
    c : *Connection,
    mode : u8,
    window : Window,
    property : Atom,
    type : Atom,
    format : u8,
    dataLen : u32,
    data : *void
) -> VoidCookie #foreign libxcb "xcb_change_property_checked";

change_property :: (
    c : *Connection,
    mode : u8,
    window : Window,
    property : Atom,
    type : Atom,
    format : u8,
    dataLen : u32,
    data : *void
) -> VoidCookie #foreign libxcb "xcb_change_property";

change_property_data :: (r : *ChangePropertyRequest) -> *void #foreign libxcb "xcb_change_property_data";

change_property_data_length :: (r : *ChangePropertyRequest) -> s32 #foreign libxcb "xcb_change_property_data_length";

change_property_data_end :: (r : *ChangePropertyRequest) -> GenericIterator #foreign libxcb "xcb_change_property_data_end";

delete_property_checked :: (
    c : *Connection,
    window : Window,
    property : Atom
) -> VoidCookie #foreign libxcb "xcb_delete_property_checked";

delete_property :: (
    c : *Connection,
    window : Window,
    property : Atom
) -> VoidCookie #foreign libxcb "xcb_delete_property";

get_property_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_property_sizeof";

get_property :: (
    c : *Connection,
    delete : u8,
    window : Window,
    property : Atom,
    type : Atom,
    longOffset : u32,
    longLength : u32
) -> GetPropertyCookie #foreign libxcb "xcb_get_property";

get_property_unchecked :: (
    c : *Connection,
    delete : u8,
    window : Window,
    property : Atom,
    type : Atom,
    longOffset : u32,
    longLength : u32
) -> GetPropertyCookie #foreign libxcb "xcb_get_property_unchecked";

get_property_value :: (r : *GetPropertyReply) -> *void #foreign libxcb "xcb_get_property_value";

get_property_value_length :: (r : *GetPropertyReply) -> s32 #foreign libxcb "xcb_get_property_value_length";

get_property_value_end :: (r : *GetPropertyReply) -> GenericIterator #foreign libxcb "xcb_get_property_value_end";

get_property_reply :: (
    c : *Connection,
    cookie : GetPropertyCookie,
    e : **GenericError
) -> *GetPropertyReply #foreign libxcb "xcb_get_property_reply";

list_properties_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_properties_sizeof";

list_properties :: (
    c : *Connection,
    window : Window
) -> ListPropertiesCookie #foreign libxcb "xcb_list_properties";

list_properties_unchecked :: (
    c : *Connection,
    window : Window
) -> ListPropertiesCookie #foreign libxcb "xcb_list_properties_unchecked";

list_properties_atoms :: (r : *ListPropertiesReply) -> *Atom #foreign libxcb "xcb_list_properties_atoms";

list_properties_atoms_length :: (r : *ListPropertiesReply) -> s32 #foreign libxcb "xcb_list_properties_atoms_length";

list_properties_atoms_end :: (r : *ListPropertiesReply) -> GenericIterator #foreign libxcb "xcb_list_properties_atoms_end";

list_properties_reply :: (
    c : *Connection,
    cookie : ListPropertiesCookie,
    e : **GenericError
) -> *ListPropertiesReply #foreign libxcb "xcb_list_properties_reply";

set_selection_owner_checked :: (
    c : *Connection,
    owner : Window,
    selection : Atom,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_set_selection_owner_checked";

set_selection_owner :: (
    c : *Connection,
    owner : Window,
    selection : Atom,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_set_selection_owner";

get_selection_owner :: (
    c : *Connection,
    selection : Atom
) -> GetSelectionOwnerCookie #foreign libxcb "xcb_get_selection_owner";

get_selection_owner_unchecked :: (
    c : *Connection,
    selection : Atom
) -> GetSelectionOwnerCookie #foreign libxcb "xcb_get_selection_owner_unchecked";

get_selection_owner_reply :: (
    c : *Connection,
    cookie : GetSelectionOwnerCookie,
    e : **GenericError
) -> *GetSelectionOwnerReply #foreign libxcb "xcb_get_selection_owner_reply";

convert_selection_checked :: (
    c : *Connection,
    requestor : Window,
    selection : Atom,
    target : Atom,
    property : Atom,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_convert_selection_checked";

convert_selection :: (
    c : *Connection,
    requestor : Window,
    selection : Atom,
    target : Atom,
    property : Atom,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_convert_selection";

send_event_checked :: (
    c : *Connection,
    propagate : u8,
    destination : Window,
    eventMask : u32,
    event : *u8
) -> VoidCookie #foreign libxcb "xcb_send_event_checked";

send_event :: (
    c : *Connection,
    propagate : u8,
    destination : Window,
    eventMask : u32,
    event : *u8
) -> VoidCookie #foreign libxcb "xcb_send_event";

grab_pointer :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    eventMask : u16,
    pointerMode : u8,
    keyboardMode : u8,
    confineTo : Window,
    cursor : Cursor,
    time : Timestamp
) -> GrabPointerCookie #foreign libxcb "xcb_grab_pointer";

grab_pointer_unchecked :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    eventMask : u16,
    pointerMode : u8,
    keyboardMode : u8,
    confineTo : Window,
    cursor : Cursor,
    time : Timestamp
) -> GrabPointerCookie #foreign libxcb "xcb_grab_pointer_unchecked";

grab_pointer_reply :: (
    c : *Connection,
    cookie : GrabPointerCookie,
    e : **GenericError
) -> *GrabPointerReply #foreign libxcb "xcb_grab_pointer_reply";

ungrab_pointer_checked :: (
    c : *Connection,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_ungrab_pointer_checked";

ungrab_pointer :: (
    c : *Connection,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_ungrab_pointer";

grab_button_checked :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    eventMask : u16,
    pointerMode : u8,
    keyboardMode : u8,
    confineTo : Window,
    cursor : Cursor,
    button : u8,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_grab_button_checked";

grab_button :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    eventMask : u16,
    pointerMode : u8,
    keyboardMode : u8,
    confineTo : Window,
    cursor : Cursor,
    button : u8,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_grab_button";

ungrab_button_checked :: (
    c : *Connection,
    button : u8,
    grabWindow : Window,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_ungrab_button_checked";

ungrab_button :: (
    c : *Connection,
    button : u8,
    grabWindow : Window,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_ungrab_button";

change_active_pointer_grab_checked :: (
    c : *Connection,
    cursor : Cursor,
    time : Timestamp,
    eventMask : u16
) -> VoidCookie #foreign libxcb "xcb_change_active_pointer_grab_checked";

change_active_pointer_grab :: (
    c : *Connection,
    cursor : Cursor,
    time : Timestamp,
    eventMask : u16
) -> VoidCookie #foreign libxcb "xcb_change_active_pointer_grab";

grab_keyboard :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    time : Timestamp,
    pointerMode : u8,
    keyboardMode : u8
) -> GrabKeyboardCookie #foreign libxcb "xcb_grab_keyboard";

grab_keyboard_unchecked :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    time : Timestamp,
    pointerMode : u8,
    keyboardMode : u8
) -> GrabKeyboardCookie #foreign libxcb "xcb_grab_keyboard_unchecked";

grab_keyboard_reply :: (
    c : *Connection,
    cookie : GrabKeyboardCookie,
    e : **GenericError
) -> *GrabKeyboardReply #foreign libxcb "xcb_grab_keyboard_reply";

ungrab_keyboard_checked :: (
    c : *Connection,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_ungrab_keyboard_checked";

ungrab_keyboard :: (
    c : *Connection,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_ungrab_keyboard";

grab_key_checked :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    modifiers : u16,
    key : Keycode,
    pointerMode : u8,
    keyboardMode : u8
) -> VoidCookie #foreign libxcb "xcb_grab_key_checked";

grab_key :: (
    c : *Connection,
    ownerEvents : u8,
    grabWindow : Window,
    modifiers : u16,
    key : Keycode,
    pointerMode : u8,
    keyboardMode : u8
) -> VoidCookie #foreign libxcb "xcb_grab_key";

ungrab_key_checked :: (
    c : *Connection,
    key : Keycode,
    grabWindow : Window,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_ungrab_key_checked";

ungrab_key :: (
    c : *Connection,
    key : Keycode,
    grabWindow : Window,
    modifiers : u16
) -> VoidCookie #foreign libxcb "xcb_ungrab_key";

allow_events_checked :: (
    c : *Connection,
    mode : u8,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_allow_events_checked";

allow_events :: (
    c : *Connection,
    mode : u8,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_allow_events";

grab_server_checked :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_grab_server_checked";

grab_server :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_grab_server";

ungrab_server_checked :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_ungrab_server_checked";

ungrab_server :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_ungrab_server";

query_pointer :: (
    c : *Connection,
    window : Window
) -> QueryPointerCookie #foreign libxcb "xcb_query_pointer";

query_pointer_unchecked :: (
    c : *Connection,
    window : Window
) -> QueryPointerCookie #foreign libxcb "xcb_query_pointer_unchecked";

query_pointer_reply :: (
    c : *Connection,
    cookie : QueryPointerCookie,
    e : **GenericError
) -> *QueryPointerReply #foreign libxcb "xcb_query_pointer_reply";

timecoord_next :: (i : *TimecoordIterator) -> void #foreign libxcb "xcb_timecoord_next";

timecoord_end :: (i : TimecoordIterator) -> GenericIterator #foreign libxcb "xcb_timecoord_end";

get_motion_events_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_motion_events_sizeof";

get_motion_events :: (
    c : *Connection,
    window : Window,
    start : Timestamp,
    stop : Timestamp
) -> GetMotionEventsCookie #foreign libxcb "xcb_get_motion_events";

get_motion_events_unchecked :: (
    c : *Connection,
    window : Window,
    start : Timestamp,
    stop : Timestamp
) -> GetMotionEventsCookie #foreign libxcb "xcb_get_motion_events_unchecked";

get_motion_events_events :: (r : *GetMotionEventsReply) -> *Timecoord #foreign libxcb "xcb_get_motion_events_events";

get_motion_events_events_length :: (r : *GetMotionEventsReply) -> s32 #foreign libxcb "xcb_get_motion_events_events_length";

get_motion_events_events_iterator :: (r : *GetMotionEventsReply) -> TimecoordIterator #foreign libxcb "xcb_get_motion_events_events_iterator";

get_motion_events_reply :: (
    c : *Connection,
    cookie : GetMotionEventsCookie,
    e : **GenericError
) -> *GetMotionEventsReply #foreign libxcb "xcb_get_motion_events_reply";

translate_coordinates :: (
    c : *Connection,
    srcWindow : Window,
    dstWindow : Window,
    srcX : s16,
    srcY : s16
) -> TranslateCoordinatesCookie #foreign libxcb "xcb_translate_coordinates";

translate_coordinates_unchecked :: (
    c : *Connection,
    srcWindow : Window,
    dstWindow : Window,
    srcX : s16,
    srcY : s16
) -> TranslateCoordinatesCookie #foreign libxcb "xcb_translate_coordinates_unchecked";

translate_coordinates_reply :: (
    c : *Connection,
    cookie : TranslateCoordinatesCookie,
    e : **GenericError
) -> *TranslateCoordinatesReply #foreign libxcb "xcb_translate_coordinates_reply";

warp_pointer_checked :: (
    c : *Connection,
    srcWindow : Window,
    dstWindow : Window,
    srcX : s16,
    srcY : s16,
    srcWidth : u16,
    srcHeight : u16,
    dstX : s16,
    dstY : s16
) -> VoidCookie #foreign libxcb "xcb_warp_pointer_checked";

warp_pointer :: (
    c : *Connection,
    srcWindow : Window,
    dstWindow : Window,
    srcX : s16,
    srcY : s16,
    srcWidth : u16,
    srcHeight : u16,
    dstX : s16,
    dstY : s16
) -> VoidCookie #foreign libxcb "xcb_warp_pointer";

set_input_focus_checked :: (
    c : *Connection,
    revertTo : u8,
    focus : Window,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_set_input_focus_checked";

set_input_focus :: (
    c : *Connection,
    revertTo : u8,
    focus : Window,
    time : Timestamp
) -> VoidCookie #foreign libxcb "xcb_set_input_focus";

get_input_focus :: (c : *Connection) -> GetInputFocusCookie #foreign libxcb "xcb_get_input_focus";

get_input_focus_unchecked :: (c : *Connection) -> GetInputFocusCookie #foreign libxcb "xcb_get_input_focus_unchecked";

get_input_focus_reply :: (
    c : *Connection,
    cookie : GetInputFocusCookie,
    e : **GenericError
) -> *GetInputFocusReply #foreign libxcb "xcb_get_input_focus_reply";

query_keymap :: (c : *Connection) -> QueryKeymapCookie #foreign libxcb "xcb_query_keymap";

query_keymap_unchecked :: (c : *Connection) -> QueryKeymapCookie #foreign libxcb "xcb_query_keymap_unchecked";

query_keymap_reply :: (
    c : *Connection,
    cookie : QueryKeymapCookie,
    e : **GenericError
) -> *QueryKeymapReply #foreign libxcb "xcb_query_keymap_reply";

open_font_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_open_font_sizeof";

open_font_checked :: (
    c : *Connection,
    fid : Font,
    nameLen : u16,
    name : *u8
) -> VoidCookie #foreign libxcb "xcb_open_font_checked";

open_font :: (
    c : *Connection,
    fid : Font,
    nameLen : u16,
    name : *u8
) -> VoidCookie #foreign libxcb "xcb_open_font";

open_font_name :: (r : *OpenFontRequest) -> *u8 #foreign libxcb "xcb_open_font_name";

open_font_name_length :: (r : *OpenFontRequest) -> s32 #foreign libxcb "xcb_open_font_name_length";

open_font_name_end :: (r : *OpenFontRequest) -> GenericIterator #foreign libxcb "xcb_open_font_name_end";

close_font_checked :: (
    c : *Connection,
    font : Font
) -> VoidCookie #foreign libxcb "xcb_close_font_checked";

close_font :: (
    c : *Connection,
    font : Font
) -> VoidCookie #foreign libxcb "xcb_close_font";

fontprop_next :: (i : *FontpropIterator) -> void #foreign libxcb "xcb_fontprop_next";

fontprop_end :: (i : FontpropIterator) -> GenericIterator #foreign libxcb "xcb_fontprop_end";

charinfo_next :: (i : *CharinfoIterator) -> void #foreign libxcb "xcb_charinfo_next";

charinfo_end :: (i : CharinfoIterator) -> GenericIterator #foreign libxcb "xcb_charinfo_end";

query_font_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_query_font_sizeof";

query_font :: (
    c : *Connection,
    font : Fontable
) -> QueryFontCookie #foreign libxcb "xcb_query_font";

query_font_unchecked :: (
    c : *Connection,
    font : Fontable
) -> QueryFontCookie #foreign libxcb "xcb_query_font_unchecked";

query_font_properties :: (r : *QueryFontReply) -> *Fontprop #foreign libxcb "xcb_query_font_properties";

query_font_properties_length :: (r : *QueryFontReply) -> s32 #foreign libxcb "xcb_query_font_properties_length";

query_font_properties_iterator :: (r : *QueryFontReply) -> FontpropIterator #foreign libxcb "xcb_query_font_properties_iterator";

query_font_char_infos :: (r : *QueryFontReply) -> *Charinfo #foreign libxcb "xcb_query_font_char_infos";

query_font_char_infos_length :: (r : *QueryFontReply) -> s32 #foreign libxcb "xcb_query_font_char_infos_length";

query_font_char_infos_iterator :: (r : *QueryFontReply) -> CharinfoIterator #foreign libxcb "xcb_query_font_char_infos_iterator";

query_font_reply :: (
    c : *Connection,
    cookie : QueryFontCookie,
    e : **GenericError
) -> *QueryFontReply #foreign libxcb "xcb_query_font_reply";

query_text_extents_sizeof :: (
    buffer : *void,
    stringLen : u32
) -> s32 #foreign libxcb "xcb_query_text_extents_sizeof";

query_text_extents :: (
    c : *Connection,
    font : Fontable,
    stringLen : u32,
    string : *Char2B
) -> QueryTextExtentsCookie #foreign libxcb "xcb_query_text_extents";

query_text_extents_unchecked :: (
    c : *Connection,
    font : Fontable,
    stringLen : u32,
    string : *Char2B
) -> QueryTextExtentsCookie #foreign libxcb "xcb_query_text_extents_unchecked";

query_text_extents_reply :: (
    c : *Connection,
    cookie : QueryTextExtentsCookie,
    e : **GenericError
) -> *QueryTextExtentsReply #foreign libxcb "xcb_query_text_extents_reply";

str_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_str_sizeof";

str_name :: (r : *Str) -> *u8 #foreign libxcb "xcb_str_name";

str_name_length :: (r : *Str) -> s32 #foreign libxcb "xcb_str_name_length";

str_name_end :: (r : *Str) -> GenericIterator #foreign libxcb "xcb_str_name_end";

str_next :: (i : *StrIterator) -> void #foreign libxcb "xcb_str_next";

str_end :: (i : StrIterator) -> GenericIterator #foreign libxcb "xcb_str_end";

list_fonts_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_fonts_sizeof";

list_fonts :: (
    c : *Connection,
    maxNames : u16,
    patternLen : u16,
    pattern : *u8
) -> ListFontsCookie #foreign libxcb "xcb_list_fonts";

list_fonts_unchecked :: (
    c : *Connection,
    maxNames : u16,
    patternLen : u16,
    pattern : *u8
) -> ListFontsCookie #foreign libxcb "xcb_list_fonts_unchecked";

list_fonts_names_length :: (r : *ListFontsReply) -> s32 #foreign libxcb "xcb_list_fonts_names_length";

list_fonts_names_iterator :: (r : *ListFontsReply) -> StrIterator #foreign libxcb "xcb_list_fonts_names_iterator";

list_fonts_reply :: (
    c : *Connection,
    cookie : ListFontsCookie,
    e : **GenericError
) -> *ListFontsReply #foreign libxcb "xcb_list_fonts_reply";

list_fonts_with_info_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_fonts_with_info_sizeof";

list_fonts_with_info :: (
    c : *Connection,
    maxNames : u16,
    patternLen : u16,
    pattern : *u8
) -> ListFontsWithInfoCookie #foreign libxcb "xcb_list_fonts_with_info";

list_fonts_with_info_unchecked :: (
    c : *Connection,
    maxNames : u16,
    patternLen : u16,
    pattern : *u8
) -> ListFontsWithInfoCookie #foreign libxcb "xcb_list_fonts_with_info_unchecked";

list_fonts_with_info_properties :: (r : *ListFontsWithInfoReply) -> *Fontprop #foreign libxcb "xcb_list_fonts_with_info_properties";

list_fonts_with_info_properties_length :: (r : *ListFontsWithInfoReply) -> s32 #foreign libxcb "xcb_list_fonts_with_info_properties_length";

list_fonts_with_info_properties_iterator :: (r : *ListFontsWithInfoReply) -> FontpropIterator #foreign libxcb "xcb_list_fonts_with_info_properties_iterator";

list_fonts_with_info_name :: (r : *ListFontsWithInfoReply) -> *u8 #foreign libxcb "xcb_list_fonts_with_info_name";

list_fonts_with_info_name_length :: (r : *ListFontsWithInfoReply) -> s32 #foreign libxcb "xcb_list_fonts_with_info_name_length";

list_fonts_with_info_name_end :: (r : *ListFontsWithInfoReply) -> GenericIterator #foreign libxcb "xcb_list_fonts_with_info_name_end";

list_fonts_with_info_reply :: (
    c : *Connection,
    cookie : ListFontsWithInfoCookie,
    e : **GenericError
) -> *ListFontsWithInfoReply #foreign libxcb "xcb_list_fonts_with_info_reply";

set_font_path_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_set_font_path_sizeof";

set_font_path_checked :: (
    c : *Connection,
    fontQty : u16,
    font : *Str
) -> VoidCookie #foreign libxcb "xcb_set_font_path_checked";

set_font_path :: (
    c : *Connection,
    fontQty : u16,
    font : *Str
) -> VoidCookie #foreign libxcb "xcb_set_font_path";

set_font_path_font_length :: (r : *SetFontPathRequest) -> s32 #foreign libxcb "xcb_set_font_path_font_length";

set_font_path_font_iterator :: (r : *SetFontPathRequest) -> StrIterator #foreign libxcb "xcb_set_font_path_font_iterator";

get_font_path_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_font_path_sizeof";

get_font_path :: (c : *Connection) -> GetFontPathCookie #foreign libxcb "xcb_get_font_path";

get_font_path_unchecked :: (c : *Connection) -> GetFontPathCookie #foreign libxcb "xcb_get_font_path_unchecked";

get_font_path_path_length :: (r : *GetFontPathReply) -> s32 #foreign libxcb "xcb_get_font_path_path_length";

get_font_path_path_iterator :: (r : *GetFontPathReply) -> StrIterator #foreign libxcb "xcb_get_font_path_path_iterator";

get_font_path_reply :: (
    c : *Connection,
    cookie : GetFontPathCookie,
    e : **GenericError
) -> *GetFontPathReply #foreign libxcb "xcb_get_font_path_reply";

create_pixmap_checked :: (
    c : *Connection,
    depth : u8,
    pid : Pixmap,
    drawable : Drawable,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_create_pixmap_checked";

create_pixmap :: (
    c : *Connection,
    depth : u8,
    pid : Pixmap,
    drawable : Drawable,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_create_pixmap";

free_pixmap_checked :: (
    c : *Connection,
    pixmap : Pixmap
) -> VoidCookie #foreign libxcb "xcb_free_pixmap_checked";

free_pixmap :: (
    c : *Connection,
    pixmap : Pixmap
) -> VoidCookie #foreign libxcb "xcb_free_pixmap";

create_gc_value_list_serialize :: (
    buffer : **void,
    valueMask : u32,
    aux : *CreateGcValueList
) -> s32 #foreign libxcb "xcb_create_gc_value_list_serialize";

create_gc_value_list_unpack :: (
    buffer : *void,
    valueMask : u32,
    aux : *CreateGcValueList
) -> s32 #foreign libxcb "xcb_create_gc_value_list_unpack";

create_gc_value_list_sizeof :: (
    buffer : *void,
    valueMask : u32
) -> s32 #foreign libxcb "xcb_create_gc_value_list_sizeof";

create_gc_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_create_gc_sizeof";

create_gc_checked :: (
    c : *Connection,
    cid : Gcontext,
    drawable : Drawable,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_create_gc_checked";

create_gc :: (
    c : *Connection,
    cid : Gcontext,
    drawable : Drawable,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_create_gc";

create_gc_aux_checked :: (
    c : *Connection,
    cid : Gcontext,
    drawable : Drawable,
    valueMask : u32,
    valueList : *CreateGcValueList
) -> VoidCookie #foreign libxcb "xcb_create_gc_aux_checked";

create_gc_aux :: (
    c : *Connection,
    cid : Gcontext,
    drawable : Drawable,
    valueMask : u32,
    valueList : *CreateGcValueList
) -> VoidCookie #foreign libxcb "xcb_create_gc_aux";

create_gc_value_list :: (r : *CreateGcRequest) -> *void #foreign libxcb "xcb_create_gc_value_list";

change_gc_value_list_serialize :: (
    buffer : **void,
    valueMask : u32,
    aux : *ChangeGcValueList
) -> s32 #foreign libxcb "xcb_change_gc_value_list_serialize";

change_gc_value_list_unpack :: (
    buffer : *void,
    valueMask : u32,
    aux : *ChangeGcValueList
) -> s32 #foreign libxcb "xcb_change_gc_value_list_unpack";

change_gc_value_list_sizeof :: (
    buffer : *void,
    valueMask : u32
) -> s32 #foreign libxcb "xcb_change_gc_value_list_sizeof";

change_gc_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_gc_sizeof";

change_gc_checked :: (
    c : *Connection,
    gc : Gcontext,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_gc_checked";

change_gc :: (
    c : *Connection,
    gc : Gcontext,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_gc";

change_gc_aux_checked :: (
    c : *Connection,
    gc : Gcontext,
    valueMask : u32,
    valueList : *ChangeGcValueList
) -> VoidCookie #foreign libxcb "xcb_change_gc_aux_checked";

change_gc_aux :: (
    c : *Connection,
    gc : Gcontext,
    valueMask : u32,
    valueList : *ChangeGcValueList
) -> VoidCookie #foreign libxcb "xcb_change_gc_aux";

change_gc_value_list :: (r : *ChangeGcRequest) -> *void #foreign libxcb "xcb_change_gc_value_list";

copy_gc_checked :: (
    c : *Connection,
    srcGc : Gcontext,
    dstGc : Gcontext,
    valueMask : u32
) -> VoidCookie #foreign libxcb "xcb_copy_gc_checked";

copy_gc :: (
    c : *Connection,
    srcGc : Gcontext,
    dstGc : Gcontext,
    valueMask : u32
) -> VoidCookie #foreign libxcb "xcb_copy_gc";

set_dashes_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_set_dashes_sizeof";

set_dashes_checked :: (
    c : *Connection,
    gc : Gcontext,
    dashOffset : u16,
    dashesLen : u16,
    dashes : *u8
) -> VoidCookie #foreign libxcb "xcb_set_dashes_checked";

set_dashes :: (
    c : *Connection,
    gc : Gcontext,
    dashOffset : u16,
    dashesLen : u16,
    dashes : *u8
) -> VoidCookie #foreign libxcb "xcb_set_dashes";

set_dashes_dashes :: (r : *SetDashesRequest) -> *u8 #foreign libxcb "xcb_set_dashes_dashes";

set_dashes_dashes_length :: (r : *SetDashesRequest) -> s32 #foreign libxcb "xcb_set_dashes_dashes_length";

set_dashes_dashes_end :: (r : *SetDashesRequest) -> GenericIterator #foreign libxcb "xcb_set_dashes_dashes_end";

set_clip_rectangles_sizeof :: (
    buffer : *void,
    rectanglesLen : u32
) -> s32 #foreign libxcb "xcb_set_clip_rectangles_sizeof";

set_clip_rectangles_checked :: (
    c : *Connection,
    ordering : u8,
    gc : Gcontext,
    clipX_origin : s16,
    clipY_origin : s16,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_set_clip_rectangles_checked";

set_clip_rectangles :: (
    c : *Connection,
    ordering : u8,
    gc : Gcontext,
    clipX_origin : s16,
    clipY_origin : s16,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_set_clip_rectangles";

set_clip_rectangles_rectangles :: (r : *SetClipRectanglesRequest) -> *Rectangle #foreign libxcb "xcb_set_clip_rectangles_rectangles";

set_clip_rectangles_rectangles_length :: (r : *SetClipRectanglesRequest) -> s32 #foreign libxcb "xcb_set_clip_rectangles_rectangles_length";

set_clip_rectangles_rectangles_iterator :: (r : *SetClipRectanglesRequest) -> RectangleIterator #foreign libxcb "xcb_set_clip_rectangles_rectangles_iterator";

free_gc_checked :: (
    c : *Connection,
    gc : Gcontext
) -> VoidCookie #foreign libxcb "xcb_free_gc_checked";

free_gc :: (
    c : *Connection,
    gc : Gcontext
) -> VoidCookie #foreign libxcb "xcb_free_gc";

clear_area_checked :: (
    c : *Connection,
    exposures : u8,
    window : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_clear_area_checked";

clear_area :: (
    c : *Connection,
    exposures : u8,
    window : Window,
    x : s16,
    y : s16,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_clear_area";

copy_area_checked :: (
    c : *Connection,
    srcDrawable : Drawable,
    dstDrawable : Drawable,
    gc : Gcontext,
    srcX : s16,
    srcY : s16,
    dstX : s16,
    dstY : s16,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_copy_area_checked";

copy_area :: (
    c : *Connection,
    srcDrawable : Drawable,
    dstDrawable : Drawable,
    gc : Gcontext,
    srcX : s16,
    srcY : s16,
    dstX : s16,
    dstY : s16,
    width : u16,
    height : u16
) -> VoidCookie #foreign libxcb "xcb_copy_area";

copy_plane_checked :: (
    c : *Connection,
    srcDrawable : Drawable,
    dstDrawable : Drawable,
    gc : Gcontext,
    srcX : s16,
    srcY : s16,
    dstX : s16,
    dstY : s16,
    width : u16,
    height : u16,
    bitPlane : u32
) -> VoidCookie #foreign libxcb "xcb_copy_plane_checked";

copy_plane :: (
    c : *Connection,
    srcDrawable : Drawable,
    dstDrawable : Drawable,
    gc : Gcontext,
    srcX : s16,
    srcY : s16,
    dstX : s16,
    dstY : s16,
    width : u16,
    height : u16,
    bitPlane : u32
) -> VoidCookie #foreign libxcb "xcb_copy_plane";

poly_point_sizeof :: (
    buffer : *void,
    pointsLen : u32
) -> s32 #foreign libxcb "xcb_poly_point_sizeof";

poly_point_checked :: (
    c : *Connection,
    coordinateMode : u8,
    drawable : Drawable,
    gc : Gcontext,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_poly_point_checked";

poly_point :: (
    c : *Connection,
    coordinateMode : u8,
    drawable : Drawable,
    gc : Gcontext,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_poly_point";

poly_point_points :: (r : *PolyPointRequest) -> *Point #foreign libxcb "xcb_poly_point_points";

poly_point_points_length :: (r : *PolyPointRequest) -> s32 #foreign libxcb "xcb_poly_point_points_length";

poly_point_points_iterator :: (r : *PolyPointRequest) -> PointIterator #foreign libxcb "xcb_poly_point_points_iterator";

poly_line_sizeof :: (
    buffer : *void,
    pointsLen : u32
) -> s32 #foreign libxcb "xcb_poly_line_sizeof";

poly_line_checked :: (
    c : *Connection,
    coordinateMode : u8,
    drawable : Drawable,
    gc : Gcontext,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_poly_line_checked";

poly_line :: (
    c : *Connection,
    coordinateMode : u8,
    drawable : Drawable,
    gc : Gcontext,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_poly_line";

poly_line_points :: (r : *PolyLineRequest) -> *Point #foreign libxcb "xcb_poly_line_points";

poly_line_points_length :: (r : *PolyLineRequest) -> s32 #foreign libxcb "xcb_poly_line_points_length";

poly_line_points_iterator :: (r : *PolyLineRequest) -> PointIterator #foreign libxcb "xcb_poly_line_points_iterator";

segment_next :: (i : *SegmentIterator) -> void #foreign libxcb "xcb_segment_next";

segment_end :: (i : SegmentIterator) -> GenericIterator #foreign libxcb "xcb_segment_end";

poly_segment_sizeof :: (
    buffer : *void,
    segmentsLen : u32
) -> s32 #foreign libxcb "xcb_poly_segment_sizeof";

poly_segment_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    segmentsLen : u32,
    segments : *Segment
) -> VoidCookie #foreign libxcb "xcb_poly_segment_checked";

poly_segment :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    segmentsLen : u32,
    segments : *Segment
) -> VoidCookie #foreign libxcb "xcb_poly_segment";

poly_segment_segments :: (r : *PolySegmentRequest) -> *Segment #foreign libxcb "xcb_poly_segment_segments";

poly_segment_segments_length :: (r : *PolySegmentRequest) -> s32 #foreign libxcb "xcb_poly_segment_segments_length";

poly_segment_segments_iterator :: (r : *PolySegmentRequest) -> SegmentIterator #foreign libxcb "xcb_poly_segment_segments_iterator";

poly_rectangle_sizeof :: (
    buffer : *void,
    rectanglesLen : u32
) -> s32 #foreign libxcb "xcb_poly_rectangle_sizeof";

poly_rectangle_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_poly_rectangle_checked";

poly_rectangle :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_poly_rectangle";

poly_rectangle_rectangles :: (r : *PolyRectangleRequest) -> *Rectangle #foreign libxcb "xcb_poly_rectangle_rectangles";

poly_rectangle_rectangles_length :: (r : *PolyRectangleRequest) -> s32 #foreign libxcb "xcb_poly_rectangle_rectangles_length";

poly_rectangle_rectangles_iterator :: (r : *PolyRectangleRequest) -> RectangleIterator #foreign libxcb "xcb_poly_rectangle_rectangles_iterator";

poly_arc_sizeof :: (
    buffer : *void,
    arcsLen : u32
) -> s32 #foreign libxcb "xcb_poly_arc_sizeof";

poly_arc_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    arcsLen : u32,
    arcs : *Arc
) -> VoidCookie #foreign libxcb "xcb_poly_arc_checked";

poly_arc :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    arcsLen : u32,
    arcs : *Arc
) -> VoidCookie #foreign libxcb "xcb_poly_arc";

poly_arc_arcs :: (r : *PolyArcRequest) -> *Arc #foreign libxcb "xcb_poly_arc_arcs";

poly_arc_arcs_length :: (r : *PolyArcRequest) -> s32 #foreign libxcb "xcb_poly_arc_arcs_length";

poly_arc_arcs_iterator :: (r : *PolyArcRequest) -> ArcIterator #foreign libxcb "xcb_poly_arc_arcs_iterator";

fill_poly_sizeof :: (
    buffer : *void,
    pointsLen : u32
) -> s32 #foreign libxcb "xcb_fill_poly_sizeof";

fill_poly_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    shape : u8,
    coordinateMode : u8,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_fill_poly_checked";

fill_poly :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    shape : u8,
    coordinateMode : u8,
    pointsLen : u32,
    points : *Point
) -> VoidCookie #foreign libxcb "xcb_fill_poly";

fill_poly_points :: (r : *FillPolyRequest) -> *Point #foreign libxcb "xcb_fill_poly_points";

fill_poly_points_length :: (r : *FillPolyRequest) -> s32 #foreign libxcb "xcb_fill_poly_points_length";

fill_poly_points_iterator :: (r : *FillPolyRequest) -> PointIterator #foreign libxcb "xcb_fill_poly_points_iterator";

poly_fill_rectangle_sizeof :: (
    buffer : *void,
    rectanglesLen : u32
) -> s32 #foreign libxcb "xcb_poly_fill_rectangle_sizeof";

poly_fill_rectangle_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_poly_fill_rectangle_checked";

poly_fill_rectangle :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    rectanglesLen : u32,
    rectangles : *Rectangle
) -> VoidCookie #foreign libxcb "xcb_poly_fill_rectangle";

poly_fill_rectangle_rectangles :: (r : *PolyFillRectangleRequest) -> *Rectangle #foreign libxcb "xcb_poly_fill_rectangle_rectangles";

poly_fill_rectangle_rectangles_length :: (r : *PolyFillRectangleRequest) -> s32 #foreign libxcb "xcb_poly_fill_rectangle_rectangles_length";

poly_fill_rectangle_rectangles_iterator :: (r : *PolyFillRectangleRequest) -> RectangleIterator #foreign libxcb "xcb_poly_fill_rectangle_rectangles_iterator";

poly_fill_arc_sizeof :: (
    buffer : *void,
    arcsLen : u32
) -> s32 #foreign libxcb "xcb_poly_fill_arc_sizeof";

poly_fill_arc_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    arcsLen : u32,
    arcs : *Arc
) -> VoidCookie #foreign libxcb "xcb_poly_fill_arc_checked";

poly_fill_arc :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    arcsLen : u32,
    arcs : *Arc
) -> VoidCookie #foreign libxcb "xcb_poly_fill_arc";

poly_fill_arc_arcs :: (r : *PolyFillArcRequest) -> *Arc #foreign libxcb "xcb_poly_fill_arc_arcs";

poly_fill_arc_arcs_length :: (r : *PolyFillArcRequest) -> s32 #foreign libxcb "xcb_poly_fill_arc_arcs_length";

poly_fill_arc_arcs_iterator :: (r : *PolyFillArcRequest) -> ArcIterator #foreign libxcb "xcb_poly_fill_arc_arcs_iterator";

put_image_sizeof :: (
    buffer : *void,
    dataLen : u32
) -> s32 #foreign libxcb "xcb_put_image_sizeof";

put_image_checked :: (
    c : *Connection,
    format : u8,
    drawable : Drawable,
    gc : Gcontext,
    width : u16,
    height : u16,
    dstX : s16,
    dstY : s16,
    leftPad : u8,
    depth : u8,
    dataLen : u32,
    data : *u8
) -> VoidCookie #foreign libxcb "xcb_put_image_checked";

put_image :: (
    c : *Connection,
    format : u8,
    drawable : Drawable,
    gc : Gcontext,
    width : u16,
    height : u16,
    dstX : s16,
    dstY : s16,
    leftPad : u8,
    depth : u8,
    dataLen : u32,
    data : *u8
) -> VoidCookie #foreign libxcb "xcb_put_image";

put_image_data :: (r : *PutImageRequest) -> *u8 #foreign libxcb "xcb_put_image_data";

put_image_data_length :: (r : *PutImageRequest) -> s32 #foreign libxcb "xcb_put_image_data_length";

put_image_data_end :: (r : *PutImageRequest) -> GenericIterator #foreign libxcb "xcb_put_image_data_end";

get_image_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_image_sizeof";

get_image :: (
    c : *Connection,
    format : u8,
    drawable : Drawable,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    planeMask : u32
) -> GetImageCookie #foreign libxcb "xcb_get_image";

get_image_unchecked :: (
    c : *Connection,
    format : u8,
    drawable : Drawable,
    x : s16,
    y : s16,
    width : u16,
    height : u16,
    planeMask : u32
) -> GetImageCookie #foreign libxcb "xcb_get_image_unchecked";

get_image_data :: (r : *GetImageReply) -> *u8 #foreign libxcb "xcb_get_image_data";

get_image_data_length :: (r : *GetImageReply) -> s32 #foreign libxcb "xcb_get_image_data_length";

get_image_data_end :: (r : *GetImageReply) -> GenericIterator #foreign libxcb "xcb_get_image_data_end";

get_image_reply :: (
    c : *Connection,
    cookie : GetImageCookie,
    e : **GenericError
) -> *GetImageReply #foreign libxcb "xcb_get_image_reply";

poly_text_8_sizeof :: (
    buffer : *void,
    itemsLen : u32
) -> s32 #foreign libxcb "xcb_poly_text_8_sizeof";

poly_text_8_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    itemsLen : u32,
    items : *u8
) -> VoidCookie #foreign libxcb "xcb_poly_text_8_checked";

poly_text_8 :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    itemsLen : u32,
    items : *u8
) -> VoidCookie #foreign libxcb "xcb_poly_text_8";

poly_text_8_items :: (r : *PolyText8_request) -> *u8 #foreign libxcb "xcb_poly_text_8_items";

poly_text_8_items_length :: (r : *PolyText8_request) -> s32 #foreign libxcb "xcb_poly_text_8_items_length";

poly_text_8_items_end :: (r : *PolyText8_request) -> GenericIterator #foreign libxcb "xcb_poly_text_8_items_end";

poly_text_16_sizeof :: (
    buffer : *void,
    itemsLen : u32
) -> s32 #foreign libxcb "xcb_poly_text_16_sizeof";

poly_text_16_checked :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    itemsLen : u32,
    items : *u8
) -> VoidCookie #foreign libxcb "xcb_poly_text_16_checked";

poly_text_16 :: (
    c : *Connection,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    itemsLen : u32,
    items : *u8
) -> VoidCookie #foreign libxcb "xcb_poly_text_16";

poly_text_16_items :: (r : *PolyText16Request) -> *u8 #foreign libxcb "xcb_poly_text_16_items";

poly_text_16_items_length :: (r : *PolyText16Request) -> s32 #foreign libxcb "xcb_poly_text_16_items_length";

poly_text_16_items_end :: (r : *PolyText16Request) -> GenericIterator #foreign libxcb "xcb_poly_text_16_items_end";

image_text_8_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_image_text_8_sizeof";

image_text_8_checked :: (
    c : *Connection,
    stringLen : u8,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    string : *u8
) -> VoidCookie #foreign libxcb "xcb_image_text_8_checked";

image_text_8 :: (
    c : *Connection,
    stringLen : u8,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    string : *u8
) -> VoidCookie #foreign libxcb "xcb_image_text_8";

image_text_8_string :: (r : *ImageText8_request) -> *u8 #foreign libxcb "xcb_image_text_8_string";

image_text_8_string_length :: (r : *ImageText8_request) -> s32 #foreign libxcb "xcb_image_text_8_string_length";

image_text_8_string_end :: (r : *ImageText8_request) -> GenericIterator #foreign libxcb "xcb_image_text_8_string_end";

image_text_16_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_image_text_16_sizeof";

image_text_16_checked :: (
    c : *Connection,
    stringLen : u8,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    string : *Char2B
) -> VoidCookie #foreign libxcb "xcb_image_text_16_checked";

image_text_16 :: (
    c : *Connection,
    stringLen : u8,
    drawable : Drawable,
    gc : Gcontext,
    x : s16,
    y : s16,
    string : *Char2B
) -> VoidCookie #foreign libxcb "xcb_image_text_16";

image_text_16_string :: (r : *ImageText16Request) -> *Char2B #foreign libxcb "xcb_image_text_16_string";

image_text_16_string_length :: (r : *ImageText16Request) -> s32 #foreign libxcb "xcb_image_text_16_string_length";

image_text_16_string_iterator :: (r : *ImageText16Request) -> Char2BIterator #foreign libxcb "xcb_image_text_16_string_iterator";

create_colormap_checked :: (
    c : *Connection,
    alloc : u8,
    mid : Colormap,
    window : Window,
    visual : Visualid
) -> VoidCookie #foreign libxcb "xcb_create_colormap_checked";

create_colormap :: (
    c : *Connection,
    alloc : u8,
    mid : Colormap,
    window : Window,
    visual : Visualid
) -> VoidCookie #foreign libxcb "xcb_create_colormap";

free_colormap_checked :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_free_colormap_checked";

free_colormap :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_free_colormap";

copy_colormap_and_free_checked :: (
    c : *Connection,
    mid : Colormap,
    srcCmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_copy_colormap_and_free_checked";

copy_colormap_and_free :: (
    c : *Connection,
    mid : Colormap,
    srcCmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_copy_colormap_and_free";

install_colormap_checked :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_install_colormap_checked";

install_colormap :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_install_colormap";

uninstall_colormap_checked :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_uninstall_colormap_checked";

uninstall_colormap :: (
    c : *Connection,
    cmap : Colormap
) -> VoidCookie #foreign libxcb "xcb_uninstall_colormap";

list_installed_colormaps_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_installed_colormaps_sizeof";

list_installed_colormaps :: (
    c : *Connection,
    window : Window
) -> ListInstalledColormapsCookie #foreign libxcb "xcb_list_installed_colormaps";

list_installed_colormaps_unchecked :: (
    c : *Connection,
    window : Window
) -> ListInstalledColormapsCookie #foreign libxcb "xcb_list_installed_colormaps_unchecked";

list_installed_colormaps_cmaps :: (r : *ListInstalledColormapsReply) -> *Colormap #foreign libxcb "xcb_list_installed_colormaps_cmaps";

list_installed_colormaps_cmaps_length :: (r : *ListInstalledColormapsReply) -> s32 #foreign libxcb "xcb_list_installed_colormaps_cmaps_length";

list_installed_colormaps_cmaps_end :: (r : *ListInstalledColormapsReply) -> GenericIterator #foreign libxcb "xcb_list_installed_colormaps_cmaps_end";

list_installed_colormaps_reply :: (
    c : *Connection,
    cookie : ListInstalledColormapsCookie,
    e : **GenericError
) -> *ListInstalledColormapsReply #foreign libxcb "xcb_list_installed_colormaps_reply";

alloc_color :: (
    c : *Connection,
    cmap : Colormap,
    red : u16,
    green : u16,
    blue : u16
) -> AllocColorCookie #foreign libxcb "xcb_alloc_color";

alloc_color_unchecked :: (
    c : *Connection,
    cmap : Colormap,
    red : u16,
    green : u16,
    blue : u16
) -> AllocColorCookie #foreign libxcb "xcb_alloc_color_unchecked";

alloc_color_reply :: (
    c : *Connection,
    cookie : AllocColorCookie,
    e : **GenericError
) -> *AllocColorReply #foreign libxcb "xcb_alloc_color_reply";

alloc_named_color_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_alloc_named_color_sizeof";

alloc_named_color :: (
    c : *Connection,
    cmap : Colormap,
    nameLen : u16,
    name : *u8
) -> AllocNamedColorCookie #foreign libxcb "xcb_alloc_named_color";

alloc_named_color_unchecked :: (
    c : *Connection,
    cmap : Colormap,
    nameLen : u16,
    name : *u8
) -> AllocNamedColorCookie #foreign libxcb "xcb_alloc_named_color_unchecked";

alloc_named_color_reply :: (
    c : *Connection,
    cookie : AllocNamedColorCookie,
    e : **GenericError
) -> *AllocNamedColorReply #foreign libxcb "xcb_alloc_named_color_reply";

alloc_color_cells_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_alloc_color_cells_sizeof";

alloc_color_cells :: (
    c : *Connection,
    contiguous : u8,
    cmap : Colormap,
    colors : u16,
    planes : u16
) -> AllocColorCellsCookie #foreign libxcb "xcb_alloc_color_cells";

alloc_color_cells_unchecked :: (
    c : *Connection,
    contiguous : u8,
    cmap : Colormap,
    colors : u16,
    planes : u16
) -> AllocColorCellsCookie #foreign libxcb "xcb_alloc_color_cells_unchecked";

alloc_color_cells_pixels :: (r : *AllocColorCellsReply) -> *u32 #foreign libxcb "xcb_alloc_color_cells_pixels";

alloc_color_cells_pixels_length :: (r : *AllocColorCellsReply) -> s32 #foreign libxcb "xcb_alloc_color_cells_pixels_length";

alloc_color_cells_pixels_end :: (r : *AllocColorCellsReply) -> GenericIterator #foreign libxcb "xcb_alloc_color_cells_pixels_end";

alloc_color_cells_masks :: (r : *AllocColorCellsReply) -> *u32 #foreign libxcb "xcb_alloc_color_cells_masks";

alloc_color_cells_masks_length :: (r : *AllocColorCellsReply) -> s32 #foreign libxcb "xcb_alloc_color_cells_masks_length";

alloc_color_cells_masks_end :: (r : *AllocColorCellsReply) -> GenericIterator #foreign libxcb "xcb_alloc_color_cells_masks_end";

alloc_color_cells_reply :: (
    c : *Connection,
    cookie : AllocColorCellsCookie,
    e : **GenericError
) -> *AllocColorCellsReply #foreign libxcb "xcb_alloc_color_cells_reply";

alloc_color_planes_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_alloc_color_planes_sizeof";

alloc_color_planes :: (
    c : *Connection,
    contiguous : u8,
    cmap : Colormap,
    colors : u16,
    reds : u16,
    greens : u16,
    blues : u16
) -> AllocColorPlanesCookie #foreign libxcb "xcb_alloc_color_planes";

alloc_color_planes_unchecked :: (
    c : *Connection,
    contiguous : u8,
    cmap : Colormap,
    colors : u16,
    reds : u16,
    greens : u16,
    blues : u16
) -> AllocColorPlanesCookie #foreign libxcb "xcb_alloc_color_planes_unchecked";

alloc_color_planes_pixels :: (r : *AllocColorPlanesReply) -> *u32 #foreign libxcb "xcb_alloc_color_planes_pixels";

alloc_color_planes_pixels_length :: (r : *AllocColorPlanesReply) -> s32 #foreign libxcb "xcb_alloc_color_planes_pixels_length";

alloc_color_planes_pixels_end :: (r : *AllocColorPlanesReply) -> GenericIterator #foreign libxcb "xcb_alloc_color_planes_pixels_end";

alloc_color_planes_reply :: (
    c : *Connection,
    cookie : AllocColorPlanesCookie,
    e : **GenericError
) -> *AllocColorPlanesReply #foreign libxcb "xcb_alloc_color_planes_reply";

free_colors_sizeof :: (
    buffer : *void,
    pixelsLen : u32
) -> s32 #foreign libxcb "xcb_free_colors_sizeof";

free_colors_checked :: (
    c : *Connection,
    cmap : Colormap,
    planeMask : u32,
    pixelsLen : u32,
    pixels : *u32
) -> VoidCookie #foreign libxcb "xcb_free_colors_checked";

free_colors :: (
    c : *Connection,
    cmap : Colormap,
    planeMask : u32,
    pixelsLen : u32,
    pixels : *u32
) -> VoidCookie #foreign libxcb "xcb_free_colors";

free_colors_pixels :: (r : *FreeColorsRequest) -> *u32 #foreign libxcb "xcb_free_colors_pixels";

free_colors_pixels_length :: (r : *FreeColorsRequest) -> s32 #foreign libxcb "xcb_free_colors_pixels_length";

free_colors_pixels_end :: (r : *FreeColorsRequest) -> GenericIterator #foreign libxcb "xcb_free_colors_pixels_end";

coloritem_next :: (i : *ColoritemIterator) -> void #foreign libxcb "xcb_coloritem_next";

coloritem_end :: (i : ColoritemIterator) -> GenericIterator #foreign libxcb "xcb_coloritem_end";

store_colors_sizeof :: (
    buffer : *void,
    itemsLen : u32
) -> s32 #foreign libxcb "xcb_store_colors_sizeof";

store_colors_checked :: (
    c : *Connection,
    cmap : Colormap,
    itemsLen : u32,
    items : *Coloritem
) -> VoidCookie #foreign libxcb "xcb_store_colors_checked";

store_colors :: (
    c : *Connection,
    cmap : Colormap,
    itemsLen : u32,
    items : *Coloritem
) -> VoidCookie #foreign libxcb "xcb_store_colors";

store_colors_items :: (r : *StoreColorsRequest) -> *Coloritem #foreign libxcb "xcb_store_colors_items";

store_colors_items_length :: (r : *StoreColorsRequest) -> s32 #foreign libxcb "xcb_store_colors_items_length";

store_colors_items_iterator :: (r : *StoreColorsRequest) -> ColoritemIterator #foreign libxcb "xcb_store_colors_items_iterator";

store_named_color_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_store_named_color_sizeof";

store_named_color_checked :: (
    c : *Connection,
    flags : u8,
    cmap : Colormap,
    pixel : u32,
    nameLen : u16,
    name : *u8
) -> VoidCookie #foreign libxcb "xcb_store_named_color_checked";

store_named_color :: (
    c : *Connection,
    flags : u8,
    cmap : Colormap,
    pixel : u32,
    nameLen : u16,
    name : *u8
) -> VoidCookie #foreign libxcb "xcb_store_named_color";

store_named_color_name :: (r : *StoreNamedColorRequest) -> *u8 #foreign libxcb "xcb_store_named_color_name";

store_named_color_name_length :: (r : *StoreNamedColorRequest) -> s32 #foreign libxcb "xcb_store_named_color_name_length";

store_named_color_name_end :: (r : *StoreNamedColorRequest) -> GenericIterator #foreign libxcb "xcb_store_named_color_name_end";

rgb_next :: (i : *RgbIterator) -> void #foreign libxcb "xcb_rgb_next";

rgb_end :: (i : RgbIterator) -> GenericIterator #foreign libxcb "xcb_rgb_end";

query_colors_sizeof :: (
    buffer : *void,
    pixelsLen : u32
) -> s32 #foreign libxcb "xcb_query_colors_sizeof";

query_colors :: (
    c : *Connection,
    cmap : Colormap,
    pixelsLen : u32,
    pixels : *u32
) -> QueryColorsCookie #foreign libxcb "xcb_query_colors";

query_colors_unchecked :: (
    c : *Connection,
    cmap : Colormap,
    pixelsLen : u32,
    pixels : *u32
) -> QueryColorsCookie #foreign libxcb "xcb_query_colors_unchecked";

query_colors_colors :: (r : *QueryColorsReply) -> *Rgb #foreign libxcb "xcb_query_colors_colors";

query_colors_colors_length :: (r : *QueryColorsReply) -> s32 #foreign libxcb "xcb_query_colors_colors_length";

query_colors_colors_iterator :: (r : *QueryColorsReply) -> RgbIterator #foreign libxcb "xcb_query_colors_colors_iterator";

query_colors_reply :: (
    c : *Connection,
    cookie : QueryColorsCookie,
    e : **GenericError
) -> *QueryColorsReply #foreign libxcb "xcb_query_colors_reply";

lookup_color_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_lookup_color_sizeof";

lookup_color :: (
    c : *Connection,
    cmap : Colormap,
    nameLen : u16,
    name : *u8
) -> LookupColorCookie #foreign libxcb "xcb_lookup_color";

lookup_color_unchecked :: (
    c : *Connection,
    cmap : Colormap,
    nameLen : u16,
    name : *u8
) -> LookupColorCookie #foreign libxcb "xcb_lookup_color_unchecked";

lookup_color_reply :: (
    c : *Connection,
    cookie : LookupColorCookie,
    e : **GenericError
) -> *LookupColorReply #foreign libxcb "xcb_lookup_color_reply";

create_cursor_checked :: (
    c : *Connection,
    cid : Cursor,
    source : Pixmap,
    mask : Pixmap,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16,
    x : u16,
    y : u16
) -> VoidCookie #foreign libxcb "xcb_create_cursor_checked";

create_cursor :: (
    c : *Connection,
    cid : Cursor,
    source : Pixmap,
    mask : Pixmap,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16,
    x : u16,
    y : u16
) -> VoidCookie #foreign libxcb "xcb_create_cursor";

create_glyph_cursor_checked :: (
    c : *Connection,
    cid : Cursor,
    sourceFont : Font,
    maskFont : Font,
    sourceChar : u16,
    maskChar : u16,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16
) -> VoidCookie #foreign libxcb "xcb_create_glyph_cursor_checked";

create_glyph_cursor :: (
    c : *Connection,
    cid : Cursor,
    sourceFont : Font,
    maskFont : Font,
    sourceChar : u16,
    maskChar : u16,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16
) -> VoidCookie #foreign libxcb "xcb_create_glyph_cursor";

free_cursor_checked :: (
    c : *Connection,
    cursor : Cursor
) -> VoidCookie #foreign libxcb "xcb_free_cursor_checked";

free_cursor :: (
    c : *Connection,
    cursor : Cursor
) -> VoidCookie #foreign libxcb "xcb_free_cursor";

recolor_cursor_checked :: (
    c : *Connection,
    cursor : Cursor,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16
) -> VoidCookie #foreign libxcb "xcb_recolor_cursor_checked";

recolor_cursor :: (
    c : *Connection,
    cursor : Cursor,
    foreRed : u16,
    foreGreen : u16,
    foreBlue : u16,
    backRed : u16,
    backGreen : u16,
    backBlue : u16
) -> VoidCookie #foreign libxcb "xcb_recolor_cursor";

query_best_size :: (
    c : *Connection,
    class : u8,
    drawable : Drawable,
    width : u16,
    height : u16
) -> QueryBestSizeCookie #foreign libxcb "xcb_query_best_size";

query_best_size_unchecked :: (
    c : *Connection,
    class : u8,
    drawable : Drawable,
    width : u16,
    height : u16
) -> QueryBestSizeCookie #foreign libxcb "xcb_query_best_size_unchecked";

query_best_size_reply :: (
    c : *Connection,
    cookie : QueryBestSizeCookie,
    e : **GenericError
) -> *QueryBestSizeReply #foreign libxcb "xcb_query_best_size_reply";

query_extension_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_query_extension_sizeof";

query_extension :: (
    c : *Connection,
    nameLen : u16,
    name : *u8
) -> QueryExtensionCookie #foreign libxcb "xcb_query_extension";

query_extension_unchecked :: (
    c : *Connection,
    nameLen : u16,
    name : *u8
) -> QueryExtensionCookie #foreign libxcb "xcb_query_extension_unchecked";

query_extension_reply :: (
    c : *Connection,
    cookie : QueryExtensionCookie,
    e : **GenericError
) -> *QueryExtensionReply #foreign libxcb "xcb_query_extension_reply";

list_extensions_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_extensions_sizeof";

list_extensions :: (c : *Connection) -> ListExtensionsCookie #foreign libxcb "xcb_list_extensions";

list_extensions_unchecked :: (c : *Connection) -> ListExtensionsCookie #foreign libxcb "xcb_list_extensions_unchecked";

list_extensions_names_length :: (r : *ListExtensionsReply) -> s32 #foreign libxcb "xcb_list_extensions_names_length";

list_extensions_names_iterator :: (r : *ListExtensionsReply) -> StrIterator #foreign libxcb "xcb_list_extensions_names_iterator";

list_extensions_reply :: (
    c : *Connection,
    cookie : ListExtensionsCookie,
    e : **GenericError
) -> *ListExtensionsReply #foreign libxcb "xcb_list_extensions_reply";

change_keyboard_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_keyboard_mapping_sizeof";

change_keyboard_mapping_checked :: (
    c : *Connection,
    keycodeCount : u8,
    firstKeycode : Keycode,
    keysymsPerKeycode : u8,
    keysyms : *Keysym
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_mapping_checked";

change_keyboard_mapping :: (
    c : *Connection,
    keycodeCount : u8,
    firstKeycode : Keycode,
    keysymsPerKeycode : u8,
    keysyms : *Keysym
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_mapping";

change_keyboard_mapping_keysyms :: (r : *ChangeKeyboardMappingRequest) -> *Keysym #foreign libxcb "xcb_change_keyboard_mapping_keysyms";

change_keyboard_mapping_keysyms_length :: (r : *ChangeKeyboardMappingRequest) -> s32 #foreign libxcb "xcb_change_keyboard_mapping_keysyms_length";

change_keyboard_mapping_keysyms_end :: (r : *ChangeKeyboardMappingRequest) -> GenericIterator #foreign libxcb "xcb_change_keyboard_mapping_keysyms_end";

get_keyboard_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_keyboard_mapping_sizeof";

get_keyboard_mapping :: (
    c : *Connection,
    firstKeycode : Keycode,
    count : u8
) -> GetKeyboardMappingCookie #foreign libxcb "xcb_get_keyboard_mapping";

get_keyboard_mapping_unchecked :: (
    c : *Connection,
    firstKeycode : Keycode,
    count : u8
) -> GetKeyboardMappingCookie #foreign libxcb "xcb_get_keyboard_mapping_unchecked";

get_keyboard_mapping_keysyms :: (r : *GetKeyboardMappingReply) -> *Keysym #foreign libxcb "xcb_get_keyboard_mapping_keysyms";

get_keyboard_mapping_keysyms_length :: (r : *GetKeyboardMappingReply) -> s32 #foreign libxcb "xcb_get_keyboard_mapping_keysyms_length";

get_keyboard_mapping_keysyms_end :: (r : *GetKeyboardMappingReply) -> GenericIterator #foreign libxcb "xcb_get_keyboard_mapping_keysyms_end";

get_keyboard_mapping_reply :: (
    c : *Connection,
    cookie : GetKeyboardMappingCookie,
    e : **GenericError
) -> *GetKeyboardMappingReply #foreign libxcb "xcb_get_keyboard_mapping_reply";

change_keyboard_control_value_list_serialize :: (
    buffer : **void,
    valueMask : u32,
    aux : *ChangeKeyboardControlValueList
) -> s32 #foreign libxcb "xcb_change_keyboard_control_value_list_serialize";

change_keyboard_control_value_list_unpack :: (
    buffer : *void,
    valueMask : u32,
    aux : *ChangeKeyboardControlValueList
) -> s32 #foreign libxcb "xcb_change_keyboard_control_value_list_unpack";

change_keyboard_control_value_list_sizeof :: (
    buffer : *void,
    valueMask : u32
) -> s32 #foreign libxcb "xcb_change_keyboard_control_value_list_sizeof";

change_keyboard_control_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_keyboard_control_sizeof";

change_keyboard_control_checked :: (
    c : *Connection,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_control_checked";

change_keyboard_control :: (
    c : *Connection,
    valueMask : u32,
    valueList : *void
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_control";

change_keyboard_control_aux_checked :: (
    c : *Connection,
    valueMask : u32,
    valueList : *ChangeKeyboardControlValueList
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_control_aux_checked";

change_keyboard_control_aux :: (
    c : *Connection,
    valueMask : u32,
    valueList : *ChangeKeyboardControlValueList
) -> VoidCookie #foreign libxcb "xcb_change_keyboard_control_aux";

change_keyboard_control_value_list :: (r : *ChangeKeyboardControlRequest) -> *void #foreign libxcb "xcb_change_keyboard_control_value_list";

get_keyboard_control :: (c : *Connection) -> GetKeyboardControlCookie #foreign libxcb "xcb_get_keyboard_control";

get_keyboard_control_unchecked :: (c : *Connection) -> GetKeyboardControlCookie #foreign libxcb "xcb_get_keyboard_control_unchecked";

get_keyboard_control_reply :: (
    c : *Connection,
    cookie : GetKeyboardControlCookie,
    e : **GenericError
) -> *GetKeyboardControlReply #foreign libxcb "xcb_get_keyboard_control_reply";

bell_checked :: (
    c : *Connection,
    percent : s8
) -> VoidCookie #foreign libxcb "xcb_bell_checked";

bell :: (
    c : *Connection,
    percent : s8
) -> VoidCookie #foreign libxcb "xcb_bell";

change_pointer_control_checked :: (
    c : *Connection,
    accelerationNumerator : s16,
    accelerationDenominator : s16,
    threshold : s16,
    doAcceleration : u8,
    doThreshold : u8
) -> VoidCookie #foreign libxcb "xcb_change_pointer_control_checked";

change_pointer_control :: (
    c : *Connection,
    accelerationNumerator : s16,
    accelerationDenominator : s16,
    threshold : s16,
    doAcceleration : u8,
    doThreshold : u8
) -> VoidCookie #foreign libxcb "xcb_change_pointer_control";

get_pointer_control :: (c : *Connection) -> GetPointerControlCookie #foreign libxcb "xcb_get_pointer_control";

get_pointer_control_unchecked :: (c : *Connection) -> GetPointerControlCookie #foreign libxcb "xcb_get_pointer_control_unchecked";

get_pointer_control_reply :: (
    c : *Connection,
    cookie : GetPointerControlCookie,
    e : **GenericError
) -> *GetPointerControlReply #foreign libxcb "xcb_get_pointer_control_reply";

set_screen_saver_checked :: (
    c : *Connection,
    timeout : s16,
    interval : s16,
    preferBlanking : u8,
    allowExposures : u8
) -> VoidCookie #foreign libxcb "xcb_set_screen_saver_checked";

set_screen_saver :: (
    c : *Connection,
    timeout : s16,
    interval : s16,
    preferBlanking : u8,
    allowExposures : u8
) -> VoidCookie #foreign libxcb "xcb_set_screen_saver";

get_screen_saver :: (c : *Connection) -> GetScreenSaverCookie #foreign libxcb "xcb_get_screen_saver";

get_screen_saver_unchecked :: (c : *Connection) -> GetScreenSaverCookie #foreign libxcb "xcb_get_screen_saver_unchecked";

get_screen_saver_reply :: (
    c : *Connection,
    cookie : GetScreenSaverCookie,
    e : **GenericError
) -> *GetScreenSaverReply #foreign libxcb "xcb_get_screen_saver_reply";

change_hosts_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_change_hosts_sizeof";

change_hosts_checked :: (
    c : *Connection,
    mode : u8,
    family : u8,
    addressLen : u16,
    address : *u8
) -> VoidCookie #foreign libxcb "xcb_change_hosts_checked";

change_hosts :: (
    c : *Connection,
    mode : u8,
    family : u8,
    addressLen : u16,
    address : *u8
) -> VoidCookie #foreign libxcb "xcb_change_hosts";

change_hosts_address :: (r : *ChangeHostsRequest) -> *u8 #foreign libxcb "xcb_change_hosts_address";

change_hosts_address_length :: (r : *ChangeHostsRequest) -> s32 #foreign libxcb "xcb_change_hosts_address_length";

change_hosts_address_end :: (r : *ChangeHostsRequest) -> GenericIterator #foreign libxcb "xcb_change_hosts_address_end";

host_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_host_sizeof";

host_address :: (r : *Host) -> *u8 #foreign libxcb "xcb_host_address";

host_address_length :: (r : *Host) -> s32 #foreign libxcb "xcb_host_address_length";

host_address_end :: (r : *Host) -> GenericIterator #foreign libxcb "xcb_host_address_end";

host_next :: (i : *HostIterator) -> void #foreign libxcb "xcb_host_next";

host_end :: (i : HostIterator) -> GenericIterator #foreign libxcb "xcb_host_end";

list_hosts_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_list_hosts_sizeof";

list_hosts :: (c : *Connection) -> ListHostsCookie #foreign libxcb "xcb_list_hosts";

list_hosts_unchecked :: (c : *Connection) -> ListHostsCookie #foreign libxcb "xcb_list_hosts_unchecked";

list_hosts_hosts_length :: (r : *ListHostsReply) -> s32 #foreign libxcb "xcb_list_hosts_hosts_length";

list_hosts_hosts_iterator :: (r : *ListHostsReply) -> HostIterator #foreign libxcb "xcb_list_hosts_hosts_iterator";

list_hosts_reply :: (
    c : *Connection,
    cookie : ListHostsCookie,
    e : **GenericError
) -> *ListHostsReply #foreign libxcb "xcb_list_hosts_reply";

set_access_control_checked :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_set_access_control_checked";

set_access_control :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_set_access_control";

set_close_down_mode_checked :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_set_close_down_mode_checked";

set_close_down_mode :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_set_close_down_mode";

kill_client_checked :: (
    c : *Connection,
    resource : u32
) -> VoidCookie #foreign libxcb "xcb_kill_client_checked";

kill_client :: (
    c : *Connection,
    resource : u32
) -> VoidCookie #foreign libxcb "xcb_kill_client";

rotate_properties_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_rotate_properties_sizeof";

rotate_properties_checked :: (
    c : *Connection,
    window : Window,
    atomsLen : u16,
    delta : s16,
    atoms : *Atom
) -> VoidCookie #foreign libxcb "xcb_rotate_properties_checked";

rotate_properties :: (
    c : *Connection,
    window : Window,
    atomsLen : u16,
    delta : s16,
    atoms : *Atom
) -> VoidCookie #foreign libxcb "xcb_rotate_properties";

rotate_properties_atoms :: (r : *RotatePropertiesRequest) -> *Atom #foreign libxcb "xcb_rotate_properties_atoms";

rotate_properties_atoms_length :: (r : *RotatePropertiesRequest) -> s32 #foreign libxcb "xcb_rotate_properties_atoms_length";

rotate_properties_atoms_end :: (r : *RotatePropertiesRequest) -> GenericIterator #foreign libxcb "xcb_rotate_properties_atoms_end";

force_screen_saver_checked :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_force_screen_saver_checked";

force_screen_saver :: (
    c : *Connection,
    mode : u8
) -> VoidCookie #foreign libxcb "xcb_force_screen_saver";

set_pointer_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_set_pointer_mapping_sizeof";

set_pointer_mapping :: (
    c : *Connection,
    mapLen : u8,
    _map : *u8
) -> SetPointerMappingCookie #foreign libxcb "xcb_set_pointer_mapping";

set_pointer_mapping_unchecked :: (
    c : *Connection,
    mapLen : u8,
    _map : *u8
) -> SetPointerMappingCookie #foreign libxcb "xcb_set_pointer_mapping_unchecked";

set_pointer_mapping_reply :: (
    c : *Connection,
    cookie : SetPointerMappingCookie,
    e : **GenericError
) -> *SetPointerMappingReply #foreign libxcb "xcb_set_pointer_mapping_reply";

get_pointer_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_pointer_mapping_sizeof";

get_pointer_mapping :: (c : *Connection) -> GetPointerMappingCookie #foreign libxcb "xcb_get_pointer_mapping";

get_pointer_mapping_unchecked :: (c : *Connection) -> GetPointerMappingCookie #foreign libxcb "xcb_get_pointer_mapping_unchecked";

get_pointer_mapping_map :: (r : *GetPointerMappingReply) -> *u8 #foreign libxcb "xcb_get_pointer_mapping_map";

get_pointer_mapping_map_length :: (r : *GetPointerMappingReply) -> s32 #foreign libxcb "xcb_get_pointer_mapping_map_length";

get_pointer_mapping_map_end :: (r : *GetPointerMappingReply) -> GenericIterator #foreign libxcb "xcb_get_pointer_mapping_map_end";

get_pointer_mapping_reply :: (
    c : *Connection,
    cookie : GetPointerMappingCookie,
    e : **GenericError
) -> *GetPointerMappingReply #foreign libxcb "xcb_get_pointer_mapping_reply";

set_modifier_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_set_modifier_mapping_sizeof";

set_modifier_mapping :: (
    c : *Connection,
    keycodesPerModifier : u8,
    keycodes : *Keycode
) -> SetModifierMappingCookie #foreign libxcb "xcb_set_modifier_mapping";

set_modifier_mapping_unchecked :: (
    c : *Connection,
    keycodesPerModifier : u8,
    keycodes : *Keycode
) -> SetModifierMappingCookie #foreign libxcb "xcb_set_modifier_mapping_unchecked";

set_modifier_mapping_reply :: (
    c : *Connection,
    cookie : SetModifierMappingCookie,
    e : **GenericError
) -> *SetModifierMappingReply #foreign libxcb "xcb_set_modifier_mapping_reply";

get_modifier_mapping_sizeof :: (buffer : *void) -> s32 #foreign libxcb "xcb_get_modifier_mapping_sizeof";

get_modifier_mapping :: (c : *Connection) -> GetModifierMappingCookie #foreign libxcb "xcb_get_modifier_mapping";

get_modifier_mapping_unchecked :: (c : *Connection) -> GetModifierMappingCookie #foreign libxcb "xcb_get_modifier_mapping_unchecked";

get_modifier_mapping_keycodes :: (r : *GetModifierMappingReply) -> *Keycode #foreign libxcb "xcb_get_modifier_mapping_keycodes";

get_modifier_mapping_keycodes_length :: (r : *GetModifierMappingReply) -> s32 #foreign libxcb "xcb_get_modifier_mapping_keycodes_length";

get_modifier_mapping_keycodes_end :: (r : *GetModifierMappingReply) -> GenericIterator #foreign libxcb "xcb_get_modifier_mapping_keycodes_end";

get_modifier_mapping_reply :: (
    c : *Connection,
    cookie : GetModifierMappingCookie,
    e : **GenericError
) -> *GetModifierMappingReply #foreign libxcb "xcb_get_modifier_mapping_reply";

no_operation_checked :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_no_operation_checked";

no_operation :: (c : *Connection) -> VoidCookie #foreign libxcb "xcb_no_operation";
