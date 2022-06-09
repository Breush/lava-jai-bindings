Compiled with:

```bash
gcc libstbtruetype.c -c -fPIC -o libstbtruetype.o
gcc libstbtruetype.o -shared -o libstbtruetype.so
patchelf --set-soname libstbtruetype.so libstbtruetype.so
```
