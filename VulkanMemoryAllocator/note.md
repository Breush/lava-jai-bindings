Compiled with:

```bash
g++ vma.cpp -c -fPIC -O3 -o libvma.o -D VK_VERSION_1_3
g++ libvma.o -shared -o libvma.so
patchelf --set-soname libvma.so libvma.so
```

## On Windows with MinGW64

```bash
g++ vma.cpp -c -fPIC -O3 -shared -o libvma.dll -D VK_VERSION_1_3
gendef libvma.dll
dlltool -m i386:x86-64 -d libvma.def libvma.lib
```
