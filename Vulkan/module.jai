libvulkan :: #foreign_library "libvulkan";

Basic :: #import "Basic";

#load "vulkan-core.jai";

#if OS == .LINUX {
    #load "vulkan-xcb.jai";
}

// Helpers

array_fill :: inline (array : *[]$T, f : $F) {
    count : u32;
    f(*count, null);
    Basic.array_resize(array, count);
    f(*count, *(<<array)[0]);
}

array_fill :: inline (array : *[]$T, f : $F, arg1 : $T1) {
    count : u32;
    f(arg1, *count, null);
    Basic.array_resize(array, count);
    f(arg1, *count, *(<<array)[0]);
}

array_fill :: inline (array : *[]$T, f : $F, arg1 : $T1, arg2 : $T2) {
    count : u32;
    f(arg1, arg2, *count, null);
    Basic.array_resize(array, count);
    f(arg1, arg2, *count, *(<<array)[0]);
}

load_instance_proc :: (instance : Instance, proc : *$F, name : string) {
    if (<<proc) != null then return;
    (<<proc) = cast(type_of(<<proc)) get_instance_proc_addr(instance, name.data);

    if (<<proc) == null {
        Basic.log("Could load instance proc %.", name, flags=.ERROR);
    }
}

load_device_proc :: (device : Device, proc : *$F, name : string) {
    if (<<proc) != null then return;
    (<<proc) = cast(type_of(<<proc)) get_device_proc_addr(device, name.data);

    if (<<proc) == null {
        Basic.log("Could load device proc %.", name, flags=.ERROR);
    }
}
