libshaderc :: #foreign_library "libshaderc";

H_ :: 1;
ENV_H_ :: 1;
STATUS_H_ :: 1;

CompilerT :: *Compiler;
CompileOptionsT :: *CompileOptions;
IncludeResolveFn :: #type (
    userData : *void,
    requestedSource : *u8,
    type : s64,
    requestingSource : *u8,
    includeDepth : u64
) -> *IncludeResult #foreign;
IncludeResultReleaseFn :: #type (
    userData : *void,
    includeResult : *IncludeResult
) #foreign;
CompilationResultT :: *CompilationResult;

SourceLanguage :: enum s32 {
    Glsl;
    Hlsl;
}

ShaderKind :: enum s32 {
    VertexShader;
    FragmentShader;
    ComputeShader;
    GeometryShader;
    TessControlShader;
    TessEvaluationShader;
    GlslVertexShader :: 0;
    GlslFragmentShader :: 1;
    GlslComputeShader :: 2;
    GlslGeometryShader :: 3;
    GlslTessControlShader :: 4;
    GlslTessEvaluationShader :: 5;
    GlslInferFromSource;
    GlslDefaultVertexShader;
    GlslDefaultFragmentShader;
    GlslDefaultComputeShader;
    GlslDefaultGeometryShader;
    GlslDefaultTessControlShader;
    GlslDefaultTessEvaluationShader;
    SpirvAssembly;
    RaygenShader;
    AnyhitShader;
    ClosesthitShader;
    MissShader;
    IntersectionShader;
    CallableShader;
    GlslRaygenShader :: 14;
    GlslAnyhitShader :: 15;
    GlslClosesthitShader :: 16;
    GlslMissShader :: 17;
    GlslIntersectionShader :: 18;
    GlslCallableShader :: 19;
    GlslDefaultRaygenShader;
    GlslDefaultAnyhitShader;
    GlslDefaultClosesthitShader;
    GlslDefaultMissShader;
    GlslDefaultIntersectionShader;
    GlslDefaultCallableShader;
    TaskShader;
    MeshShader;
    GlslTaskShader :: 26;
    GlslMeshShader :: 27;
    GlslDefaultTaskShader;
    GlslDefaultMeshShader;
}

Profile :: enum s32 {
    None;
    Core;
    Compatibility;
    Es;
}

OptimizationLevel :: enum s32 {
    Zero;
    Size;
    Performance;
}

Limit :: enum s32 {
    MaxLights;
    MaxClipPlanes;
    MaxTextureUnits;
    MaxTextureCoords;
    MaxVertexAttribs;
    MaxVertexUniformComponents;
    MaxVaryingFloats;
    MaxVertexTextureImageUnits;
    MaxCombinedTextureImageUnits;
    MaxTextureImageUnits;
    MaxFragmentUniformComponents;
    MaxDrawBuffers;
    MaxVertexUniformVectors;
    MaxVaryingVectors;
    MaxFragmentUniformVectors;
    MaxVertexOutputVectors;
    MaxFragmentInputVectors;
    MinProgramTexelOffset;
    MaxProgramTexelOffset;
    MaxClipDistances;
    MaxComputeWorkGroupCountX;
    MaxComputeWorkGroupCountY;
    MaxComputeWorkGroupCountZ;
    MaxComputeWorkGroupSizeX;
    MaxComputeWorkGroupSizeY;
    MaxComputeWorkGroupSizeZ;
    MaxComputeUniformComponents;
    MaxComputeTextureImageUnits;
    MaxComputeImageUniforms;
    MaxComputeAtomicCounters;
    MaxComputeAtomicCounterBuffers;
    MaxVaryingComponents;
    MaxVertexOutputComponents;
    MaxGeometryInputComponents;
    MaxGeometryOutputComponents;
    MaxFragmentInputComponents;
    MaxImageUnits;
    MaxCombinedImageUnitsAndFragmentOutputs;
    MaxCombinedShaderOutputResources;
    MaxImageSamples;
    MaxVertexImageUniforms;
    MaxTessControlImageUniforms;
    MaxTessEvaluationImageUniforms;
    MaxGeometryImageUniforms;
    MaxFragmentImageUniforms;
    MaxCombinedImageUniforms;
    MaxGeometryTextureImageUnits;
    MaxGeometryOutputVertices;
    MaxGeometryTotalOutputComponents;
    MaxGeometryUniformComponents;
    MaxGeometryVaryingComponents;
    MaxTessControlInputComponents;
    MaxTessControlOutputComponents;
    MaxTessControlTextureImageUnits;
    MaxTessControlUniformComponents;
    MaxTessControlTotalOutputComponents;
    MaxTessEvaluationInputComponents;
    MaxTessEvaluationOutputComponents;
    MaxTessEvaluationTextureImageUnits;
    MaxTessEvaluationUniformComponents;
    MaxTessPatchComponents;
    MaxPatchVertices;
    MaxTessGenLevel;
    MaxViewports;
    MaxVertexAtomicCounters;
    MaxTessControlAtomicCounters;
    MaxTessEvaluationAtomicCounters;
    MaxGeometryAtomicCounters;
    MaxFragmentAtomicCounters;
    MaxCombinedAtomicCounters;
    MaxAtomicCounterBindings;
    MaxVertexAtomicCounterBuffers;
    MaxTessControlAtomicCounterBuffers;
    MaxTessEvaluationAtomicCounterBuffers;
    MaxGeometryAtomicCounterBuffers;
    MaxFragmentAtomicCounterBuffers;
    MaxCombinedAtomicCounterBuffers;
    MaxAtomicCounterBufferSize;
    MaxTransformFeedbackBuffers;
    MaxTransformFeedbackInterleavedComponents;
    MaxCullDistances;
    MaxCombinedClipAndCullDistances;
    MaxSamples;
}

UniformKind :: enum s32 {
    Image;
    Sampler;
    Texture;
    Buffer;
    StorageBuffer;
    UnorderedAccessView;
}

IncludeType :: enum s32 {
    Relative;
    Standard;
}

TargetEnv :: enum s32 {
    Vulkan;
    Opengl;
    OpenglCompat;
    Webgpu;
    Default :: 0;
}

EnvVersion :: enum s32 {
    Vulkan1_0 :: 4194304;
    Vulkan1_1 :: 4198400;
    Vulkan1_2 :: 4202496;
    Opengl4_5 :: 450;
    Webgpu;
}

SpirvVersion :: enum s32 {
    _1_0 :: 65536;
    _1_1 :: 65792;
    _1_2 :: 66048;
    _1_3 :: 66304;
    _1_4 :: 66560;
    _1_5 :: 66816;
}

CompilationStatus :: enum s32 {
    Success :: 0;
    InvalidStage :: 1;
    CompilationError :: 2;
    InternalError :: 3;
    NullResultObject :: 4;
    InvalidAssembly :: 5;
    ValidationError :: 6;
    TransformationError :: 7;
    ConfigurationError :: 8;
}

Compiler :: struct {}

CompileOptions :: struct {}

IncludeResult :: struct {
    sourceName : *u8;
    sourceNameLength : u64;
    content : *u8;
    contentLength : u64;
    userData : *void;
}

CompilationResult :: struct {}

compiler_initialize :: () -> CompilerT #foreign libshaderc "shaderc_compiler_initialize";

compiler_release :: (unamed0 : CompilerT) -> void #foreign libshaderc "shaderc_compiler_release";

compile_options_initialize :: () -> CompileOptionsT #foreign libshaderc "shaderc_compile_options_initialize";

compile_options_clone :: (options : CompileOptionsT) -> CompileOptionsT #foreign libshaderc "shaderc_compile_options_clone";

compile_options_release :: (options : CompileOptionsT) -> void #foreign libshaderc "shaderc_compile_options_release";

compile_options_add_macro_definition :: (
    options : CompileOptionsT,
    name : *u8,
    nameLength : u64,
    value : *u8,
    valueLength : u64
) -> void #foreign libshaderc "shaderc_compile_options_add_macro_definition";

compile_options_set_source_language :: (
    options : CompileOptionsT,
    lang : SourceLanguage
) -> void #foreign libshaderc "shaderc_compile_options_set_source_language";

compile_options_set_generate_debug_info :: (options : CompileOptionsT) -> void #foreign libshaderc "shaderc_compile_options_set_generate_debug_info";

compile_options_set_optimization_level :: (
    options : CompileOptionsT,
    level : OptimizationLevel
) -> void #foreign libshaderc "shaderc_compile_options_set_optimization_level";

compile_options_set_forced_version_profile :: (
    options : CompileOptionsT,
    version : s64,
    profile : Profile
) -> void #foreign libshaderc "shaderc_compile_options_set_forced_version_profile";

compile_options_set_include_callbacks :: (
    options : CompileOptionsT,
    resolver : IncludeResolveFn,
    resultReleaser : IncludeResultReleaseFn,
    userData : *void
) -> void #foreign libshaderc "shaderc_compile_options_set_include_callbacks";

compile_options_set_suppress_warnings :: (options : CompileOptionsT) -> void #foreign libshaderc "shaderc_compile_options_set_suppress_warnings";

compile_options_set_target_env :: (
    options : CompileOptionsT,
    target : TargetEnv,
    version : u32
) -> void #foreign libshaderc "shaderc_compile_options_set_target_env";

compile_options_set_target_spirv :: (
    options : CompileOptionsT,
    version : SpirvVersion
) -> void #foreign libshaderc "shaderc_compile_options_set_target_spirv";

compile_options_set_warnings_as_errors :: (options : CompileOptionsT) -> void #foreign libshaderc "shaderc_compile_options_set_warnings_as_errors";

compile_options_set_limit :: (
    options : CompileOptionsT,
    limit : Limit,
    value : s64
) -> void #foreign libshaderc "shaderc_compile_options_set_limit";

compile_options_set_auto_bind_uniforms :: (
    options : CompileOptionsT,
    autoBind : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_auto_bind_uniforms";

compile_options_set_hlsl_io_mapping :: (
    options : CompileOptionsT,
    hlslIomap : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_io_mapping";

compile_options_set_hlsl_offsets :: (
    options : CompileOptionsT,
    hlslOffsets : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_offsets";

compile_options_set_binding_base :: (
    options : CompileOptionsT,
    kind : UniformKind,
    base : u32
) -> void #foreign libshaderc "shaderc_compile_options_set_binding_base";

compile_options_set_binding_base_for_stage :: (
    options : CompileOptionsT,
    shaderKind : ShaderKind,
    kind : UniformKind,
    base : u32
) -> void #foreign libshaderc "shaderc_compile_options_set_binding_base_for_stage";

compile_options_set_auto_map_locations :: (
    options : CompileOptionsT,
    autoMap : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_auto_map_locations";

compile_options_set_hlsl_register_set_and_binding_for_stage :: (
    options : CompileOptionsT,
    shaderKind : ShaderKind,
    reg : *u8,
    set : *u8,
    binding : *u8
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage";

compile_options_set_hlsl_register_set_and_binding :: (
    options : CompileOptionsT,
    reg : *u8,
    set : *u8,
    binding : *u8
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_register_set_and_binding";

compile_options_set_hlsl_functionality1 :: (
    options : CompileOptionsT,
    enable : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_functionality1";

compile_options_set_invert_y :: (
    options : CompileOptionsT,
    enable : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_invert_y";

compile_options_set_nan_clamp :: (
    options : CompileOptionsT,
    enable : bool
) -> void #foreign libshaderc "shaderc_compile_options_set_nan_clamp";

compile_into_spv :: (
    compiler : CompilerT,
    sourceText : *u8,
    sourceTextSize : u64,
    shaderKind : ShaderKind,
    inputFileName : *u8,
    entryPointName : *u8,
    additionalOptions : CompileOptionsT
) -> CompilationResultT #foreign libshaderc "shaderc_compile_into_spv";

compile_into_spv_assembly :: (
    compiler : CompilerT,
    sourceText : *u8,
    sourceTextSize : u64,
    shaderKind : ShaderKind,
    inputFileName : *u8,
    entryPointName : *u8,
    additionalOptions : CompileOptionsT
) -> CompilationResultT #foreign libshaderc "shaderc_compile_into_spv_assembly";

compile_into_preprocessed_text :: (
    compiler : CompilerT,
    sourceText : *u8,
    sourceTextSize : u64,
    shaderKind : ShaderKind,
    inputFileName : *u8,
    entryPointName : *u8,
    additionalOptions : CompileOptionsT
) -> CompilationResultT #foreign libshaderc "shaderc_compile_into_preprocessed_text";

assemble_into_spv :: (
    compiler : CompilerT,
    sourceAssembly : *u8,
    sourceAssemblySize : u64,
    additionalOptions : CompileOptionsT
) -> CompilationResultT #foreign libshaderc "shaderc_assemble_into_spv";

result_release :: (result : CompilationResultT) -> void #foreign libshaderc "shaderc_result_release";

result_get_length :: (result : CompilationResultT) -> u64 #foreign libshaderc "shaderc_result_get_length";

result_get_num_warnings :: (result : CompilationResultT) -> u64 #foreign libshaderc "shaderc_result_get_num_warnings";

result_get_num_errors :: (result : CompilationResultT) -> u64 #foreign libshaderc "shaderc_result_get_num_errors";

result_get_compilation_status :: (unamed0 : CompilationResultT) -> CompilationStatus #foreign libshaderc "shaderc_result_get_compilation_status";

result_get_bytes :: (result : CompilationResultT) -> *u8 #foreign libshaderc "shaderc_result_get_bytes";

result_get_error_message :: (result : CompilationResultT) -> *u8 #foreign libshaderc "shaderc_result_get_error_message";

get_spv_version :: (
    version : *u64,
    revision : *u64
) -> void #foreign libshaderc "shaderc_get_spv_version";

parse_version_profile :: (
    str : *u8,
    version : *s64,
    profile : *Profile
) -> bool #foreign libshaderc "shaderc_parse_version_profile";

