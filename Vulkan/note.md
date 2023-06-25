Loader has been compiled from https://github.com/KhronosGroup/Vulkan-Loader/releases/tag/sdk-1.3.243.0
in RelWithDebInfo mode.

On Linux, debug symbols have been separated to another file:
```bash
objcopy --only-keep-debug libvulkan.so libvulkan.dbg
objcopy --strip-debug libvulkan.so
objcopy --add-gnu-debuglink=libvulkan.dbg libvulkan.so
```
