libstbtruetype :: #library "libstbtruetype";

AnonymousEnum0 :: enum s32 {
    Vmove :: 1;
    Vline;
    Vcurve;
    Vcubic;
}

AnonymousEnum1 :: enum s32 {
    PlatformIdUnicode :: 0;
    PlatformIdMac :: 1;
    PlatformIdIso :: 2;
    PlatformIdMicrosoft :: 3;
}

AnonymousEnum2 :: enum s32 {
    UnicodeEidUnicode1_0 :: 0;
    UnicodeEidUnicode1_1 :: 1;
    UnicodeEidIso10646 :: 2;
    UnicodeEidUnicode2_0Bmp :: 3;
    UnicodeEidUnicode2_0Full :: 4;
}

AnonymousEnum3 :: enum s32 {
    MsEidSymbol :: 0;
    MsEidUnicodeBmp :: 1;
    MsEidShiftjis :: 2;
    MsEidUnicodeFull :: 10;
}

AnonymousEnum4 :: enum s32 {
    MacEidRoman :: 0;
    MacEidArabic :: 4;
    MacEidJapanese :: 1;
    MacEidHebrew :: 5;
    MacEidChineseTrad :: 2;
    MacEidGreek :: 6;
    MacEidKorean :: 3;
    MacEidRussian :: 7;
}

AnonymousEnum5 :: enum s32 {
    MsLangEnglish :: 1033;
    MsLangItalian :: 1040;
    MsLangChinese :: 2052;
    MsLangJapanese :: 1041;
    MsLangDutch :: 1043;
    MsLangKorean :: 1042;
    MsLangFrench :: 1036;
    MsLangRussian :: 1049;
    MsLangGerman :: 1031;
    MsLangSpanish :: 1033;
    MsLangHebrew :: 1037;
    MsLangSwedish :: 1053;
}

AnonymousEnum6 :: enum s32 {
    MacLangEnglish :: 0;
    MacLangJapanese :: 11;
    MacLangArabic :: 12;
    MacLangKorean :: 23;
    MacLangDutch :: 4;
    MacLangRussian :: 32;
    MacLangFrench :: 1;
    MacLangSpanish :: 6;
    MacLangGerman :: 2;
    MacLangSwedish :: 5;
    MacLangHebrew :: 10;
    MacLangChineseSimplified :: 33;
    MacLangItalian :: 3;
    MacLangChineseTrad :: 19;
}

Buf :: struct {
    data : *u8;
    cursor : s32;
    size : s32;
}

Bakedchar :: struct {
    x0 : u16;
    y0 : u16;
    x1 : u16;
    y1 : u16;
    xoff : float32;
    yoff : float32;
    xadvance : float32;
}

AlignedQuad :: struct {
    x0 : float32;
    y0 : float32;
    s0 : float32;
    t0 : float32;
    x1 : float32;
    y1 : float32;
    s1 : float32;
    t1 : float32;
}

Packedchar :: struct {
    x0 : u16;
    y0 : u16;
    x1 : u16;
    y1 : u16;
    xoff : float32;
    yoff : float32;
    xadvance : float32;
    xoff2 : float32;
    yoff2 : float32;
}

PackContext :: struct {
    userAllocatorContext : *void;
    packInfo : *void;
    width : s32;
    height : s32;
    strideInBytes : s32;
    padding : s32;
    skipMissing : s32;
    h_oversample : u32;
    v_oversample : u32;
    pixels : *u8;
    nodes : *void;
}

Fontinfo :: struct {
    userdata : *void;
    data : *u8;
    fontstart : s32;
    numGlyphs : s32;
    loca : s32;
    head : s32;
    glyf : s32;
    hhea : s32;
    hmtx : s32;
    kern : s32;
    gpos : s32;
    svg : s32;
    indexMap : s32;
    indexToLocFormat : s32;
    cff : Buf;
    charstrings : Buf;
    gsubrs : Buf;
    subrs : Buf;
    fontdicts : Buf;
    fdselect : Buf;
}

StbrpRect :: struct {}

PackRange :: struct {
    fontSize : float32;
    firstUnicodeCodepointInRange : s32;
    arrayOfUnicodeCodepoints : *s32;
    numChars : s32;
    chardataForRange : *Packedchar;
    h_oversample : u8;
    v_oversample : u8;
}

Kerningentry :: struct {
    glyph1 : s32;
    glyph2 : s32;
    advance : s32;
}

Vertex :: struct {
    x : s16;
    y : s16;
    cx : s16;
    cy : s16;
    cx1 : s16;
    cy1 : s16;
    type : u8;
    padding : u8;
}

Bitmap :: struct {
    w : s32;
    h : s32;
    stride : s32;
    pixels : *u8;
}

bake_font_bitmap :: (
    data : *u8,
    offset : s32,
    pixelHeight : float32,
    pixels : *u8,
    pw : s32,
    ph : s32,
    firstChar : s32,
    numChars : s32,
    chardata : *Bakedchar
) -> s32 #foreign libstbtruetype "stbtt_BakeFontBitmap";

get_baked_quad :: (
    chardata : *Bakedchar,
    pw : s32,
    ph : s32,
    charIndex : s32,
    xpos : *float32,
    ypos : *float32,
    q : *AlignedQuad,
    openglFillrule : s32
) -> void #foreign libstbtruetype "stbtt_GetBakedQuad";

get_scaled_font_v_metrics :: (
    fontdata : *u8,
    index : s32,
    size : float32,
    ascent : *float32,
    descent : *float32,
    lineGap : *float32
) -> void #foreign libstbtruetype "stbtt_GetScaledFontVMetrics";

pack_begin :: (
    spc : *PackContext,
    pixels : *u8,
    width : s32,
    height : s32,
    strideInBytes : s32,
    padding : s32,
    allocContext : *void
) -> s32 #foreign libstbtruetype "stbtt_PackBegin";

pack_end :: (spc : *PackContext) -> void #foreign libstbtruetype "stbtt_PackEnd";

pack_font_range :: (
    spc : *PackContext,
    fontdata : *u8,
    fontIndex : s32,
    fontSize : float32,
    firstUnicodeCharInRange : s32,
    numCharsInRange : s32,
    chardataForRange : *Packedchar
) -> s32 #foreign libstbtruetype "stbtt_PackFontRange";

pack_font_ranges :: (
    spc : *PackContext,
    fontdata : *u8,
    fontIndex : s32,
    ranges : *PackRange,
    numRanges : s32
) -> s32 #foreign libstbtruetype "stbtt_PackFontRanges";

pack_set_oversampling :: (
    spc : *PackContext,
    h_oversample : u32,
    v_oversample : u32
) -> void #foreign libstbtruetype "stbtt_PackSetOversampling";

pack_set_skip_missing_codepoints :: (
    spc : *PackContext,
    skip : s32
) -> void #foreign libstbtruetype "stbtt_PackSetSkipMissingCodepoints";

get_packed_quad :: (
    chardata : *Packedchar,
    pw : s32,
    ph : s32,
    charIndex : s32,
    xpos : *float32,
    ypos : *float32,
    q : *AlignedQuad,
    alignToInteger : s32
) -> void #foreign libstbtruetype "stbtt_GetPackedQuad";

pack_font_ranges_gather_rects :: (
    spc : *PackContext,
    info : *Fontinfo,
    ranges : *PackRange,
    numRanges : s32,
    rects : *StbrpRect
) -> s32 #foreign libstbtruetype "stbtt_PackFontRangesGatherRects";

pack_font_ranges_pack_rects :: (
    spc : *PackContext,
    rects : *StbrpRect,
    numRects : s32
) -> void #foreign libstbtruetype "stbtt_PackFontRangesPackRects";

pack_font_ranges_render_into_rects :: (
    spc : *PackContext,
    info : *Fontinfo,
    ranges : *PackRange,
    numRanges : s32,
    rects : *StbrpRect
) -> s32 #foreign libstbtruetype "stbtt_PackFontRangesRenderIntoRects";

get_number_of_fonts :: (data : *u8) -> s32 #foreign libstbtruetype "stbtt_GetNumberOfFonts";

get_font_offset_for_index :: (
    data : *u8,
    index : s32
) -> s32 #foreign libstbtruetype "stbtt_GetFontOffsetForIndex";

init_font :: (
    info : *Fontinfo,
    data : *u8,
    offset : s32
) -> s32 #foreign libstbtruetype "stbtt_InitFont";

find_glyph_index :: (
    info : *Fontinfo,
    unicodeCodepoint : s32
) -> s32 #foreign libstbtruetype "stbtt_FindGlyphIndex";

scale_for_pixel_height :: (
    info : *Fontinfo,
    pixels : float32
) -> float32 #foreign libstbtruetype "stbtt_ScaleForPixelHeight";

scale_for_mapping_em_to_pixels :: (
    info : *Fontinfo,
    pixels : float32
) -> float32 #foreign libstbtruetype "stbtt_ScaleForMappingEmToPixels";

get_font_v_metrics :: (
    info : *Fontinfo,
    ascent : *s32,
    descent : *s32,
    lineGap : *s32
) -> void #foreign libstbtruetype "stbtt_GetFontVMetrics";

get_font_v_metrics_o_s2 :: (
    info : *Fontinfo,
    typoAscent : *s32,
    typoDescent : *s32,
    typoLineGap : *s32
) -> s32 #foreign libstbtruetype "stbtt_GetFontVMetricsOS2";

get_font_bounding_box :: (
    info : *Fontinfo,
    x0 : *s32,
    y0 : *s32,
    x1 : *s32,
    y1 : *s32
) -> void #foreign libstbtruetype "stbtt_GetFontBoundingBox";

get_codepoint_h_metrics :: (
    info : *Fontinfo,
    codepoint : s32,
    advanceWidth : *s32,
    leftSideBearing : *s32
) -> void #foreign libstbtruetype "stbtt_GetCodepointHMetrics";

get_codepoint_kern_advance :: (
    info : *Fontinfo,
    ch1 : s32,
    ch2 : s32
) -> s32 #foreign libstbtruetype "stbtt_GetCodepointKernAdvance";

get_codepoint_box :: (
    info : *Fontinfo,
    codepoint : s32,
    x0 : *s32,
    y0 : *s32,
    x1 : *s32,
    y1 : *s32
) -> s32 #foreign libstbtruetype "stbtt_GetCodepointBox";

get_glyph_h_metrics :: (
    info : *Fontinfo,
    glyphIndex : s32,
    advanceWidth : *s32,
    leftSideBearing : *s32
) -> void #foreign libstbtruetype "stbtt_GetGlyphHMetrics";

get_glyph_kern_advance :: (
    info : *Fontinfo,
    glyph1 : s32,
    glyph2 : s32
) -> s32 #foreign libstbtruetype "stbtt_GetGlyphKernAdvance";

get_glyph_box :: (
    info : *Fontinfo,
    glyphIndex : s32,
    x0 : *s32,
    y0 : *s32,
    x1 : *s32,
    y1 : *s32
) -> s32 #foreign libstbtruetype "stbtt_GetGlyphBox";

get_kerning_table_length :: (info : *Fontinfo) -> s32 #foreign libstbtruetype "stbtt_GetKerningTableLength";

get_kerning_table :: (
    info : *Fontinfo,
    table : *Kerningentry,
    tableLength : s32
) -> s32 #foreign libstbtruetype "stbtt_GetKerningTable";

is_glyph_empty :: (
    info : *Fontinfo,
    glyphIndex : s32
) -> s32 #foreign libstbtruetype "stbtt_IsGlyphEmpty";

get_codepoint_shape :: (
    info : *Fontinfo,
    unicodeCodepoint : s32,
    vertices : **Vertex
) -> s32 #foreign libstbtruetype "stbtt_GetCodepointShape";

get_glyph_shape :: (
    info : *Fontinfo,
    glyphIndex : s32,
    vertices : **Vertex
) -> s32 #foreign libstbtruetype "stbtt_GetGlyphShape";

free_shape :: (
    info : *Fontinfo,
    vertices : *Vertex
) -> void #foreign libstbtruetype "stbtt_FreeShape";

find_svg_doc :: (
    info : *Fontinfo,
    gl : s32
) -> *u8 #foreign libstbtruetype "stbtt_FindSVGDoc";

get_codepoint_svg :: (
    info : *Fontinfo,
    unicodeCodepoint : s32,
    svg : **u8
) -> s32 #foreign libstbtruetype "stbtt_GetCodepointSVG";

get_glyph_svg :: (
    info : *Fontinfo,
    gl : s32,
    svg : **u8
) -> s32 #foreign libstbtruetype "stbtt_GetGlyphSVG";

free_bitmap :: (
    bitmap : *u8,
    userdata : *void
) -> void #foreign libstbtruetype "stbtt_FreeBitmap";

get_codepoint_bitmap :: (
    info : *Fontinfo,
    scaleX : float32,
    scaleY : float32,
    codepoint : s32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetCodepointBitmap";

get_codepoint_bitmap_subpixel :: (
    info : *Fontinfo,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    codepoint : s32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetCodepointBitmapSubpixel";

make_codepoint_bitmap :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    codepoint : s32
) -> void #foreign libstbtruetype "stbtt_MakeCodepointBitmap";

make_codepoint_bitmap_subpixel :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    codepoint : s32
) -> void #foreign libstbtruetype "stbtt_MakeCodepointBitmapSubpixel";

make_codepoint_bitmap_subpixel_prefilter :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    oversampleX : s32,
    oversampleY : s32,
    subX : *float32,
    subY : *float32,
    codepoint : s32
) -> void #foreign libstbtruetype "stbtt_MakeCodepointBitmapSubpixelPrefilter";

get_codepoint_bitmap_box :: (
    font : *Fontinfo,
    codepoint : s32,
    scaleX : float32,
    scaleY : float32,
    ix0 : *s32,
    iy0 : *s32,
    ix1 : *s32,
    iy1 : *s32
) -> void #foreign libstbtruetype "stbtt_GetCodepointBitmapBox";

get_codepoint_bitmap_box_subpixel :: (
    font : *Fontinfo,
    codepoint : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    ix0 : *s32,
    iy0 : *s32,
    ix1 : *s32,
    iy1 : *s32
) -> void #foreign libstbtruetype "stbtt_GetCodepointBitmapBoxSubpixel";

get_glyph_bitmap :: (
    info : *Fontinfo,
    scaleX : float32,
    scaleY : float32,
    glyph : s32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetGlyphBitmap";

get_glyph_bitmap_subpixel :: (
    info : *Fontinfo,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    glyph : s32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetGlyphBitmapSubpixel";

make_glyph_bitmap :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    glyph : s32
) -> void #foreign libstbtruetype "stbtt_MakeGlyphBitmap";

make_glyph_bitmap_subpixel :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    glyph : s32
) -> void #foreign libstbtruetype "stbtt_MakeGlyphBitmapSubpixel";

make_glyph_bitmap_subpixel_prefilter :: (
    info : *Fontinfo,
    output : *u8,
    outW : s32,
    outH : s32,
    outStride : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    oversampleX : s32,
    oversampleY : s32,
    subX : *float32,
    subY : *float32,
    glyph : s32
) -> void #foreign libstbtruetype "stbtt_MakeGlyphBitmapSubpixelPrefilter";

get_glyph_bitmap_box :: (
    font : *Fontinfo,
    glyph : s32,
    scaleX : float32,
    scaleY : float32,
    ix0 : *s32,
    iy0 : *s32,
    ix1 : *s32,
    iy1 : *s32
) -> void #foreign libstbtruetype "stbtt_GetGlyphBitmapBox";

get_glyph_bitmap_box_subpixel :: (
    font : *Fontinfo,
    glyph : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    ix0 : *s32,
    iy0 : *s32,
    ix1 : *s32,
    iy1 : *s32
) -> void #foreign libstbtruetype "stbtt_GetGlyphBitmapBoxSubpixel";

rasterize :: (
    result : *Bitmap,
    flatnessInPixels : float32,
    vertices : *Vertex,
    numVerts : s32,
    scaleX : float32,
    scaleY : float32,
    shiftX : float32,
    shiftY : float32,
    x_off : s32,
    y_off : s32,
    invert : s32,
    userdata : *void
) -> void #foreign libstbtruetype "stbtt_Rasterize";

free_sdf :: (
    bitmap : *u8,
    userdata : *void
) -> void #foreign libstbtruetype "stbtt_FreeSDF";

get_glyph_sdf :: (
    info : *Fontinfo,
    scale : float32,
    glyph : s32,
    padding : s32,
    onedgeValue : u8,
    pixelDistScale : float32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetGlyphSDF";

get_codepoint_sdf :: (
    info : *Fontinfo,
    scale : float32,
    codepoint : s32,
    padding : s32,
    onedgeValue : u8,
    pixelDistScale : float32,
    width : *s32,
    height : *s32,
    xoff : *s32,
    yoff : *s32
) -> *u8 #foreign libstbtruetype "stbtt_GetCodepointSDF";

find_matching_font :: (
    fontdata : *u8,
    name : *u8,
    flags : s32
) -> s32 #foreign libstbtruetype "stbtt_FindMatchingFont";

compareutf8toutf16_bigendian :: (
    s1 : *u8,
    len1 : s32,
    s2 : *u8,
    len2 : s32
) -> s32 #foreign libstbtruetype "stbtt_CompareUTF8toUTF16_bigendian";

get_font_name_string :: (
    font : *Fontinfo,
    length : *s32,
    platformId : s32,
    encodingId : s32,
    languageId : s32,
    nameId : s32
) -> *u8 #foreign libstbtruetype "stbtt_GetFontNameString";

