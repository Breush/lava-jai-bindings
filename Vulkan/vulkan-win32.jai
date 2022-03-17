KHR_WIN32_SURFACE :: 1;
KHR_WIN32_SURFACE_SPEC_VERSION :: 6;
KHR_WIN32_SURFACE_EXTENSION_NAME :: "VK_KHR_win32_surface";

Win32SurfaceCreateFlagsKHR :: Flags;
PFN_CreateWin32SurfaceKHR :: #type ();
PFN_GetPhysicalDeviceWin32PresentationSupportKHR :: #type ();

Win32SurfaceCreateInfoKHR :: struct {
    sType : StructureType;
    pNext : *void;
    flags : Win32SurfaceCreateFlagsKHR;
    hinstance : Windows.HINSTANCE;
    hwnd : Windows.HWND;
}

create_win32_surface_khr :: (
    instance : Instance,
    pCreateInfo : *Win32SurfaceCreateInfoKHR,
    pAllocator : *void,
    pSurface : *void
) -> Result #foreign libvulkan "vkCreateWin32SurfaceKHR";

get_physical_device_Win32_presentation_support_khr :: (
    physicalDevice : PhysicalDevice,
    queueFamilyIndex : u32
) -> Bool32 #foreign libvulkan "vkGetPhysicalDeviceWin32PresentationSupportKHR";

#scope_file

Windows :: #import "Windows";
