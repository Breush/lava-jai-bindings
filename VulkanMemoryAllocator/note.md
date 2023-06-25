Compiled with:

```bash
g++ vma.cpp -c -fPIC -O3 -o libvma.o
g++ libvma.o -shared -o libvma.so
patchelf --set-soname libvma.so libvma.so
```

## On Windows with MinGW64

```bash
g++ vma.cpp -c -fPIC -O3 -shared -o libvma.dll
gendef libvma.dll
dlltool -m i386:x86-64 -d libvma.def libvma.lib
```
