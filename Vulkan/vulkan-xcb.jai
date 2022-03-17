KHR_XCB_SURFACE :: 1;
KHR_XCB_SURFACE_SPEC_VERSION :: 6;
KHR_XCB_SURFACE_EXTENSION_NAME :: "VK_KHR_xcb_surface";

XcbSurfaceCreateFlagsKHR :: Flags;
PFN_CreateXcbSurfaceKHR :: #type ();
PFN_GetPhysicalDeviceXcbPresentationSupportKHR :: #type ();

XcbSurfaceCreateInfoKHR :: struct {
    sType : StructureType;
    pNext : *void;
    flags : XcbSurfaceCreateFlagsKHR;
    connection : *void;
    window : u32;
}

create_xcb_surface_khr :: (
    instance : Instance,
    pCreateInfo : *XcbSurfaceCreateInfoKHR,
    pAllocator : *void,
    pSurface : *void
) -> Result #foreign libvulkan "vkCreateXcbSurfaceKHR";

get_physical_device_xcb_presentation_support_khr :: (
    physicalDevice : PhysicalDevice,
    queueFamilyIndex : u32,
    connection : *void,
    visual_id : u32
) -> Bool32 #foreign libvulkan "vkGetPhysicalDeviceXcbPresentationSupportKHR";

