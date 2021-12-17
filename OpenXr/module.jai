
#load "openxr.jai";

load_instance_proc :: (instance : Instance, proc : *$F, name : string) {
    if (<<proc) != null then return;
    get_instance_proc_addr(instance, name.data, cast(*void) proc);

    if (<<proc) == null {
        context.logger("Could load instance proc.\n", null, .{common_flags=Log_Flags.ERROR});
    }
}

array_fill_stype :: inline (array : *[]$T, f : $F, sType : StructureType) {
    count : u32;
    f(0, *count, null);

    if count > 0 {
        Basic.array_resize(array, count);
        for *e : <<array {
            e.type = sType;
        }
        f(count, *count, xx *(<<array)[0]);
    }
}

array_fill_stype :: inline (array : *[]$T, f : $F, arg1 : $T1, sType : StructureType) {
    count : u32;
    f(arg1, 0, *count, null);

    if count > 0 {
        Basic.array_resize(array, count);
        for *e : <<array {
            e.type = sType;
        }
        f(arg1, count, *count, xx *(<<array)[0]);
    }
}

array_fill_stype :: inline (array : *[]$T, f : $F, arg1 : $T1, arg2 : $T2, arg3 : $T3, sType : StructureType) {
    count : u32;
    f(arg1, arg2, arg3, 0, *count, null);

    if count > 0 {
        Basic.array_resize(array, count);
        for *e : <<array {
            e.type = sType;
        }
        f(arg1, arg2, arg3, count, *count, xx *(<<array)[0]);
    }
}

array_fill_stype :: inline (array : [$N]$T, f : $F, arg1 : $T1, arg2 : $T2, arg3 : $T3, sType : StructureType) {
    for *e : array {
        e.type = sType;
    }
    count : u32;
    f(arg1, arg2, arg3, array.count, *count, xx *array[0]);
    Basic.assert(array.count == count);
}

array_fill :: inline (array : *[]$T, f : $F, arg1 : $T1) {
    count : u32;
    f(arg1, 0, *count, null);

    Basic.array_resize(array, count);
    f(arg1, count, *count, *(<<array)[0]);
}

array_fill :: inline (array : *[]$T, f : $F, arg1 : $T1, arg2 : $T2) {
    count : u32;
    f(arg1, arg2, 0, *count, null);

    Basic.array_resize(array, count);
    f(arg1, arg2, count, *count, *(<<array)[0]);
}

array_fill :: inline (array : *[]$T, f : $F, arg1 : $T1, arg2 : $T2, arg3 : $T3) {
    count : u32;
    f(arg1, arg2, arg3, 0, *count, null);

    Basic.array_resize(array, count);
    f(arg1, arg2, arg3, count, *count, *(<<array)[0]);
}

#scope_file

Basic :: #import "Basic";
