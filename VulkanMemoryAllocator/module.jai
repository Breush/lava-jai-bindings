Vk :: #import "Vulkan";

libvma :: #library "libvma";

VULKAN_VERSION :: 1002000;

AllocatorCreateFlags :: Vk.Flags;
AllocationCreateFlags :: Vk.Flags;
PoolCreateFlags :: Vk.Flags;
DefragmentationFlags :: Vk.Flags;
VirtualBlockCreateFlags :: Vk.Flags;
VirtualAllocationCreateFlags :: Vk.Flags;
Allocator :: *Allocator_T;
Pool :: *Pool_T;
Allocation :: *Allocation_T;
DefragmentationContext :: *DefragmentationContext_T;
VirtualAllocation :: *VirtualAllocation_T;
VirtualBlock :: *VirtualBlock_T;
PFN_AllocateDeviceMemoryFunction :: #type (
    allocator : Allocator,
    memoryType : u32,
    memory : Vk.DeviceMemory,
    size : Vk.DeviceSize,
    pUserData : *void
) #c_call;
PFN_FreeDeviceMemoryFunction :: #type (
    allocator : Allocator,
    memoryType : u32,
    memory : Vk.DeviceMemory,
    size : Vk.DeviceSize,
    pUserData : *void
) #c_call;

AllocatorCreateFlagBits :: enum_flags u32 {
    ExternallySynchronized :: 1;
    KhrDedicatedAllocation :: 2;
    KhrBindMemory2 :: 4;
    ExtMemoryBudget :: 8;
    AmdDeviceCoherentMemory :: 16;
    BufferDeviceAddress :: 32;
    ExtMemoryPriority :: 64;
}

MemoryUsage :: enum s32 {
    Unknown :: 0;
    GpuOnly :: 1;
    CpuOnly :: 2;
    CpuToGpu :: 3;
    GpuToCpu :: 4;
    CpuCopy :: 5;
    GpuLazilyAllocated :: 6;
    Auto :: 7;
    AutoPreferDevice :: 8;
    AutoPreferHost :: 9;
}

AllocationCreateFlagBits :: enum_flags u32 {
    DedicatedMemory :: 1;
    NeverAllocate :: 2;
    Mapped :: 4;
    UserDataCopyString :: 32;
    UpperAddress :: 64;
    DontBind :: 128;
    WithinBudget :: 256;
    CanAlias :: 512;
    HostAccessSequentialWrite :: 1024;
    HostAccessRandom :: 2048;
    HostAccessAllowTransferInstead :: 4096;
    StrategyMinMemory :: 65536;
    StrategyMinTime :: 131072;
    StrategyMinOffset :: 262144;
    StrategyBestFit :: 65536;
    StrategyFirstFit :: 131072;
    StrategyMask :: 65536;
}

PoolCreateFlagBits :: enum_flags u32 {
    IgnoreBufferImageGranularity :: 2;
    LinearAlgorithm :: 4;
    AlgorithmMask :: 4;
}

DefragmentationFlagBits :: enum_flags u32 {
    FlagAlgorithmFast :: 1;
    FlagAlgorithmBalanced :: 2;
    FlagAlgorithmFull :: 4;
    FlagAlgorithmExtensive :: 8;
    FlagAlgorithmMask :: 1;
}

DefragmentationMoveOperation :: enum s32 {
    Copy :: 0;
    Ignore :: 1;
    Destroy :: 2;
}

VirtualBlockCreateFlagBits :: enum_flags u32 {
    LinearAlgorithm :: 1;
    AlgorithmMask :: 1;
}

VirtualAllocationCreateFlagBits :: enum_flags u32 {
    UpperAddress :: 64;
    StrategyMinMemory :: 65536;
    StrategyMinTime :: 131072;
    StrategyMinOffset :: 262144;
    StrategyMask :: 65536;
}

Allocator_T :: struct {}

Pool_T :: struct {}

Allocation_T :: struct {}

DefragmentationContext_T :: struct {}

VirtualAllocation_T :: struct {}

VirtualBlock_T :: struct {}

DeviceMemoryCallbacks :: struct {
    pfnAllocate : PFN_AllocateDeviceMemoryFunction;
    pfnFree : PFN_FreeDeviceMemoryFunction;
    pUserData : *void;
}

VulkanFunctions :: struct {
    vkGetInstanceProcAddr : *void;
    vkGetDeviceProcAddr : *void;
    vkGetPhysicalDeviceProperties : *void;
    vkGetPhysicalDeviceMemoryProperties : *void;
    vkAllocateMemory : *void;
    vkFreeMemory : *void;
    vkMapMemory : *void;
    vkUnmapMemory : *void;
    vkFlushMappedMemoryRanges : *void;
    vkInvalidateMappedMemoryRanges : *void;
    vkBindBufferMemory : *void;
    vkBindImageMemory : *void;
    vkGetBufferMemoryRequirements : *void;
    vkGetImageMemoryRequirements : *void;
    vkCreateBuffer : *void;
    vkDestroyBuffer : *void;
    vkCreateImage : *void;
    vkDestroyImage : *void;
    vkCmdCopyBuffer : *void;
    vkGetBufferMemoryRequirements2KHR : *void;
    vkGetImageMemoryRequirements2KHR : *void;
    vkBindBufferMemory2KHR : *void;
    vkBindImageMemory2KHR : *void;
    vkGetPhysicalDeviceMemoryProperties2KHR : *void;
}

AllocatorCreateInfo :: struct {
    flags : AllocatorCreateFlags;
    physicalDevice : Vk.PhysicalDevice;
    device : Vk.Device;
    preferredLargeHeapBlockSize : Vk.DeviceSize;
    pAllocationCallbacks : *Vk.AllocationCallbacks;
    pDeviceMemoryCallbacks : *DeviceMemoryCallbacks;
    pHeapSizeLimit : *Vk.DeviceSize;
    pVulkanFunctions : *VulkanFunctions;
    instance : Vk.Instance;
    vulkanApiVersion : u32;
    pTypeExternalMemoryHandleTypes : *Vk.ExternalMemoryHandleTypeFlagsKHR;
}

AllocatorInfo :: struct {
    instance : Vk.Instance;
    physicalDevice : Vk.PhysicalDevice;
    device : Vk.Device;
}

Statistics :: struct {
    blockCount : u32;
    allocationCount : u32;
    blockBytes : Vk.DeviceSize;
    allocationBytes : Vk.DeviceSize;
}

DetailedStatistics :: struct {
    statistics : Statistics;
    unusedRangeCount : u32;
    allocationSizeMin : Vk.DeviceSize;
    allocationSizeMax : Vk.DeviceSize;
    unusedRangeSizeMin : Vk.DeviceSize;
    unusedRangeSizeMax : Vk.DeviceSize;
}

TotalStatistics :: struct {
    memoryType : [32]DetailedStatistics;
    memoryHeap : [16]DetailedStatistics;
    total : DetailedStatistics;
}

Budget :: struct {
    statistics : Statistics;
    usage : Vk.DeviceSize;
    budget : Vk.DeviceSize;
}

AllocationCreateInfo :: struct {
    flags : AllocationCreateFlags;
    usage : MemoryUsage;
    requiredFlags : Vk.MemoryPropertyFlags;
    preferredFlags : Vk.MemoryPropertyFlags;
    memoryTypeBits : u32;
    pool : Pool;
    pUserData : *void;
    priority : float32;
}

PoolCreateInfo :: struct {
    memoryTypeIndex : u32;
    flags : PoolCreateFlags;
    blockSize : Vk.DeviceSize;
    minBlockCount : u64;
    maxBlockCount : u64;
    priority : float32;
    minAllocationAlignment : Vk.DeviceSize;
    pMemoryAllocateNext : *void;
}

AllocationInfo :: struct {
    memoryType : u32;
    deviceMemory : Vk.DeviceMemory;
    offset : Vk.DeviceSize;
    size : Vk.DeviceSize;
    pMappedData : *void;
    pUserData : *void;
    pName : *u8;
}

DefragmentationInfo :: struct {
    flags : DefragmentationFlags;
    pool : Pool;
    maxBytesPerPass : Vk.DeviceSize;
    maxAllocationsPerPass : u32;
}

DefragmentationMove :: struct {
    operation : DefragmentationMoveOperation;
    srcAllocation : Allocation;
    dstTmpAllocation : Allocation;
}

DefragmentationPassMoveInfo :: struct {
    moveCount : u32;
    pMoves : *DefragmentationMove;
}

DefragmentationStats :: struct {
    bytesMoved : Vk.DeviceSize;
    bytesFreed : Vk.DeviceSize;
    allocationsMoved : u32;
    deviceMemoryBlocksFreed : u32;
}

VirtualBlockCreateInfo :: struct {
    size : Vk.DeviceSize;
    flags : VirtualBlockCreateFlags;
    pAllocationCallbacks : *Vk.AllocationCallbacks;
}

VirtualAllocationCreateInfo :: struct {
    size : Vk.DeviceSize;
    alignment : Vk.DeviceSize;
    flags : VirtualAllocationCreateFlags;
    pUserData : *void;
}

VirtualAllocationInfo :: struct {
    offset : Vk.DeviceSize;
    size : Vk.DeviceSize;
    pUserData : *void;
}

create_allocator :: (
    pCreateInfo : *AllocatorCreateInfo,
    pAllocator : *Allocator
) -> Vk.Result #foreign libvma "vmaCreateAllocator";

destroy_allocator :: (allocator : Allocator) -> void #foreign libvma "vmaDestroyAllocator";

get_allocator_info :: (
    allocator : Allocator,
    pAllocatorInfo : *AllocatorInfo
) -> void #foreign libvma "vmaGetAllocatorInfo";

get_physical_device_properties :: (
    allocator : Allocator,
    ppPhysicalDeviceProperties : **Vk.PhysicalDeviceProperties
) -> void #foreign libvma "vmaGetPhysicalDeviceProperties";

get_memory_properties :: (
    allocator : Allocator,
    ppPhysicalDeviceMemoryProperties : **Vk.PhysicalDeviceMemoryProperties
) -> void #foreign libvma "vmaGetMemoryProperties";

get_memory_type_properties :: (
    allocator : Allocator,
    memoryTypeIndex : u32,
    pFlags : *Vk.MemoryPropertyFlags
) -> void #foreign libvma "vmaGetMemoryTypeProperties";

set_current_frame_index :: (
    allocator : Allocator,
    frameIndex : u32
) -> void #foreign libvma "vmaSetCurrentFrameIndex";

calculate_statistics :: (
    allocator : Allocator,
    pStats : *TotalStatistics
) -> void #foreign libvma "vmaCalculateStatistics";

get_heap_budgets :: (
    allocator : Allocator,
    pBudgets : *Budget
) -> void #foreign libvma "vmaGetHeapBudgets";

find_memory_type_index :: (
    allocator : Allocator,
    memoryTypeBits : u32,
    pAllocationCreateInfo : *AllocationCreateInfo,
    pMemoryTypeIndex : *u32
) -> Vk.Result #foreign libvma "vmaFindMemoryTypeIndex";

find_memory_type_index_for_buffer_info :: (
    allocator : Allocator,
    pBufferCreateInfo : *Vk.BufferCreateInfo,
    pAllocationCreateInfo : *AllocationCreateInfo,
    pMemoryTypeIndex : *u32
) -> Vk.Result #foreign libvma "vmaFindMemoryTypeIndexForBufferInfo";

find_memory_type_index_for_image_info :: (
    allocator : Allocator,
    pImageCreateInfo : *Vk.ImageCreateInfo,
    pAllocationCreateInfo : *AllocationCreateInfo,
    pMemoryTypeIndex : *u32
) -> Vk.Result #foreign libvma "vmaFindMemoryTypeIndexForImageInfo";

create_pool :: (
    allocator : Allocator,
    pCreateInfo : *PoolCreateInfo,
    pPool : *Pool
) -> Vk.Result #foreign libvma "vmaCreatePool";

destroy_pool :: (
    allocator : Allocator,
    pool : Pool
) -> void #foreign libvma "vmaDestroyPool";

get_pool_statistics :: (
    allocator : Allocator,
    pool : Pool,
    pPoolStats : *Statistics
) -> void #foreign libvma "vmaGetPoolStatistics";

calculate_pool_statistics :: (
    allocator : Allocator,
    pool : Pool,
    pPoolStats : *DetailedStatistics
) -> void #foreign libvma "vmaCalculatePoolStatistics";

check_pool_corruption :: (
    allocator : Allocator,
    pool : Pool
) -> Vk.Result #foreign libvma "vmaCheckPoolCorruption";

get_pool_name :: (
    allocator : Allocator,
    pool : Pool,
    ppName : **u8
) -> void #foreign libvma "vmaGetPoolName";

set_pool_name :: (
    allocator : Allocator,
    pool : Pool,
    pName : *u8
) -> void #foreign libvma "vmaSetPoolName";

allocate_memory :: (
    allocator : Allocator,
    pVkMemoryRequirements : *Vk.MemoryRequirements,
    pCreateInfo : *AllocationCreateInfo,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaAllocateMemory";

allocate_memory_pages :: (
    allocator : Allocator,
    pVkMemoryRequirements : *Vk.MemoryRequirements,
    pCreateInfo : *AllocationCreateInfo,
    allocationCount : u64,
    pAllocations : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaAllocateMemoryPages";

allocate_memory_for_buffer :: (
    allocator : Allocator,
    buffer : Vk.Buffer,
    pCreateInfo : *AllocationCreateInfo,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaAllocateMemoryForBuffer";

allocate_memory_for_image :: (
    allocator : Allocator,
    image : Vk.Image,
    pCreateInfo : *AllocationCreateInfo,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaAllocateMemoryForImage";

free_memory :: (
    allocator : Allocator,
    allocation : Allocation
) -> void #foreign libvma "vmaFreeMemory";

free_memory_pages :: (
    allocator : Allocator,
    allocationCount : u64,
    pAllocations : *Allocation
) -> void #foreign libvma "vmaFreeMemoryPages";

get_allocation_info :: (
    allocator : Allocator,
    allocation : Allocation,
    pAllocationInfo : *AllocationInfo
) -> void #foreign libvma "vmaGetAllocationInfo";

set_allocation_user_data :: (
    allocator : Allocator,
    allocation : Allocation,
    pUserData : *void
) -> void #foreign libvma "vmaSetAllocationUserData";

set_allocation_name :: (
    allocator : Allocator,
    allocation : Allocation,
    pName : *u8
) -> void #foreign libvma "vmaSetAllocationName";

get_allocation_memory_properties :: (
    allocator : Allocator,
    allocation : Allocation,
    pFlags : *Vk.MemoryPropertyFlags
) -> void #foreign libvma "vmaGetAllocationMemoryProperties";

map_memory :: (
    allocator : Allocator,
    allocation : Allocation,
    ppData : **void
) -> Vk.Result #foreign libvma "vmaMapMemory";

unmap_memory :: (
    allocator : Allocator,
    allocation : Allocation
) -> void #foreign libvma "vmaUnmapMemory";

flush_allocation :: (
    allocator : Allocator,
    allocation : Allocation,
    offset : Vk.DeviceSize,
    size : Vk.DeviceSize
) -> Vk.Result #foreign libvma "vmaFlushAllocation";

invalidate_allocation :: (
    allocator : Allocator,
    allocation : Allocation,
    offset : Vk.DeviceSize,
    size : Vk.DeviceSize
) -> Vk.Result #foreign libvma "vmaInvalidateAllocation";

flush_allocations :: (
    allocator : Allocator,
    allocationCount : u32,
    allocations : *Allocation,
    offsets : *Vk.DeviceSize,
    sizes : *Vk.DeviceSize
) -> Vk.Result #foreign libvma "vmaFlushAllocations";

invalidate_allocations :: (
    allocator : Allocator,
    allocationCount : u32,
    allocations : *Allocation,
    offsets : *Vk.DeviceSize,
    sizes : *Vk.DeviceSize
) -> Vk.Result #foreign libvma "vmaInvalidateAllocations";

check_corruption :: (
    allocator : Allocator,
    memoryTypeBits : u32
) -> Vk.Result #foreign libvma "vmaCheckCorruption";

begin_defragmentation :: (
    allocator : Allocator,
    pInfo : *DefragmentationInfo,
    pContext : *DefragmentationContext
) -> Vk.Result #foreign libvma "vmaBeginDefragmentation";

end_defragmentation :: (
    allocator : Allocator,
    _context : DefragmentationContext,
    pStats : *DefragmentationStats
) -> void #foreign libvma "vmaEndDefragmentation";

begin_defragmentation_pass :: (
    allocator : Allocator,
    _context : DefragmentationContext,
    pPassInfo : *DefragmentationPassMoveInfo
) -> Vk.Result #foreign libvma "vmaBeginDefragmentationPass";

end_defragmentation_pass :: (
    allocator : Allocator,
    _context : DefragmentationContext,
    pPassInfo : *DefragmentationPassMoveInfo
) -> Vk.Result #foreign libvma "vmaEndDefragmentationPass";

bind_buffer_memory :: (
    allocator : Allocator,
    allocation : Allocation,
    buffer : Vk.Buffer
) -> Vk.Result #foreign libvma "vmaBindBufferMemory";

bind_buffer_memory2 :: (
    allocator : Allocator,
    allocation : Allocation,
    allocationLocalOffset : Vk.DeviceSize,
    buffer : Vk.Buffer,
    pNext : *void
) -> Vk.Result #foreign libvma "vmaBindBufferMemory2";

bind_image_memory :: (
    allocator : Allocator,
    allocation : Allocation,
    image : Vk.Image
) -> Vk.Result #foreign libvma "vmaBindImageMemory";

bind_image_memory2 :: (
    allocator : Allocator,
    allocation : Allocation,
    allocationLocalOffset : Vk.DeviceSize,
    image : Vk.Image,
    pNext : *void
) -> Vk.Result #foreign libvma "vmaBindImageMemory2";

create_buffer :: (
    allocator : Allocator,
    pBufferCreateInfo : *Vk.BufferCreateInfo,
    pAllocationCreateInfo : *AllocationCreateInfo,
    pBuffer : *Vk.Buffer,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaCreateBuffer";

create_buffer_with_alignment :: (
    allocator : Allocator,
    pBufferCreateInfo : *Vk.BufferCreateInfo,
    pAllocationCreateInfo : *AllocationCreateInfo,
    minAlignment : Vk.DeviceSize,
    pBuffer : *Vk.Buffer,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaCreateBufferWithAlignment";

create_aliasing_buffer :: (
    allocator : Allocator,
    allocation : Allocation,
    pBufferCreateInfo : *Vk.BufferCreateInfo,
    pBuffer : *Vk.Buffer
) -> Vk.Result #foreign libvma "vmaCreateAliasingBuffer";

create_aliasing_buffer2 :: (
    allocator : Allocator,
    allocation : Allocation,
    allocationLocalOffset : Vk.DeviceSize,
    pBufferCreateInfo : *Vk.BufferCreateInfo,
    pBuffer : *Vk.Buffer
) -> Vk.Result #foreign libvma "vmaCreateAliasingBuffer2";

destroy_buffer :: (
    allocator : Allocator,
    buffer : Vk.Buffer,
    allocation : Allocation
) -> void #foreign libvma "vmaDestroyBuffer";

create_image :: (
    allocator : Allocator,
    pImageCreateInfo : *Vk.ImageCreateInfo,
    pAllocationCreateInfo : *AllocationCreateInfo,
    pImage : *Vk.Image,
    pAllocation : *Allocation,
    pAllocationInfo : *AllocationInfo
) -> Vk.Result #foreign libvma "vmaCreateImage";

create_aliasing_image :: (
    allocator : Allocator,
    allocation : Allocation,
    pImageCreateInfo : *Vk.ImageCreateInfo,
    pImage : *Vk.Image
) -> Vk.Result #foreign libvma "vmaCreateAliasingImage";

create_aliasing_image2 :: (
    allocator : Allocator,
    allocation : Allocation,
    allocationLocalOffset : Vk.DeviceSize,
    pImageCreateInfo : *Vk.ImageCreateInfo,
    pImage : *Vk.Image
) -> Vk.Result #foreign libvma "vmaCreateAliasingImage2";

destroy_image :: (
    allocator : Allocator,
    image : Vk.Image,
    allocation : Allocation
) -> void #foreign libvma "vmaDestroyImage";

create_virtual_block :: (
    pCreateInfo : *VirtualBlockCreateInfo,
    pVirtualBlock : *VirtualBlock
) -> Vk.Result #foreign libvma "vmaCreateVirtualBlock";

destroy_virtual_block :: (virtualBlock : VirtualBlock) -> void #foreign libvma "vmaDestroyVirtualBlock";

is_virtual_block_empty :: (virtualBlock : VirtualBlock) -> Vk.Bool32 #foreign libvma "vmaIsVirtualBlockEmpty";

get_virtual_allocation_info :: (
    virtualBlock : VirtualBlock,
    allocation : VirtualAllocation,
    pVirtualAllocInfo : *VirtualAllocationInfo
) -> void #foreign libvma "vmaGetVirtualAllocationInfo";

virtual_allocate :: (
    virtualBlock : VirtualBlock,
    pCreateInfo : *VirtualAllocationCreateInfo,
    pAllocation : *VirtualAllocation,
    pOffset : *Vk.DeviceSize
) -> Vk.Result #foreign libvma "vmaVirtualAllocate";

virtual_free :: (
    virtualBlock : VirtualBlock,
    allocation : VirtualAllocation
) -> void #foreign libvma "vmaVirtualFree";

clear_virtual_block :: (virtualBlock : VirtualBlock) -> void #foreign libvma "vmaClearVirtualBlock";

set_virtual_allocation_user_data :: (
    virtualBlock : VirtualBlock,
    allocation : VirtualAllocation,
    pUserData : *void
) -> void #foreign libvma "vmaSetVirtualAllocationUserData";

get_virtual_block_statistics :: (
    virtualBlock : VirtualBlock,
    pStats : *Statistics
) -> void #foreign libvma "vmaGetVirtualBlockStatistics";

calculate_virtual_block_statistics :: (
    virtualBlock : VirtualBlock,
    pStats : *DetailedStatistics
) -> void #foreign libvma "vmaCalculateVirtualBlockStatistics";

build_virtual_block_stats_string :: (
    virtualBlock : VirtualBlock,
    ppStatsString : **u8,
    detailedMap : Vk.Bool32
) -> void #foreign libvma "vmaBuildVirtualBlockStatsString";

free_virtual_block_stats_string :: (
    virtualBlock : VirtualBlock,
    pStatsString : *u8
) -> void #foreign libvma "vmaFreeVirtualBlockStatsString";

build_stats_string :: (
    allocator : Allocator,
    ppStatsString : **u8,
    detailedMap : Vk.Bool32
) -> void #foreign libvma "vmaBuildStatsString";

free_stats_string :: (
    allocator : Allocator,
    pStatsString : *u8
) -> void #foreign libvma "vmaFreeStatsString";
