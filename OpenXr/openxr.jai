libopenxr :: #library "libopenxr_loader";

SPACE_VELOCITY_LINEAR_VALID_BIT :: 1;
SPACE_VELOCITY_ANGULAR_VALID_BIT :: 2;
SPACE_LOCATION_ORIENTATION_VALID_BIT :: 1;
SPACE_LOCATION_POSITION_VALID_BIT :: 2;
SPACE_LOCATION_ORIENTATION_TRACKED_BIT :: 4;
SPACE_LOCATION_POSITION_TRACKED_BIT :: 8;
SWAPCHAIN_CREATE_PROTECTED_CONTENT_BIT :: 1;
SWAPCHAIN_CREATE_STATIC_IMAGE_BIT :: 2;
SWAPCHAIN_USAGE_COLOR_ATTACHMENT_BIT :: 1;
SWAPCHAIN_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT :: 2;
SWAPCHAIN_USAGE_UNORDERED_ACCESS_BIT :: 4;
SWAPCHAIN_USAGE_TRANSFER_SRC_BIT :: 8;
SWAPCHAIN_USAGE_TRANSFER_DST_BIT :: 16;
SWAPCHAIN_USAGE_SAMPLED_BIT :: 32;
SWAPCHAIN_USAGE_MUTABLE_FORMAT_BIT :: 64;
SWAPCHAIN_USAGE_INPUT_ATTACHMENT_BIT_MND :: 128;
COMPOSITION_LAYER_CORRECT_CHROMATIC_ABERRATION_BIT :: 1;
COMPOSITION_LAYER_BLEND_TEXTURE_SOURCE_ALPHA_BIT :: 2;
COMPOSITION_LAYER_UNPREMULTIPLIED_ALPHA_BIT :: 4;
VIEW_STATE_ORIENTATION_VALID_BIT :: 1;
VIEW_STATE_POSITION_VALID_BIT :: 2;
VIEW_STATE_ORIENTATION_TRACKED_BIT :: 4;
VIEW_STATE_POSITION_TRACKED_BIT :: 8;
INPUT_SOURCE_LOCALIZED_NAME_USER_PATH_BIT :: 1;
INPUT_SOURCE_LOCALIZED_NAME_INTERACTION_PROFILE_BIT :: 2;
INPUT_SOURCE_LOCALIZED_NAME_COMPONENT_BIT :: 4;
DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT :: 1;
DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT :: 16;
DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT :: 256;
DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT :: 4096;
DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT :: 1;
DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT :: 2;
DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT :: 4;
DEBUG_UTILS_MESSAGE_TYPE_CONFORMANCE_BIT_EXT :: 8;
OVERLAY_MAIN_SESSION_ENABLED_COMPOSITION_LAYER_INFO_DEPTH_BIT_EXTX :: 1;
VERSION_1_0 :: 1;
TRUE :: 1;
FALSE :: 0;
MAX_EXTENSION_NAME_SIZE :: 128;
MAX_API_LAYER_NAME_SIZE :: 256;
MAX_API_LAYER_DESCRIPTION_SIZE :: 256;
MAX_SYSTEM_NAME_SIZE :: 256;
MAX_APPLICATION_NAME_SIZE :: 128;
MAX_ENGINE_NAME_SIZE :: 128;
MAX_RUNTIME_NAME_SIZE :: 128;
MAX_PATH_LENGTH :: 256;
MAX_STRUCTURE_NAME_SIZE :: 64;
MAX_RESULT_STRING_SIZE :: 64;
MIN_COMPOSITION_LAYERS_SUPPORTED :: 16;
MAX_ACTION_SET_NAME_SIZE :: 64;
MAX_LOCALIZED_ACTION_SET_NAME_SIZE :: 128;
MAX_ACTION_NAME_SIZE :: 64;
MAX_LOCALIZED_ACTION_NAME_SIZE :: 128;

Version :: u64;
Flags64 :: u64;
SystemId :: u64;
Bool32 :: u32;
Path :: u64;
Time :: s64;
Duration :: s64;
Instance :: u64;
Session :: u64;
Space :: u64;
Action :: u64;
Swapchain :: u64;
ActionSet :: u64;
InstanceCreateFlags :: Flags64;
SessionCreateFlags :: Flags64;
SpaceVelocityFlags :: Flags64;
SpaceLocationFlags :: Flags64;
SwapchainCreateFlags :: Flags64;
SwapchainUsageFlags :: Flags64;
CompositionLayerFlags :: Flags64;
ViewStateFlags :: Flags64;
InputSourceLocalizedNameFlags :: Flags64;
PFN_VoidFunction :: #type () #c_call;
PFN_GetInstanceProcAddr :: #type (
    instance : Instance,
    name : *u8,
    function : *PFN_VoidFunction
) -> Result #c_call;
PFN_EnumerateApiLayerProperties :: #type (
    propertyCapacityInput : u32,
    propertyCountOutput : *u32,
    properties : *ApiLayerProperties
) -> Result #c_call;
PFN_EnumerateInstanceExtensionProperties :: #type (
    layerName : *u8,
    propertyCapacityInput : u32,
    propertyCountOutput : *u32,
    properties : *ExtensionProperties
) -> Result #c_call;
PFN_CreateInstance :: #type (
    createInfo : *InstanceCreateInfo,
    instance : *Instance
) -> Result #c_call;
PFN_DestroyInstance :: #type (instance : Instance) -> Result #c_call;
PFN_GetInstanceProperties :: #type (
    instance : Instance,
    instanceProperties : *InstanceProperties
) -> Result #c_call;
PFN_PollEvent :: #type (
    instance : Instance,
    eventData : *EventDataBuffer
) -> Result #c_call;
PFN_ResultToString :: #type (
    instance : Instance,
    value : Result,
    buffer : *u8 // [64]u8
) -> Result #c_call;
PFN_StructureTypeToString :: #type (
    instance : Instance,
    value : StructureType,
    buffer : *u8 // [64]u8
) -> Result #c_call;
PFN_GetSystem :: #type (
    instance : Instance,
    getInfo : *SystemGetInfo,
    systemId : *SystemId
) -> Result #c_call;
PFN_GetSystemProperties :: #type (
    instance : Instance,
    systemId : SystemId,
    properties : *SystemProperties
) -> Result #c_call;
PFN_EnumerateEnvironmentBlendModes :: #type (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    environmentBlendModeCapacityInput : u32,
    environmentBlendModeCountOutput : *u32,
    environmentBlendModes : *EnvironmentBlendMode
) -> Result #c_call;
PFN_CreateSession :: #type (
    instance : Instance,
    createInfo : *SessionCreateInfo,
    session : *Session
) -> Result #c_call;
PFN_DestroySession :: #type (session : Session) -> Result #c_call;
PFN_EnumerateReferenceSpaces :: #type (
    session : Session,
    spaceCapacityInput : u32,
    spaceCountOutput : *u32,
    spaces : *ReferenceSpaceType
) -> Result #c_call;
PFN_CreateReferenceSpace :: #type (
    session : Session,
    createInfo : *ReferenceSpaceCreateInfo,
    space : *Space
) -> Result #c_call;
PFN_GetReferenceSpaceBoundsRect :: #type (
    session : Session,
    referenceSpaceType : ReferenceSpaceType,
    bounds : *Extent2Df
) -> Result #c_call;
PFN_CreateActionSpace :: #type (
    session : Session,
    createInfo : *ActionSpaceCreateInfo,
    space : *Space
) -> Result #c_call;
PFN_LocateSpace :: #type (
    space : Space,
    baseSpace : Space,
    time : Time,
    location : *SpaceLocation
) -> Result #c_call;
PFN_DestroySpace :: #type (space : Space) -> Result #c_call;
PFN_EnumerateViewConfigurations :: #type (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationTypeCapacityInput : u32,
    viewConfigurationTypeCountOutput : *u32,
    viewConfigurationTypes : *ViewConfigurationType
) -> Result #c_call;
PFN_GetViewConfigurationProperties :: #type (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    configurationProperties : *ViewConfigurationProperties
) -> Result #c_call;
PFN_EnumerateViewConfigurationViews :: #type (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    viewCapacityInput : u32,
    viewCountOutput : *u32,
    views : *ViewConfigurationView
) -> Result #c_call;
PFN_EnumerateSwapchainFormats :: #type (
    session : Session,
    formatCapacityInput : u32,
    formatCountOutput : *u32,
    formats : *s64
) -> Result #c_call;
PFN_CreateSwapchain :: #type (
    session : Session,
    createInfo : *SwapchainCreateInfo,
    swapchain : *Swapchain
) -> Result #c_call;
PFN_DestroySwapchain :: #type (swapchain : Swapchain) -> Result #c_call;
PFN_EnumerateSwapchainImages :: #type (
    swapchain : Swapchain,
    imageCapacityInput : u32,
    imageCountOutput : *u32,
    images : *SwapchainImageBaseHeader
) -> Result #c_call;
PFN_AcquireSwapchainImage :: #type (
    swapchain : Swapchain,
    acquireInfo : *SwapchainImageAcquireInfo,
    index : *u32
) -> Result #c_call;
PFN_WaitSwapchainImage :: #type (
    swapchain : Swapchain,
    waitInfo : *SwapchainImageWaitInfo
) -> Result #c_call;
PFN_ReleaseSwapchainImage :: #type (
    swapchain : Swapchain,
    releaseInfo : *SwapchainImageReleaseInfo
) -> Result #c_call;
PFN_BeginSession :: #type (
    session : Session,
    beginInfo : *SessionBeginInfo
) -> Result #c_call;
PFN_EndSession :: #type (session : Session) -> Result #c_call;
PFN_RequestExitSession :: #type (session : Session) -> Result #c_call;
PFN_WaitFrame :: #type (
    session : Session,
    frameWaitInfo : *FrameWaitInfo,
    frameState : *FrameState
) -> Result #c_call;
PFN_BeginFrame :: #type (
    session : Session,
    frameBeginInfo : *FrameBeginInfo
) -> Result #c_call;
PFN_EndFrame :: #type (
    session : Session,
    frameEndInfo : *FrameEndInfo
) -> Result #c_call;
PFN_LocateViews :: #type (
    session : Session,
    viewLocateInfo : *ViewLocateInfo,
    viewState : *ViewState,
    viewCapacityInput : u32,
    viewCountOutput : *u32,
    views : *View
) -> Result #c_call;
PFN_StringToPath :: #type (
    instance : Instance,
    pathString : *u8,
    path : *Path
) -> Result #c_call;
PFN_PathToString :: #type (
    instance : Instance,
    path : Path,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #c_call;
PFN_CreateActionSet :: #type (
    instance : Instance,
    createInfo : *ActionSetCreateInfo,
    actionSet : *ActionSet
) -> Result #c_call;
PFN_DestroyActionSet :: #type (actionSet : ActionSet) -> Result #c_call;
PFN_CreateAction :: #type (
    actionSet : ActionSet,
    createInfo : *ActionCreateInfo,
    action : *Action
) -> Result #c_call;
PFN_DestroyAction :: #type (action : Action) -> Result #c_call;
PFN_SuggestInteractionProfileBindings :: #type (
    instance : Instance,
    suggestedBindings : *InteractionProfileSuggestedBinding
) -> Result #c_call;
PFN_AttachSessionActionSets :: #type (
    session : Session,
    attachInfo : *SessionActionSetsAttachInfo
) -> Result #c_call;
PFN_GetCurrentInteractionProfile :: #type (
    session : Session,
    topLevelUserPath : Path,
    interactionProfile : *InteractionProfileState
) -> Result #c_call;
PFN_GetActionStateBoolean :: #type (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateBoolean
) -> Result #c_call;
PFN_GetActionStateFloat :: #type (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateFloat
) -> Result #c_call;
PFN_GetActionStateVector2f :: #type (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateVector2f
) -> Result #c_call;
PFN_GetActionStatePose :: #type (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStatePose
) -> Result #c_call;
PFN_SyncActions :: #type (
    session : Session,
    syncInfo : *ActionsSyncInfo
) -> Result #c_call;
PFN_EnumerateBoundSourcesForAction :: #type (
    session : Session,
    enumerateInfo : *BoundSourcesForActionEnumerateInfo,
    sourceCapacityInput : u32,
    sourceCountOutput : *u32,
    sources : *Path
) -> Result #c_call;
PFN_GetInputSourceLocalizedName :: #type (
    session : Session,
    getInfo : *InputSourceLocalizedNameGetInfo,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #c_call;
PFN_ApplyHapticFeedback :: #type (
    session : Session,
    hapticActionInfo : *HapticActionInfo,
    hapticFeedback : *HapticBaseHeader
) -> Result #c_call;
PFN_StopHapticFeedback :: #type (
    session : Session,
    hapticActionInfo : *HapticActionInfo
) -> Result #c_call;
PFN_GetVisibilityMaskKHR :: #type (
    session : Session,
    viewConfigurationType : ViewConfigurationType,
    viewIndex : u32,
    visibilityMaskType : VisibilityMaskTypeKHR,
    visibilityMask : *VisibilityMaskKHR
) -> Result #c_call;
PFN_InitializeLoaderKHR :: #type (loaderInitInfo : *LoaderInitInfoBaseHeaderKHR) -> Result #c_call;
PFN_PerfSettingsSetPerformanceLevelEXT :: #type (
    session : Session,
    domain : PerfSettingsDomainEXT,
    level : PerfSettingsLevelEXT
) -> Result #c_call;
PFN_ThermalGetTemperatureTrendEXT :: #type (
    session : Session,
    domain : PerfSettingsDomainEXT,
    notificationLevel : *PerfSettingsNotificationLevelEXT,
    tempHeadroom : *float32,
    tempSlope : *float32
) -> Result #c_call;
DebugUtilsMessengerEXT :: u64;
DebugUtilsMessageSeverityFlagsEXT :: Flags64;
DebugUtilsMessageTypeFlagsEXT :: Flags64;
PFN_DebugUtilsMessengerCallbackEXT :: #type (
    messageSeverity : DebugUtilsMessageSeverityFlagsEXT,
    messageTypes : DebugUtilsMessageTypeFlagsEXT,
    callbackData : *DebugUtilsMessengerCallbackDataEXT,
    userData : *void
) -> Bool32 #c_call;
PFN_SetDebugUtilsObjectNameEXT :: #type (
    instance : Instance,
    nameInfo : *DebugUtilsObjectNameInfoEXT
) -> Result #c_call;
PFN_CreateDebugUtilsMessengerEXT :: #type (
    instance : Instance,
    createInfo : *DebugUtilsMessengerCreateInfoEXT,
    messenger : *DebugUtilsMessengerEXT
) -> Result #c_call;
PFN_DestroyDebugUtilsMessengerEXT :: #type (messenger : DebugUtilsMessengerEXT) -> Result #c_call;
PFN_SubmitDebugUtilsMessageEXT :: #type (
    instance : Instance,
    messageSeverity : DebugUtilsMessageSeverityFlagsEXT,
    messageTypes : DebugUtilsMessageTypeFlagsEXT,
    callbackData : *DebugUtilsMessengerCallbackDataEXT
) -> Result #c_call;
PFN_SessionBeginDebugUtilsLabelRegionEXT :: #type (
    session : Session,
    labelInfo : *DebugUtilsLabelEXT
) -> Result #c_call;
PFN_SessionEndDebugUtilsLabelRegionEXT :: #type (session : Session) -> Result #c_call;
PFN_SessionInsertDebugUtilsLabelEXT :: #type (
    session : Session,
    labelInfo : *DebugUtilsLabelEXT
) -> Result #c_call;
OverlaySessionCreateFlagsEXTX :: Flags64;
OverlayMainSessionFlagsEXTX :: Flags64;
SpatialAnchorMSFT :: u64;
PFN_CreateSpatialAnchorMSFT :: #type (
    session : Session,
    createInfo : *SpatialAnchorCreateInfoMSFT,
    anchor : *SpatialAnchorMSFT
) -> Result #c_call;
PFN_CreateSpatialAnchorSpaceMSFT :: #type (
    session : Session,
    createInfo : *SpatialAnchorSpaceCreateInfoMSFT,
    space : *Space
) -> Result #c_call;
PFN_DestroySpatialAnchorMSFT :: #type (anchor : SpatialAnchorMSFT) -> Result #c_call;
PFN_SetInputDeviceActiveEXT :: #type (
    session : Session,
    interactionProfile : Path,
    topLevelPath : Path,
    isActive : Bool32
) -> Result #c_call;
PFN_SetInputDeviceStateBoolEXT :: #type (
    session : Session,
    topLevelPath : Path,
    inputSourcePath : Path,
    state : Bool32
) -> Result #c_call;
PFN_SetInputDeviceStateFloatEXT :: #type (
    session : Session,
    topLevelPath : Path,
    inputSourcePath : Path,
    state : float32
) -> Result #c_call;
PFN_SetInputDeviceStateVector2fEXT :: #type (
    session : Session,
    topLevelPath : Path,
    inputSourcePath : Path,
    state : Vector2f
) -> Result #c_call;
PFN_SetInputDeviceLocationEXT :: #type (
    session : Session,
    topLevelPath : Path,
    inputSourcePath : Path,
    space : Space,
    pose : Posef
) -> Result #c_call;
PFN_CreateSpatialGraphNodeSpaceMSFT :: #type (
    session : Session,
    createInfo : *SpatialGraphNodeSpaceCreateInfoMSFT,
    space : *Space
) -> Result #c_call;
HandTrackerEXT :: u64;
PFN_CreateHandTrackerEXT :: #type (
    session : Session,
    createInfo : *HandTrackerCreateInfoEXT,
    handTracker : *HandTrackerEXT
) -> Result #c_call;
PFN_DestroyHandTrackerEXT :: #type (handTracker : HandTrackerEXT) -> Result #c_call;
PFN_LocateHandJointsEXT :: #type (
    handTracker : HandTrackerEXT,
    locateInfo : *HandJointsLocateInfoEXT,
    locations : *HandJointLocationsEXT
) -> Result #c_call;
PFN_CreateHandMeshSpaceMSFT :: #type (
    handTracker : HandTrackerEXT,
    createInfo : *HandMeshSpaceCreateInfoMSFT,
    space : *Space
) -> Result #c_call;
PFN_UpdateHandMeshMSFT :: #type (
    handTracker : HandTrackerEXT,
    updateInfo : *HandMeshUpdateInfoMSFT,
    handMesh : *HandMeshMSFT
) -> Result #c_call;
ControllerModelKeyMSFT :: u64;
PFN_GetControllerModelKeyMSFT :: #type (
    session : Session,
    topLevelUserPath : Path,
    controllerModelKeyState : *ControllerModelKeyStateMSFT
) -> Result #c_call;
PFN_LoadControllerModelMSFT :: #type (
    session : Session,
    modelKey : ControllerModelKeyMSFT,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #c_call;
PFN_GetControllerModelPropertiesMSFT :: #type (
    session : Session,
    modelKey : ControllerModelKeyMSFT,
    properties : *ControllerModelPropertiesMSFT
) -> Result #c_call;
PFN_GetControllerModelStateMSFT :: #type (
    session : Session,
    modelKey : ControllerModelKeyMSFT,
    state : *ControllerModelStateMSFT
) -> Result #c_call;
PFN_EnumerateDisplayRefreshRatesFB :: #type (
    session : Session,
    displayRefreshRateCapacityInput : u32,
    displayRefreshRateCountOutput : *u32,
    displayRefreshRates : *float32
) -> Result #c_call;
PFN_GetDisplayRefreshRateFB :: #type (
    session : Session,
    displayRefreshRate : *float32
) -> Result #c_call;
PFN_RequestDisplayRefreshRateFB :: #type (
    session : Session,
    displayRefreshRate : float32
) -> Result #c_call;
PFN_EnumerateColorSpacesFB :: #type (
    session : Session,
    colorSpaceCapacityInput : u32,
    colorSpaceCountOutput : *u32,
    colorSpaces : *ColorSpaceFB
) -> Result #c_call;
PFN_SetColorSpaceFB :: #type (
    session : Session,
    colorspace : ColorSpaceFB
) -> Result #c_call;
PFN_SetEnvironmentDepthEstimationVARJO :: #type (
    session : Session,
    enabled : Bool32
) -> Result #c_call;
PFN_GetVulkanInstanceExtensionsKHR :: #type (
    instance : Instance,
    systemId : SystemId,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #c_call;
PFN_GetVulkanDeviceExtensionsKHR :: #type (
    instance : Instance,
    systemId : SystemId,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #c_call;
PFN_GetVulkanGraphicsDeviceKHR :: #type (
    instance : Instance,
    systemId : SystemId,
    vkInstance : *void, // VkInstance,
    vkPhysicalDevice : *void
) -> Result #c_call;
PFN_GetVulkanGraphicsRequirementsKHR :: #type (
    instance : Instance,
    systemId : SystemId,
    graphicsRequirements : *GraphicsRequirementsVulkanKHR
) -> Result #c_call;
VulkanInstanceCreateFlagsKHR :: Flags64;

Result :: enum s32 {
    Success :: 0;
    TimeoutExpired :: 1;
    SessionLossPending :: 3;
    EventUnavailable :: 4;
    SpaceBoundsUnavailable :: 7;
    SessionNotFocused :: 8;
    FrameDiscarded :: 9;
    ErrorValidationFailure :: -1;
    ErrorRuntimeFailure :: -2;
    ErrorOutOfMemory :: -3;
    ErrorApiVersionUnsupported :: -4;
    ErrorInitializationFailed :: -6;
    ErrorFunctionUnsupported :: -7;
    ErrorFeatureUnsupported :: -8;
    ErrorExtensionNotPresent :: -9;
    ErrorLimitReached :: -10;
    ErrorSizeInsufficient :: -11;
    ErrorHandleInvalid :: -12;
    ErrorInstanceLost :: -13;
    ErrorSessionRunning :: -14;
    ErrorSessionNotRunning :: -16;
    ErrorSessionLost :: -17;
    ErrorSystemInvalid :: -18;
    ErrorPathInvalid :: -19;
    ErrorPathCountExceeded :: -20;
    ErrorPathFormatInvalid :: -21;
    ErrorPathUnsupported :: -22;
    ErrorLayerInvalid :: -23;
    ErrorLayerLimitExceeded :: -24;
    ErrorSwapchainRectInvalid :: -25;
    ErrorSwapchainFormatUnsupported :: -26;
    ErrorActionTypeMismatch :: -27;
    ErrorSessionNotReady :: -28;
    ErrorSessionNotStopping :: -29;
    ErrorTimeInvalid :: -30;
    ErrorReferenceSpaceUnsupported :: -31;
    ErrorFileAccessError :: -32;
    ErrorFileContentsInvalid :: -33;
    ErrorFormFactorUnsupported :: -34;
    ErrorFormFactorUnavailable :: -35;
    ErrorApiLayerNotPresent :: -36;
    ErrorCallOrderInvalid :: -37;
    ErrorGraphicsDeviceInvalid :: -38;
    ErrorPoseInvalid :: -39;
    ErrorIndexOutOfRange :: -40;
    ErrorViewConfigurationTypeUnsupported :: -41;
    ErrorEnvironmentBlendModeUnsupported :: -42;
    ErrorNameDuplicated :: -44;
    ErrorNameInvalid :: -45;
    ErrorActionsetNotAttached :: -46;
    ErrorActionsetsAlreadyAttached :: -47;
    ErrorLocalizedNameDuplicated :: -48;
    ErrorLocalizedNameInvalid :: -49;
    ErrorGraphicsRequirementsCallMissing :: -50;
    ErrorRuntimeUnavailable :: -51;
    ErrorAndroidThreadSettingsIdInvalidKhr :: -1000003000;
    ErrorAndroidThreadSettingsFailureKhr :: -1000003001;
    ErrorCreateSpatialAnchorFailedMsft :: -1000039001;
    ErrorSecondaryViewConfigurationTypeNotEnabledMsft :: -1000053000;
    ErrorControllerModelKeyInvalidMsft :: -1000055000;
    ErrorDisplayRefreshRateUnsupportedFb :: -1000101000;
    ErrorColorSpaceUnsupportedFb :: -1000108000;
    MaxEnum :: 2147483647;
}

StructureType :: enum s32 {
    TypeUnknown :: 0;
    TypeApiLayerProperties :: 1;
    TypeExtensionProperties :: 2;
    TypeInstanceCreateInfo :: 3;
    TypeSystemGetInfo :: 4;
    TypeSystemProperties :: 5;
    TypeViewLocateInfo :: 6;
    TypeView :: 7;
    TypeSessionCreateInfo :: 8;
    TypeSwapchainCreateInfo :: 9;
    TypeSessionBeginInfo :: 10;
    TypeViewState :: 11;
    TypeFrameEndInfo :: 12;
    TypeHapticVibration :: 13;
    TypeEventDataBuffer :: 16;
    TypeEventDataInstanceLossPending :: 17;
    TypeEventDataSessionStateChanged :: 18;
    TypeActionStateBoolean :: 23;
    TypeActionStateFloat :: 24;
    TypeActionStateVector2F :: 25;
    TypeActionStatePose :: 27;
    TypeActionSetCreateInfo :: 28;
    TypeActionCreateInfo :: 29;
    TypeInstanceProperties :: 32;
    TypeFrameWaitInfo :: 33;
    TypeCompositionLayerProjection :: 35;
    TypeCompositionLayerQuad :: 36;
    TypeReferenceSpaceCreateInfo :: 37;
    TypeActionSpaceCreateInfo :: 38;
    TypeEventDataReferenceSpaceChangePending :: 40;
    TypeViewConfigurationView :: 41;
    TypeSpaceLocation :: 42;
    TypeSpaceVelocity :: 43;
    TypeFrameState :: 44;
    TypeViewConfigurationProperties :: 45;
    TypeFrameBeginInfo :: 46;
    TypeCompositionLayerProjectionView :: 48;
    TypeEventDataEventsLost :: 49;
    TypeInteractionProfileSuggestedBinding :: 51;
    TypeEventDataInteractionProfileChanged :: 52;
    TypeInteractionProfileState :: 53;
    TypeSwapchainImageAcquireInfo :: 55;
    TypeSwapchainImageWaitInfo :: 56;
    TypeSwapchainImageReleaseInfo :: 57;
    TypeActionStateGetInfo :: 58;
    TypeHapticActionInfo :: 59;
    TypeSessionActionSetsAttachInfo :: 60;
    TypeActionsSyncInfo :: 61;
    TypeBoundSourcesForActionEnumerateInfo :: 62;
    TypeInputSourceLocalizedNameGetInfo :: 63;
    TypeCompositionLayerCubeKhr :: 1000006000;
    TypeInstanceCreateInfoAndroidKhr :: 1000008000;
    TypeCompositionLayerDepthInfoKhr :: 1000010000;
    TypeVulkanSwapchainFormatListCreateInfoKhr :: 1000014000;
    TypeEventDataPerfSettingsExt :: 1000015000;
    TypeCompositionLayerCylinderKhr :: 1000017000;
    TypeCompositionLayerEquirectKhr :: 1000018000;
    TypeDebugUtilsObjectNameInfoExt :: 1000019000;
    TypeDebugUtilsMessengerCallbackDataExt :: 1000019001;
    TypeDebugUtilsMessengerCreateInfoExt :: 1000019002;
    TypeDebugUtilsLabelExt :: 1000019003;
    TypeGraphicsBindingOpenglWin32Khr :: 1000023000;
    TypeGraphicsBindingOpenglXlibKhr :: 1000023001;
    TypeGraphicsBindingOpenglXcbKhr :: 1000023002;
    TypeGraphicsBindingOpenglWaylandKhr :: 1000023003;
    TypeSwapchainImageOpenglKhr :: 1000023004;
    TypeGraphicsRequirementsOpenglKhr :: 1000023005;
    TypeGraphicsBindingOpenglEsAndroidKhr :: 1000024001;
    TypeSwapchainImageOpenglEsKhr :: 1000024002;
    TypeGraphicsRequirementsOpenglEsKhr :: 1000024003;
    TypeGraphicsBindingVulkanKhr :: 1000025000;
    TypeSwapchainImageVulkanKhr :: 1000025001;
    TypeGraphicsRequirementsVulkanKhr :: 1000025002;
    TypeGraphicsBindingD3D11Khr :: 1000027000;
    TypeSwapchainImageD3D11Khr :: 1000027001;
    TypeGraphicsRequirementsD3D11Khr :: 1000027002;
    TypeGraphicsBindingD3D12Khr :: 1000028000;
    TypeSwapchainImageD3D12Khr :: 1000028001;
    TypeGraphicsRequirementsD3D12Khr :: 1000028002;
    TypeSystemEyeGazeInteractionPropertiesExt :: 1000030000;
    TypeEyeGazeSampleTimeExt :: 1000030001;
    TypeVisibilityMaskKhr :: 1000031000;
    TypeEventDataVisibilityMaskChangedKhr :: 1000031001;
    TypeSessionCreateInfoOverlayExtx :: 1000033000;
    TypeEventDataMainSessionVisibilityChangedExtx :: 1000033003;
    TypeCompositionLayerColorScaleBiasKhr :: 1000034000;
    TypeSpatialAnchorCreateInfoMsft :: 1000039000;
    TypeSpatialAnchorSpaceCreateInfoMsft :: 1000039001;
    TypeViewConfigurationDepthRangeExt :: 1000046000;
    TypeGraphicsBindingEglMndx :: 1000048004;
    TypeSpatialGraphNodeSpaceCreateInfoMsft :: 1000049000;
    TypeSystemHandTrackingPropertiesExt :: 1000051000;
    TypeHandTrackerCreateInfoExt :: 1000051001;
    TypeHandJointsLocateInfoExt :: 1000051002;
    TypeHandJointLocationsExt :: 1000051003;
    TypeHandJointVelocitiesExt :: 1000051004;
    TypeSystemHandTrackingMeshPropertiesMsft :: 1000052000;
    TypeHandMeshSpaceCreateInfoMsft :: 1000052001;
    TypeHandMeshUpdateInfoMsft :: 1000052002;
    TypeHandMeshMsft :: 1000052003;
    TypeHandPoseTypeInfoMsft :: 1000052004;
    TypeSecondaryViewConfigurationSessionBeginInfoMsft :: 1000053000;
    TypeSecondaryViewConfigurationStateMsft :: 1000053001;
    TypeSecondaryViewConfigurationFrameStateMsft :: 1000053002;
    TypeSecondaryViewConfigurationFrameEndInfoMsft :: 1000053003;
    TypeSecondaryViewConfigurationLayerInfoMsft :: 1000053004;
    TypeSecondaryViewConfigurationSwapchainCreateInfoMsft :: 1000053005;
    TypeControllerModelKeyStateMsft :: 1000055000;
    TypeControllerModelNodePropertiesMsft :: 1000055001;
    TypeControllerModelPropertiesMsft :: 1000055002;
    TypeControllerModelNodeStateMsft :: 1000055003;
    TypeControllerModelStateMsft :: 1000055004;
    TypeViewConfigurationViewFovEpic :: 1000059000;
    TypeHolographicWindowAttachmentMsft :: 1000063000;
    TypeAndroidSurfaceSwapchainCreateInfoFb :: 1000070000;
    TypeSwapchainStateAndroidSurfaceDimensionsFb :: 1000071000;
    TypeSwapchainStateSamplerOpenglEsFb :: 1000071001;
    TypeInteractionProfileAnalogThresholdValve :: 1000079000;
    TypeHandJointsMotionRangeInfoExt :: 1000080000;
    TypeLoaderInitInfoAndroidKhr :: 1000089000;
    TypeVulkanInstanceCreateInfoKhr :: 1000090000;
    TypeVulkanDeviceCreateInfoKhr :: 1000090001;
    TypeVulkanGraphicsDeviceGetInfoKhr :: 1000090003;
    TypeCompositionLayerEquirect2Khr :: 1000091000;
    TypeEventDataDisplayRefreshRateChangedFb :: 1000101000;
    TypeSystemColorSpacePropertiesFb :: 1000108000;
    TypeBindingModificationsKhr :: 1000120000;
    TypeViewLocateFoveatedRenderingVarjo :: 1000121000;
    TypeFoveatedViewConfigurationViewVarjo :: 1000121001;
    TypeSystemFoveatedRenderingPropertiesVarjo :: 1000121002;
    TypeCompositionLayerDepthTestVarjo :: 1000122000;
    TypeGraphicsBindingVulkan2Khr :: 1000025000;
    TypeSwapchainImageVulkan2Khr :: 1000025001;
    TypeGraphicsRequirementsVulkan2Khr :: 1000025002;
    MaxEnum :: 2147483647;
}

FormFactor :: enum s32 {
    HeadMountedDisplay :: 1;
    HandheldDisplay :: 2;
    MaxEnum :: 2147483647;
}

ViewConfigurationType :: enum s32 {
    PrimaryMono :: 1;
    PrimaryStereo :: 2;
    PrimaryQuadVarjo :: 1000037000;
    SecondaryMonoFirstPersonObserverMsft :: 1000054000;
    MaxEnum :: 2147483647;
}

EnvironmentBlendMode :: enum s32 {
    Opaque :: 1;
    Additive :: 2;
    AlphaBlend :: 3;
    MaxEnum :: 2147483647;
}

ReferenceSpaceType :: enum s32 {
    View :: 1;
    Local :: 2;
    Stage :: 3;
    UnboundedMsft :: 1000038000;
    CombinedEyeVarjo :: 1000121000;
    MaxEnum :: 2147483647;
}

ActionType :: enum s32 {
    BooleanInput :: 1;
    FloatInput :: 2;
    Vector2FInput :: 3;
    PoseInput :: 4;
    VibrationOutput :: 100;
    MaxEnum :: 2147483647;
}

EyeVisibility :: enum s32 {
    Both :: 0;
    Left :: 1;
    Right :: 2;
    MaxEnum :: 2147483647;
}

SessionState :: enum s32 {
    Unknown :: 0;
    Idle :: 1;
    Ready :: 2;
    Synchronized :: 3;
    Visible :: 4;
    Focused :: 5;
    Stopping :: 6;
    LossPending :: 7;
    Exiting :: 8;
    MaxEnum :: 2147483647;
}

ObjectType :: enum s32 {
    Unknown :: 0;
    Instance :: 1;
    Session :: 2;
    Swapchain :: 3;
    Space :: 4;
    ActionSet :: 5;
    Action :: 6;
    DebugUtilsMessengerExt :: 1000019000;
    SpatialAnchorMsft :: 1000039000;
    HandTrackerExt :: 1000051000;
    MaxEnum :: 2147483647;
}

VisibilityMaskTypeKHR :: enum s32 {
    VisibilityMaskTypeHiddenTriangleMeshKhr :: 1;
    VisibilityMaskTypeVisibleTriangleMeshKhr :: 2;
    VisibilityMaskTypeLineLoopKhr :: 3;
    VisibilityMaskTypeMaxEnumKhr :: 2147483647;
}

PerfSettingsDomainEXT :: enum s32 {
    PerfSettingsDomainCpuExt :: 1;
    PerfSettingsDomainGpuExt :: 2;
    PerfSettingsDomainMaxEnumExt :: 2147483647;
}

PerfSettingsSubDomainEXT :: enum s32 {
    PerfSettingsSubDomainCompositingExt :: 1;
    PerfSettingsSubDomainRenderingExt :: 2;
    PerfSettingsSubDomainThermalExt :: 3;
    PerfSettingsSubDomainMaxEnumExt :: 2147483647;
}

PerfSettingsLevelEXT :: enum s32 {
    PerfSettingsLevelPowerSavingsExt :: 0;
    PerfSettingsLevelSustainedLowExt :: 25;
    PerfSettingsLevelSustainedHighExt :: 50;
    PerfSettingsLevelBoostExt :: 75;
    PerfSettingsLevelMaxEnumExt :: 2147483647;
}

PerfSettingsNotificationLevelEXT :: enum s32 {
    PerfSettingsNotifLevelNormalExt :: 0;
    PerfSettingsNotifLevelWarningExt :: 25;
    PerfSettingsNotifLevelImpairedExt :: 75;
    PerfSettingsNotificationLevelMaxEnumExt :: 2147483647;
}

SpatialGraphNodeTypeMSFT :: enum s32 {
    SpatialGraphNodeTypeStaticMsft :: 1;
    SpatialGraphNodeTypeDynamicMsft :: 2;
    SpatialGraphNodeTypeMaxEnumMsft :: 2147483647;
}

HandEXT :: enum s32 {
    HandLeftExt :: 1;
    HandRightExt :: 2;
    HandMaxEnumExt :: 2147483647;
}

HandJointEXT :: enum s32 {
    HandJointPalmExt :: 0;
    HandJointWristExt :: 1;
    HandJointThumbMetacarpalExt :: 2;
    HandJointThumbProximalExt :: 3;
    HandJointThumbDistalExt :: 4;
    HandJointThumbTipExt :: 5;
    HandJointIndexMetacarpalExt :: 6;
    HandJointIndexProximalExt :: 7;
    HandJointIndexIntermediateExt :: 8;
    HandJointIndexDistalExt :: 9;
    HandJointIndexTipExt :: 10;
    HandJointMiddleMetacarpalExt :: 11;
    HandJointMiddleProximalExt :: 12;
    HandJointMiddleIntermediateExt :: 13;
    HandJointMiddleDistalExt :: 14;
    HandJointMiddleTipExt :: 15;
    HandJointRingMetacarpalExt :: 16;
    HandJointRingProximalExt :: 17;
    HandJointRingIntermediateExt :: 18;
    HandJointRingDistalExt :: 19;
    HandJointRingTipExt :: 20;
    HandJointLittleMetacarpalExt :: 21;
    HandJointLittleProximalExt :: 22;
    HandJointLittleIntermediateExt :: 23;
    HandJointLittleDistalExt :: 24;
    HandJointLittleTipExt :: 25;
    HandJointMaxEnumExt :: 2147483647;
}

HandJointSetEXT :: enum s32 {
    HandJointSetDefaultExt :: 0;
    HandJointSetMaxEnumExt :: 2147483647;
}

HandPoseTypeMSFT :: enum s32 {
    HandPoseTypeTrackedMsft :: 0;
    HandPoseTypeReferenceOpenPalmMsft :: 1;
    HandPoseTypeMaxEnumMsft :: 2147483647;
}

HandJointsMotionRangeEXT :: enum s32 {
    HandJointsMotionRangeUnobstructedExt :: 1;
    HandJointsMotionRangeConformingToControllerExt :: 2;
    HandJointsMotionRangeMaxEnumExt :: 2147483647;
}

ColorSpaceFB :: enum s32 {
    ColorSpaceUnmanagedFb :: 0;
    ColorSpaceRec2020Fb :: 1;
    ColorSpaceRec709Fb :: 2;
    ColorSpaceRiftCv1Fb :: 3;
    ColorSpaceRiftS_fb :: 4;
    ColorSpaceQuestFb :: 5;
    ColorSpaceP3Fb :: 6;
    ColorSpaceAdobeRgbFb :: 7;
    ColorSpaceMaxEnumFb :: 2147483647;
}

ApiLayerProperties :: struct {
    type : StructureType;
    next : *void;
    layerName : [256]u8;
    specVersion : Version;
    layerVersion : u32;
    description : [256]u8;
}

ExtensionProperties :: struct {
    type : StructureType;
    next : *void;
    extensionName : [128]u8;
    extensionVersion : u32;
}

ApplicationInfo :: struct {
    applicationName : [128]u8;
    applicationVersion : u32;
    engineName : [128]u8;
    engineVersion : u32;
    apiVersion : Version;
}

InstanceCreateInfo :: struct {
    type : StructureType;
    next : *void;
    createFlags : InstanceCreateFlags;
    applicationInfo : ApplicationInfo;
    enabledApiLayerCount : u32;
    enabledApiLayerNames : **u8;
    enabledExtensionCount : u32;
    enabledExtensionNames : **u8;
}

InstanceProperties :: struct {
    type : StructureType;
    next : *void;
    runtimeVersion : Version;
    runtimeName : [128]u8;
}

EventDataBuffer :: struct {
    type : StructureType;
    next : *void;
    varying : [4000]u8;
}

SystemGetInfo :: struct {
    type : StructureType;
    next : *void;
    formFactor : FormFactor;
}

SystemGraphicsProperties :: struct {
    maxSwapchainImageHeight : u32;
    maxSwapchainImageWidth : u32;
    maxLayerCount : u32;
}

SystemTrackingProperties :: struct {
    orientationTracking : Bool32;
    positionTracking : Bool32;
}

SystemProperties :: struct {
    type : StructureType;
    next : *void;
    systemId : SystemId;
    vendorId : u32;
    systemName : [256]u8;
    graphicsProperties : SystemGraphicsProperties;
    trackingProperties : SystemTrackingProperties;
}

SessionCreateInfo :: struct {
    type : StructureType;
    next : *void;
    createFlags : SessionCreateFlags;
    systemId : SystemId;
}

Vector3f :: struct {
    x : float32;
    y : float32;
    z : float32;
}

SpaceVelocity :: struct {
    type : StructureType;
    next : *void;
    velocityFlags : SpaceVelocityFlags;
    linearVelocity : Vector3f;
    angularVelocity : Vector3f;
}

Quaternionf :: struct {
    x : float32;
    y : float32;
    z : float32;
    w : float32;
}

Posef :: struct {
    orientation : Quaternionf;
    position : Vector3f;
}

ReferenceSpaceCreateInfo :: struct {
    type : StructureType;
    next : *void;
    referenceSpaceType : ReferenceSpaceType;
    poseInReferenceSpace : Posef;
}

Extent2Df :: struct {
    width : float32;
    height : float32;
}

ActionSpaceCreateInfo :: struct {
    type : StructureType;
    next : *void;
    action : Action;
    subactionPath : Path;
    poseInActionSpace : Posef;
}

SpaceLocation :: struct {
    type : StructureType;
    next : *void;
    locationFlags : SpaceLocationFlags;
    pose : Posef;
}

ViewConfigurationProperties :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationType : ViewConfigurationType;
    fovMutable : Bool32;
}

ViewConfigurationView :: struct {
    type : StructureType;
    next : *void;
    recommendedImageRectWidth : u32;
    maxImageRectWidth : u32;
    recommendedImageRectHeight : u32;
    maxImageRectHeight : u32;
    recommendedSwapchainSampleCount : u32;
    maxSwapchainSampleCount : u32;
}

SwapchainCreateInfo :: struct {
    type : StructureType;
    next : *void;
    createFlags : SwapchainCreateFlags;
    usageFlags : SwapchainUsageFlags;
    format : s64;
    sampleCount : u32;
    width : u32;
    height : u32;
    faceCount : u32;
    arraySize : u32;
    mipCount : u32;
}

SwapchainImageBaseHeader :: struct {
    type : StructureType;
    next : *void;
}

SwapchainImageAcquireInfo :: struct {
    type : StructureType;
    next : *void;
}

SwapchainImageWaitInfo :: struct {
    type : StructureType;
    next : *void;
    timeout : Duration;
}

SwapchainImageReleaseInfo :: struct {
    type : StructureType;
    next : *void;
}

SessionBeginInfo :: struct {
    type : StructureType;
    next : *void;
    primaryViewConfigurationType : ViewConfigurationType;
}

FrameWaitInfo :: struct {
    type : StructureType;
    next : *void;
}

FrameState :: struct {
    type : StructureType;
    next : *void;
    predictedDisplayTime : Time;
    predictedDisplayPeriod : Duration;
    shouldRender : Bool32;
}

FrameBeginInfo :: struct {
    type : StructureType;
    next : *void;
}

CompositionLayerBaseHeader :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
}

FrameEndInfo :: struct {
    type : StructureType;
    next : *void;
    displayTime : Time;
    environmentBlendMode : EnvironmentBlendMode;
    layerCount : u32;
    layers : **CompositionLayerBaseHeader;
}

ViewLocateInfo :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationType : ViewConfigurationType;
    displayTime : Time;
    space : Space;
}

ViewState :: struct {
    type : StructureType;
    next : *void;
    viewStateFlags : ViewStateFlags;
}

Fovf :: struct {
    angleLeft : float32;
    angleRight : float32;
    angleUp : float32;
    angleDown : float32;
}

View :: struct {
    type : StructureType;
    next : *void;
    pose : Posef;
    fov : Fovf;
}

ActionSetCreateInfo :: struct {
    type : StructureType;
    next : *void;
    actionSetName : [64]u8;
    localizedActionSetName : [128]u8;
    priority : u32;
}

ActionCreateInfo :: struct {
    type : StructureType;
    next : *void;
    actionName : [64]u8;
    actionType : ActionType;
    countSubactionPaths : u32;
    subactionPaths : *Path;
    localizedActionName : [128]u8;
}

ActionSuggestedBinding :: struct {
    action : Action;
    binding : Path;
}

InteractionProfileSuggestedBinding :: struct {
    type : StructureType;
    next : *void;
    interactionProfile : Path;
    countSuggestedBindings : u32;
    suggestedBindings : *ActionSuggestedBinding;
}

SessionActionSetsAttachInfo :: struct {
    type : StructureType;
    next : *void;
    countActionSets : u32;
    actionSets : *ActionSet;
}

InteractionProfileState :: struct {
    type : StructureType;
    next : *void;
    interactionProfile : Path;
}

ActionStateGetInfo :: struct {
    type : StructureType;
    next : *void;
    action : Action;
    subactionPath : Path;
}

ActionStateBoolean :: struct {
    type : StructureType;
    next : *void;
    currentState : Bool32;
    changedSinceLastSync : Bool32;
    lastChangeTime : Time;
    isActive : Bool32;
}

ActionStateFloat :: struct {
    type : StructureType;
    next : *void;
    currentState : float32;
    changedSinceLastSync : Bool32;
    lastChangeTime : Time;
    isActive : Bool32;
}

Vector2f :: struct {
    x : float32;
    y : float32;
}

ActionStateVector2f :: struct {
    type : StructureType;
    next : *void;
    currentState : Vector2f;
    changedSinceLastSync : Bool32;
    lastChangeTime : Time;
    isActive : Bool32;
}

ActionStatePose :: struct {
    type : StructureType;
    next : *void;
    isActive : Bool32;
}

ActiveActionSet :: struct {
    actionSet : ActionSet;
    subactionPath : Path;
}

ActionsSyncInfo :: struct {
    type : StructureType;
    next : *void;
    countActiveActionSets : u32;
    activeActionSets : *ActiveActionSet;
}

BoundSourcesForActionEnumerateInfo :: struct {
    type : StructureType;
    next : *void;
    action : Action;
}

InputSourceLocalizedNameGetInfo :: struct {
    type : StructureType;
    next : *void;
    sourcePath : Path;
    whichComponents : InputSourceLocalizedNameFlags;
}

HapticActionInfo :: struct {
    type : StructureType;
    next : *void;
    action : Action;
    subactionPath : Path;
}

HapticBaseHeader :: struct {
    type : StructureType;
    next : *void;
}

BaseInStructure :: struct {
    type : StructureType;
    next : *BaseInStructure;
}

BaseOutStructure :: struct {
    type : StructureType;
    next : *BaseOutStructure;
}

Offset2Di :: struct {
    x : s32;
    y : s32;
}

Extent2Di :: struct {
    width : s32;
    height : s32;
}

Rect2Di :: struct {
    offset : Offset2Di;
    extent : Extent2Di;
}

SwapchainSubImage :: struct {
    swapchain : Swapchain;
    imageRect : Rect2Di;
    imageArrayIndex : u32;
}

CompositionLayerProjectionView :: struct {
    type : StructureType;
    next : *void;
    pose : Posef;
    fov : Fovf;
    subImage : SwapchainSubImage;
}

CompositionLayerProjection :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    viewCount : u32;
    views : *CompositionLayerProjectionView;
}

CompositionLayerQuad :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    eyeVisibility : EyeVisibility;
    subImage : SwapchainSubImage;
    pose : Posef;
    size : Extent2Df;
}

EventDataBaseHeader :: struct {
    type : StructureType;
    next : *void;
}

EventDataEventsLost :: struct {
    type : StructureType;
    next : *void;
    lostEventCount : u32;
}

EventDataInstanceLossPending :: struct {
    type : StructureType;
    next : *void;
    lossTime : Time;
}

EventDataSessionStateChanged :: struct {
    type : StructureType;
    next : *void;
    session : Session;
    state : SessionState;
    time : Time;
}

EventDataReferenceSpaceChangePending :: struct {
    type : StructureType;
    next : *void;
    session : Session;
    referenceSpaceType : ReferenceSpaceType;
    changeTime : Time;
    poseValid : Bool32;
    poseInPreviousSpace : Posef;
}

EventDataInteractionProfileChanged :: struct {
    type : StructureType;
    next : *void;
    session : Session;
}

HapticVibration :: struct {
    type : StructureType;
    next : *void;
    duration : Duration;
    frequency : float32;
    amplitude : float32;
}

Offset2Df :: struct {
    x : float32;
    y : float32;
}

Rect2Df :: struct {
    offset : Offset2Df;
    extent : Extent2Df;
}

Vector4f :: struct {
    x : float32;
    y : float32;
    z : float32;
    w : float32;
}

Color4f :: struct {
    r : float32;
    g : float32;
    b : float32;
    a : float32;
}

CompositionLayerCubeKHR :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    eyeVisibility : EyeVisibility;
    swapchain : Swapchain;
    imageArrayIndex : u32;
    orientation : Quaternionf;
}

CompositionLayerDepthInfoKHR :: struct {
    type : StructureType;
    next : *void;
    subImage : SwapchainSubImage;
    minDepth : float32;
    maxDepth : float32;
    nearZ : float32;
    farZ : float32;
}

CompositionLayerCylinderKHR :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    eyeVisibility : EyeVisibility;
    subImage : SwapchainSubImage;
    pose : Posef;
    radius : float32;
    centralAngle : float32;
    aspectRatio : float32;
}

CompositionLayerEquirectKHR :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    eyeVisibility : EyeVisibility;
    subImage : SwapchainSubImage;
    pose : Posef;
    radius : float32;
    scale : Vector2f;
    bias : Vector2f;
}

VisibilityMaskKHR :: struct {
    type : StructureType;
    next : *void;
    vertexCapacityInput : u32;
    vertexCountOutput : u32;
    vertices : *Vector2f;
    indexCapacityInput : u32;
    indexCountOutput : u32;
    indices : *u32;
}

EventDataVisibilityMaskChangedKHR :: struct {
    type : StructureType;
    next : *void;
    session : Session;
    viewConfigurationType : ViewConfigurationType;
    viewIndex : u32;
}

CompositionLayerColorScaleBiasKHR :: struct {
    type : StructureType;
    next : *void;
    colorScale : Color4f;
    colorBias : Color4f;
}

LoaderInitInfoBaseHeaderKHR :: struct {
    type : StructureType;
    next : *void;
}

CompositionLayerEquirect2KHR :: struct {
    type : StructureType;
    next : *void;
    layerFlags : CompositionLayerFlags;
    space : Space;
    eyeVisibility : EyeVisibility;
    subImage : SwapchainSubImage;
    pose : Posef;
    radius : float32;
    centralHorizontalAngle : float32;
    upperVerticalAngle : float32;
    lowerVerticalAngle : float32;
}

BindingModificationBaseHeaderKHR :: struct {
    type : StructureType;
    next : *void;
}

BindingModificationsKHR :: struct {
    type : StructureType;
    next : *void;
    bindingModificationCount : u32;
    bindingModifications : **BindingModificationBaseHeaderKHR;
}

EventDataPerfSettingsEXT :: struct {
    type : StructureType;
    next : *void;
    domain : PerfSettingsDomainEXT;
    subDomain : PerfSettingsSubDomainEXT;
    fromLevel : PerfSettingsNotificationLevelEXT;
    toLevel : PerfSettingsNotificationLevelEXT;
}

DebugUtilsObjectNameInfoEXT :: struct {
    type : StructureType;
    next : *void;
    objectType : ObjectType;
    objectHandle : u64;
    objectName : *u8;
}

DebugUtilsLabelEXT :: struct {
    type : StructureType;
    next : *void;
    labelName : *u8;
}

DebugUtilsMessengerCallbackDataEXT :: struct {
    type : StructureType;
    next : *void;
    messageId : *u8;
    functionName : *u8;
    message : *u8;
    objectCount : u32;
    objects : *DebugUtilsObjectNameInfoEXT;
    sessionLabelCount : u32;
    sessionLabels : *DebugUtilsLabelEXT;
}

DebugUtilsMessengerCreateInfoEXT :: struct {
    type : StructureType;
    next : *void;
    messageSeverities : DebugUtilsMessageSeverityFlagsEXT;
    messageTypes : DebugUtilsMessageTypeFlagsEXT;
    userCallback : PFN_DebugUtilsMessengerCallbackEXT;
    userData : *void;
}

SystemEyeGazeInteractionPropertiesEXT :: struct {
    type : StructureType;
    next : *void;
    supportsEyeGazeInteraction : Bool32;
}

EyeGazeSampleTimeEXT :: struct {
    type : StructureType;
    next : *void;
    time : Time;
}

SessionCreateInfoOverlayEXTX :: struct {
    type : StructureType;
    next : *void;
    createFlags : OverlaySessionCreateFlagsEXTX;
    sessionLayersPlacement : u32;
}

EventDataMainSessionVisibilityChangedEXTX :: struct {
    type : StructureType;
    next : *void;
    visible : Bool32;
    flags : OverlayMainSessionFlagsEXTX;
}

SpatialAnchorCreateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    space : Space;
    pose : Posef;
    time : Time;
}

SpatialAnchorSpaceCreateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    anchor : SpatialAnchorMSFT;
    poseInAnchorSpace : Posef;
}

ViewConfigurationDepthRangeEXT :: struct {
    type : StructureType;
    next : *void;
    recommendedNearZ : float32;
    minNearZ : float32;
    recommendedFarZ : float32;
    maxFarZ : float32;
}

SpatialGraphNodeSpaceCreateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    nodeType : SpatialGraphNodeTypeMSFT;
    nodeId : [16]u8;
    pose : Posef;
}

SystemHandTrackingPropertiesEXT :: struct {
    type : StructureType;
    next : *void;
    supportsHandTracking : Bool32;
}

HandTrackerCreateInfoEXT :: struct {
    type : StructureType;
    next : *void;
    hand : HandEXT;
    handJointSet : HandJointSetEXT;
}

HandJointsLocateInfoEXT :: struct {
    type : StructureType;
    next : *void;
    baseSpace : Space;
    time : Time;
}

HandJointLocationEXT :: struct {
    locationFlags : SpaceLocationFlags;
    pose : Posef;
    radius : float32;
}

HandJointVelocityEXT :: struct {
    velocityFlags : SpaceVelocityFlags;
    linearVelocity : Vector3f;
    angularVelocity : Vector3f;
}

HandJointLocationsEXT :: struct {
    type : StructureType;
    next : *void;
    isActive : Bool32;
    jointCount : u32;
    jointLocations : *HandJointLocationEXT;
}

HandJointVelocitiesEXT :: struct {
    type : StructureType;
    next : *void;
    jointCount : u32;
    jointVelocities : *HandJointVelocityEXT;
}

SystemHandTrackingMeshPropertiesMSFT :: struct {
    type : StructureType;
    next : *void;
    supportsHandTrackingMesh : Bool32;
    maxHandMeshIndexCount : u32;
    maxHandMeshVertexCount : u32;
}

HandMeshSpaceCreateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    handPoseType : HandPoseTypeMSFT;
    poseInHandMeshSpace : Posef;
}

HandMeshUpdateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    time : Time;
    handPoseType : HandPoseTypeMSFT;
}

HandMeshIndexBufferMSFT :: struct {
    indexBufferKey : u32;
    indexCapacityInput : u32;
    indexCountOutput : u32;
    indices : *u32;
}

HandMeshVertexMSFT :: struct {
    position : Vector3f;
    normal : Vector3f;
}

HandMeshVertexBufferMSFT :: struct {
    vertexUpdateTime : Time;
    vertexCapacityInput : u32;
    vertexCountOutput : u32;
    vertices : *HandMeshVertexMSFT;
}

HandMeshMSFT :: struct {
    type : StructureType;
    next : *void;
    isActive : Bool32;
    indexBufferChanged : Bool32;
    vertexBufferChanged : Bool32;
    indexBuffer : HandMeshIndexBufferMSFT;
    vertexBuffer : HandMeshVertexBufferMSFT;
}

HandPoseTypeInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    handPoseType : HandPoseTypeMSFT;
}

SecondaryViewConfigurationSessionBeginInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationCount : u32;
    enabledViewConfigurationTypes : *ViewConfigurationType;
}

SecondaryViewConfigurationStateMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationType : ViewConfigurationType;
    active : Bool32;
}

SecondaryViewConfigurationFrameStateMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationCount : u32;
    viewConfigurationStates : *SecondaryViewConfigurationStateMSFT;
}

SecondaryViewConfigurationLayerInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationType : ViewConfigurationType;
    environmentBlendMode : EnvironmentBlendMode;
    layerCount : u32;
    layers : **CompositionLayerBaseHeader;
}

SecondaryViewConfigurationFrameEndInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationCount : u32;
    viewConfigurationLayersInfo : *SecondaryViewConfigurationLayerInfoMSFT;
}

SecondaryViewConfigurationSwapchainCreateInfoMSFT :: struct {
    type : StructureType;
    next : *void;
    viewConfigurationType : ViewConfigurationType;
}

ControllerModelKeyStateMSFT :: struct {
    type : StructureType;
    next : *void;
    modelKey : ControllerModelKeyMSFT;
}

ControllerModelNodePropertiesMSFT :: struct {
    type : StructureType;
    next : *void;
    parentNodeName : [64]u8;
    nodeName : [64]u8;
}

ControllerModelPropertiesMSFT :: struct {
    type : StructureType;
    next : *void;
    nodeCapacityInput : u32;
    nodeCountOutput : u32;
    nodeProperties : *ControllerModelNodePropertiesMSFT;
}

ControllerModelNodeStateMSFT :: struct {
    type : StructureType;
    next : *void;
    nodePose : Posef;
}

ControllerModelStateMSFT :: struct {
    type : StructureType;
    next : *void;
    nodeCapacityInput : u32;
    nodeCountOutput : u32;
    nodeStates : *ControllerModelNodeStateMSFT;
}

ViewConfigurationViewFovEPIC :: struct {
    type : StructureType;
    next : *void;
    recommendedFov : Fovf;
    maxMutableFov : Fovf;
}

InteractionProfileAnalogThresholdVALVE :: struct {
    type : StructureType;
    next : *void;
    action : Action;
    binding : Path;
    onThreshold : float32;
    offThreshold : float32;
    onHaptic : *HapticBaseHeader;
    offHaptic : *HapticBaseHeader;
}

HandJointsMotionRangeInfoEXT :: struct {
    type : StructureType;
    next : *void;
    handJointsMotionRange : HandJointsMotionRangeEXT;
}

EventDataDisplayRefreshRateChangedFB :: struct {
    type : StructureType;
    next : *void;
    fromDisplayRefreshRate : float32;
    toDisplayRefreshRate : float32;
}

SystemColorSpacePropertiesFB :: struct {
    type : StructureType;
    next : *void;
    colorSpace : ColorSpaceFB;
}

ViewLocateFoveatedRenderingVARJO :: struct {
    type : StructureType;
    next : *void;
    foveatedRenderingActive : Bool32;
}

FoveatedViewConfigurationViewVARJO :: struct {
    type : StructureType;
    next : *void;
    foveatedRenderingActive : Bool32;
}

SystemFoveatedRenderingPropertiesVARJO :: struct {
    type : StructureType;
    next : *void;
    supportsFoveatedRendering : Bool32;
}

CompositionLayerDepthTestVARJO :: struct {
    type : StructureType;
    next : *void;
    depthTestRangeNearZ : float32;
    depthTestRangeFarZ : float32;
}

VulkanSwapchainFormatListCreateInfoKHR :: struct {
    type : StructureType;
    next : *void;
    viewFormatCount : u32;
    viewFormats : *void;
}

GraphicsBindingVulkanKHR :: struct {
    type : StructureType;
    next : *void;
    instance : *void; // VkInstance;
    physicalDevice : *void; // VkPhysicalDevice;
    device : *void; // VkDevice;
    queueFamilyIndex : u32;
    queueIndex : u32;
}

SwapchainImageVulkanKHR :: struct {
    type : StructureType;
    next : *void;
    image : *void; // VkImage;
}

GraphicsRequirementsVulkanKHR :: struct {
    type : StructureType;
    next : *void;
    minApiVersionSupported : Version;
    maxApiVersionSupported : Version;
}

get_instance_proc_addr :: (
    instance : Instance,
    name : *u8,
    function : *PFN_VoidFunction
) -> Result #foreign libopenxr "xrGetInstanceProcAddr";

enumerate_api_layer_properties :: (
    propertyCapacityInput : u32,
    propertyCountOutput : *u32,
    properties : *ApiLayerProperties
) -> Result #foreign libopenxr "xrEnumerateApiLayerProperties";

enumerate_instance_extension_properties :: (
    layerName : *u8,
    propertyCapacityInput : u32,
    propertyCountOutput : *u32,
    properties : *ExtensionProperties
) -> Result #foreign libopenxr "xrEnumerateInstanceExtensionProperties";

create_instance :: (
    createInfo : *InstanceCreateInfo,
    instance : *Instance
) -> Result #foreign libopenxr "xrCreateInstance";

destroy_instance :: (instance : Instance) -> Result #foreign libopenxr "xrDestroyInstance";

get_instance_properties :: (
    instance : Instance,
    instanceProperties : *InstanceProperties
) -> Result #foreign libopenxr "xrGetInstanceProperties";

poll_event :: (
    instance : Instance,
    eventData : *EventDataBuffer
) -> Result #foreign libopenxr "xrPollEvent";

result_to_string :: (
    instance : Instance,
    value : Result,
    buffer : *u8 // [64]u8
) -> Result #foreign libopenxr "xrResultToString";

structure_type_to_string :: (
    instance : Instance,
    value : StructureType,
    buffer : *u8 // [64]u8
) -> Result #foreign libopenxr "xrStructureTypeToString";

get_system :: (
    instance : Instance,
    getInfo : *SystemGetInfo,
    systemId : *SystemId
) -> Result #foreign libopenxr "xrGetSystem";

get_system_properties :: (
    instance : Instance,
    systemId : SystemId,
    properties : *SystemProperties
) -> Result #foreign libopenxr "xrGetSystemProperties";

enumerate_environment_blend_modes :: (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    environmentBlendModeCapacityInput : u32,
    environmentBlendModeCountOutput : *u32,
    environmentBlendModes : *EnvironmentBlendMode
) -> Result #foreign libopenxr "xrEnumerateEnvironmentBlendModes";

create_session :: (
    instance : Instance,
    createInfo : *SessionCreateInfo,
    session : *Session
) -> Result #foreign libopenxr "xrCreateSession";

destroy_session :: (session : Session) -> Result #foreign libopenxr "xrDestroySession";

enumerate_reference_spaces :: (
    session : Session,
    spaceCapacityInput : u32,
    spaceCountOutput : *u32,
    spaces : *ReferenceSpaceType
) -> Result #foreign libopenxr "xrEnumerateReferenceSpaces";

create_reference_space :: (
    session : Session,
    createInfo : *ReferenceSpaceCreateInfo,
    space : *Space
) -> Result #foreign libopenxr "xrCreateReferenceSpace";

get_reference_space_bounds_rect :: (
    session : Session,
    referenceSpaceType : ReferenceSpaceType,
    bounds : *Extent2Df
) -> Result #foreign libopenxr "xrGetReferenceSpaceBoundsRect";

create_action_space :: (
    session : Session,
    createInfo : *ActionSpaceCreateInfo,
    space : *Space
) -> Result #foreign libopenxr "xrCreateActionSpace";

locate_space :: (
    space : Space,
    baseSpace : Space,
    time : Time,
    location : *SpaceLocation
) -> Result #foreign libopenxr "xrLocateSpace";

destroy_space :: (space : Space) -> Result #foreign libopenxr "xrDestroySpace";

enumerate_view_configurations :: (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationTypeCapacityInput : u32,
    viewConfigurationTypeCountOutput : *u32,
    viewConfigurationTypes : *ViewConfigurationType
) -> Result #foreign libopenxr "xrEnumerateViewConfigurations";

get_view_configuration_properties :: (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    configurationProperties : *ViewConfigurationProperties
) -> Result #foreign libopenxr "xrGetViewConfigurationProperties";

enumerate_view_configuration_views :: (
    instance : Instance,
    systemId : SystemId,
    viewConfigurationType : ViewConfigurationType,
    viewCapacityInput : u32,
    viewCountOutput : *u32,
    views : *ViewConfigurationView
) -> Result #foreign libopenxr "xrEnumerateViewConfigurationViews";

enumerate_swapchain_formats :: (
    session : Session,
    formatCapacityInput : u32,
    formatCountOutput : *u32,
    formats : *s64
) -> Result #foreign libopenxr "xrEnumerateSwapchainFormats";

create_swapchain :: (
    session : Session,
    createInfo : *SwapchainCreateInfo,
    swapchain : *Swapchain
) -> Result #foreign libopenxr "xrCreateSwapchain";

destroy_swapchain :: (swapchain : Swapchain) -> Result #foreign libopenxr "xrDestroySwapchain";

enumerate_swapchain_images :: (
    swapchain : Swapchain,
    imageCapacityInput : u32,
    imageCountOutput : *u32,
    images : *SwapchainImageBaseHeader
) -> Result #foreign libopenxr "xrEnumerateSwapchainImages";

acquire_swapchain_image :: (
    swapchain : Swapchain,
    acquireInfo : *SwapchainImageAcquireInfo,
    index : *u32
) -> Result #foreign libopenxr "xrAcquireSwapchainImage";

wait_swapchain_image :: (
    swapchain : Swapchain,
    waitInfo : *SwapchainImageWaitInfo
) -> Result #foreign libopenxr "xrWaitSwapchainImage";

release_swapchain_image :: (
    swapchain : Swapchain,
    releaseInfo : *SwapchainImageReleaseInfo
) -> Result #foreign libopenxr "xrReleaseSwapchainImage";

begin_session :: (
    session : Session,
    beginInfo : *SessionBeginInfo
) -> Result #foreign libopenxr "xrBeginSession";

end_session :: (session : Session) -> Result #foreign libopenxr "xrEndSession";

request_exit_session :: (session : Session) -> Result #foreign libopenxr "xrRequestExitSession";

wait_frame :: (
    session : Session,
    frameWaitInfo : *FrameWaitInfo,
    frameState : *FrameState
) -> Result #foreign libopenxr "xrWaitFrame";

begin_frame :: (
    session : Session,
    frameBeginInfo : *FrameBeginInfo
) -> Result #foreign libopenxr "xrBeginFrame";

end_frame :: (
    session : Session,
    frameEndInfo : *FrameEndInfo
) -> Result #foreign libopenxr "xrEndFrame";

locate_views :: (
    session : Session,
    viewLocateInfo : *ViewLocateInfo,
    viewState : *ViewState,
    viewCapacityInput : u32,
    viewCountOutput : *u32,
    views : *View
) -> Result #foreign libopenxr "xrLocateViews";

string_to_path :: (
    instance : Instance,
    pathString : *u8,
    path : *Path
) -> Result #foreign libopenxr "xrStringToPath";

path_to_string :: (
    instance : Instance,
    path : Path,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #foreign libopenxr "xrPathToString";

create_action_set :: (
    instance : Instance,
    createInfo : *ActionSetCreateInfo,
    actionSet : *ActionSet
) -> Result #foreign libopenxr "xrCreateActionSet";

destroy_action_set :: (actionSet : ActionSet) -> Result #foreign libopenxr "xrDestroyActionSet";

create_action :: (
    actionSet : ActionSet,
    createInfo : *ActionCreateInfo,
    action : *Action
) -> Result #foreign libopenxr "xrCreateAction";

destroy_action :: (action : Action) -> Result #foreign libopenxr "xrDestroyAction";

suggest_interaction_profile_bindings :: (
    instance : Instance,
    suggestedBindings : *InteractionProfileSuggestedBinding
) -> Result #foreign libopenxr "xrSuggestInteractionProfileBindings";

attach_session_action_sets :: (
    session : Session,
    attachInfo : *SessionActionSetsAttachInfo
) -> Result #foreign libopenxr "xrAttachSessionActionSets";

get_current_interaction_profile :: (
    session : Session,
    topLevelUserPath : Path,
    interactionProfile : *InteractionProfileState
) -> Result #foreign libopenxr "xrGetCurrentInteractionProfile";

get_action_state_boolean :: (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateBoolean
) -> Result #foreign libopenxr "xrGetActionStateBoolean";

get_action_state_float :: (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateFloat
) -> Result #foreign libopenxr "xrGetActionStateFloat";

get_action_state_vector2f :: (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStateVector2f
) -> Result #foreign libopenxr "xrGetActionStateVector2f";

get_action_state_pose :: (
    session : Session,
    getInfo : *ActionStateGetInfo,
    state : *ActionStatePose
) -> Result #foreign libopenxr "xrGetActionStatePose";

sync_actions :: (
    session : Session,
    syncInfo : *ActionsSyncInfo
) -> Result #foreign libopenxr "xrSyncActions";

enumerate_bound_sources_for_action :: (
    session : Session,
    enumerateInfo : *BoundSourcesForActionEnumerateInfo,
    sourceCapacityInput : u32,
    sourceCountOutput : *u32,
    sources : *Path
) -> Result #foreign libopenxr "xrEnumerateBoundSourcesForAction";

get_input_source_localized_name :: (
    session : Session,
    getInfo : *InputSourceLocalizedNameGetInfo,
    bufferCapacityInput : u32,
    bufferCountOutput : *u32,
    buffer : *u8
) -> Result #foreign libopenxr "xrGetInputSourceLocalizedName";

apply_haptic_feedback :: (
    session : Session,
    hapticActionInfo : *HapticActionInfo,
    hapticFeedback : *HapticBaseHeader
) -> Result #foreign libopenxr "xrApplyHapticFeedback";

stop_haptic_feedback :: (
    session : Session,
    hapticActionInfo : *HapticActionInfo
) -> Result #foreign libopenxr "xrStopHapticFeedback";

get_vulkan_instance_extensions_khr : PFN_GetVulkanInstanceExtensionsKHR;
get_vulkan_device_extensions_khr : PFN_GetVulkanDeviceExtensionsKHR;
get_vulkan_graphics_requirements_khr : PFN_GetVulkanGraphicsRequirementsKHR;
get_vulkan_graphics_device_khr : PFN_GetVulkanGraphicsDeviceKHR;

create_debug_utils_messenger_ext : PFN_CreateDebugUtilsMessengerEXT;
destroy_debug_utils_messenger_ext : PFN_DestroyDebugUtilsMessengerEXT;
