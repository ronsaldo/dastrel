Class {
	#name : #SpirVConstants,
	#superclass : #SharedPool,
	#classVars : [
		'SpvAccessQualifierReadOnly',
		'SpvAccessQualifierReadWrite',
		'SpvAccessQualifierWriteOnly',
		'SpvAddressingModelLogical',
		'SpvAddressingModelPhysical32',
		'SpvAddressingModelPhysical64',
		'SpvBuiltInClipDistance',
		'SpvBuiltInCullDistance',
		'SpvBuiltInEnqueuedWorkgroupSize',
		'SpvBuiltInFragCoord',
		'SpvBuiltInFragDepth',
		'SpvBuiltInFrontFacing',
		'SpvBuiltInGlobalInvocationId',
		'SpvBuiltInGlobalLinearId',
		'SpvBuiltInGlobalOffset',
		'SpvBuiltInGlobalSize',
		'SpvBuiltInHelperInvocation',
		'SpvBuiltInInstanceId',
		'SpvBuiltInInstanceIndex',
		'SpvBuiltInInvocationId',
		'SpvBuiltInLayer',
		'SpvBuiltInLocalInvocationId',
		'SpvBuiltInLocalInvocationIndex',
		'SpvBuiltInNumEnqueuedSubgroups',
		'SpvBuiltInNumSubgroups',
		'SpvBuiltInNumWorkgroups',
		'SpvBuiltInPatchVertices',
		'SpvBuiltInPointCoord',
		'SpvBuiltInPointSize',
		'SpvBuiltInPosition',
		'SpvBuiltInPrimitiveId',
		'SpvBuiltInSampleId',
		'SpvBuiltInSampleMask',
		'SpvBuiltInSamplePosition',
		'SpvBuiltInSubgroupId',
		'SpvBuiltInSubgroupLocalInvocationId',
		'SpvBuiltInSubgroupMaxSize',
		'SpvBuiltInSubgroupSize',
		'SpvBuiltInTessCoord',
		'SpvBuiltInTessLevelInner',
		'SpvBuiltInTessLevelOuter',
		'SpvBuiltInVertexId',
		'SpvBuiltInVertexIndex',
		'SpvBuiltInViewportIndex',
		'SpvBuiltInWorkDim',
		'SpvBuiltInWorkgroupId',
		'SpvBuiltInWorkgroupSize',
		'SpvCapabilityAddresses',
		'SpvCapabilityAtomicStorage',
		'SpvCapabilityClipDistance',
		'SpvCapabilityCullDistance',
		'SpvCapabilityDerivativeControl',
		'SpvCapabilityDeviceEnqueue',
		'SpvCapabilityFloat16',
		'SpvCapabilityFloat16Buffer',
		'SpvCapabilityFloat64',
		'SpvCapabilityGenericPointer',
		'SpvCapabilityGeometry',
		'SpvCapabilityGeometryPointSize',
		'SpvCapabilityGeometryStreams',
		'SpvCapabilityGroups',
		'SpvCapabilityImage1D',
		'SpvCapabilityImageBasic',
		'SpvCapabilityImageBuffer',
		'SpvCapabilityImageCubeArray',
		'SpvCapabilityImageGatherExtended',
		'SpvCapabilityImageMSArray',
		'SpvCapabilityImageMipmap',
		'SpvCapabilityImageQuery',
		'SpvCapabilityImageReadWrite',
		'SpvCapabilityImageRect',
		'SpvCapabilityInputAttachment',
		'SpvCapabilityInt16',
		'SpvCapabilityInt64',
		'SpvCapabilityInt64Atomics',
		'SpvCapabilityInt8',
		'SpvCapabilityInterpolationFunction',
		'SpvCapabilityKernel',
		'SpvCapabilityLinkage',
		'SpvCapabilityLiteralSampler',
		'SpvCapabilityMatrix',
		'SpvCapabilityMinLod',
		'SpvCapabilityMultiViewport',
		'SpvCapabilityPipes',
		'SpvCapabilitySampleRateShading',
		'SpvCapabilitySampled1D',
		'SpvCapabilitySampledBuffer',
		'SpvCapabilitySampledCubeArray',
		'SpvCapabilitySampledImageArrayDynamicIndexing',
		'SpvCapabilitySampledRect',
		'SpvCapabilityShader',
		'SpvCapabilitySparseResidency',
		'SpvCapabilityStorageBufferArrayDynamicIndexing',
		'SpvCapabilityStorageImageArrayDynamicIndexing',
		'SpvCapabilityStorageImageExtendedFormats',
		'SpvCapabilityStorageImageMultisample',
		'SpvCapabilityStorageImageReadWithoutFormat',
		'SpvCapabilityStorageImageWriteWithoutFormat',
		'SpvCapabilityTessellation',
		'SpvCapabilityTessellationPointSize',
		'SpvCapabilityTransformFeedback',
		'SpvCapabilityUniformBufferArrayDynamicIndexing',
		'SpvCapabilityVector16',
		'SpvDecorationAliased',
		'SpvDecorationAlignment',
		'SpvDecorationArrayStride',
		'SpvDecorationBinding',
		'SpvDecorationBlock',
		'SpvDecorationBufferBlock',
		'SpvDecorationBuiltIn',
		'SpvDecorationCPacked',
		'SpvDecorationCentroid',
		'SpvDecorationCoherent',
		'SpvDecorationColMajor',
		'SpvDecorationComponent',
		'SpvDecorationConstant',
		'SpvDecorationDescriptorSet',
		'SpvDecorationFPFastMathMode',
		'SpvDecorationFPRoundingMode',
		'SpvDecorationFlat',
		'SpvDecorationFuncParamAttr',
		'SpvDecorationGLSLPacked',
		'SpvDecorationGLSLShared',
		'SpvDecorationIndex',
		'SpvDecorationInputAttachmentIndex',
		'SpvDecorationInvariant',
		'SpvDecorationLinkageAttributes',
		'SpvDecorationLocation',
		'SpvDecorationMatrixStride',
		'SpvDecorationNoContraction',
		'SpvDecorationNoPerspective',
		'SpvDecorationNonReadable',
		'SpvDecorationNonWritable',
		'SpvDecorationOffset',
		'SpvDecorationPatch',
		'SpvDecorationRelaxedPrecision',
		'SpvDecorationRestrict',
		'SpvDecorationRowMajor',
		'SpvDecorationSample',
		'SpvDecorationSaturatedConversion',
		'SpvDecorationSpecId',
		'SpvDecorationStream',
		'SpvDecorationUniform',
		'SpvDecorationVolatile',
		'SpvDecorationXfbBuffer',
		'SpvDecorationXfbStride',
		'SpvDim1D',
		'SpvDim2D',
		'SpvDim3D',
		'SpvDimBuffer',
		'SpvDimCube',
		'SpvDimRect',
		'SpvDimSubpassData',
		'SpvExecutionModeContractionOff',
		'SpvExecutionModeDepthGreater',
		'SpvExecutionModeDepthLess',
		'SpvExecutionModeDepthReplacing',
		'SpvExecutionModeDepthUnchanged',
		'SpvExecutionModeEarlyFragmentTests',
		'SpvExecutionModeInputLines',
		'SpvExecutionModeInputLinesAdjacency',
		'SpvExecutionModeInputPoints',
		'SpvExecutionModeInputTrianglesAdjacency',
		'SpvExecutionModeInvocations',
		'SpvExecutionModeIsolines',
		'SpvExecutionModeLocalSize',
		'SpvExecutionModeLocalSizeHint',
		'SpvExecutionModeOriginLowerLeft',
		'SpvExecutionModeOriginUpperLeft',
		'SpvExecutionModeOutputLineStrip',
		'SpvExecutionModeOutputPoints',
		'SpvExecutionModeOutputTriangleStrip',
		'SpvExecutionModeOutputVertices',
		'SpvExecutionModePixelCenterInteger',
		'SpvExecutionModePointMode',
		'SpvExecutionModeQuads',
		'SpvExecutionModeSpacingEqual',
		'SpvExecutionModeSpacingFractionalEven',
		'SpvExecutionModeSpacingFractionalOdd',
		'SpvExecutionModeTriangles',
		'SpvExecutionModeVecTypeHint',
		'SpvExecutionModeVertexOrderCcw',
		'SpvExecutionModeVertexOrderCw',
		'SpvExecutionModeXfb',
		'SpvExecutionModelFragment',
		'SpvExecutionModelGLCompute',
		'SpvExecutionModelGeometry',
		'SpvExecutionModelKernel',
		'SpvExecutionModelTessellationControl',
		'SpvExecutionModelTessellationEvaluation',
		'SpvExecutionModelVertex',
		'SpvFPFastMathModeAllowRecip',
		'SpvFPFastMathModeFast',
		'SpvFPFastMathModeNSZ',
		'SpvFPFastMathModeNotInf',
		'SpvFPFastMathModeNotNaN',
		'SpvFPRoundingModeRTE',
		'SpvFPRoundingModeRTN',
		'SpvFPRoundingModeRTP',
		'SpvFPRoundingModeRTZ',
		'SpvFunctionControlConst',
		'SpvFunctionControlDontInline',
		'SpvFunctionControlInline',
		'SpvFunctionControlPure',
		'SpvFunctionParameterAttributeByVal',
		'SpvFunctionParameterAttributeNoAlias',
		'SpvFunctionParameterAttributeNoCapture',
		'SpvFunctionParameterAttributeNoReadWrite',
		'SpvFunctionParameterAttributeNoWrite',
		'SpvFunctionParameterAttributeSext',
		'SpvFunctionParameterAttributeSret',
		'SpvFunctionParameterAttributeZext',
		'SpvGroupOperationExclusiveScan',
		'SpvGroupOperationInclusiveScan',
		'SpvGroupOperationReduce',
		'SpvImageChannelDataTypeFloat',
		'SpvImageChannelDataTypeHalfFloat',
		'SpvImageChannelDataTypeSignedInt16',
		'SpvImageChannelDataTypeSignedInt32',
		'SpvImageChannelDataTypeSignedInt8',
		'SpvImageChannelDataTypeSnormInt16',
		'SpvImageChannelDataTypeSnormInt8',
		'SpvImageChannelDataTypeUnormInt101010',
		'SpvImageChannelDataTypeUnormInt101010_2',
		'SpvImageChannelDataTypeUnormInt16',
		'SpvImageChannelDataTypeUnormInt24',
		'SpvImageChannelDataTypeUnormInt8',
		'SpvImageChannelDataTypeUnormShort555',
		'SpvImageChannelDataTypeUnormShort565',
		'SpvImageChannelDataTypeUnsignedInt16',
		'SpvImageChannelDataTypeUnsignedInt32',
		'SpvImageChannelDataTypeUnsignedInt8',
		'SpvImageChannelOrderA',
		'SpvImageChannelOrderARGB',
		'SpvImageChannelOrderBGRA',
		'SpvImageChannelOrderDepth',
		'SpvImageChannelOrderDepthStencil',
		'SpvImageChannelOrderIntensity',
		'SpvImageChannelOrderLuminance',
		'SpvImageChannelOrderR',
		'SpvImageChannelOrderRA',
		'SpvImageChannelOrderRG',
		'SpvImageChannelOrderRGB',
		'SpvImageChannelOrderRGBA',
		'SpvImageChannelOrderRGBx',
		'SpvImageChannelOrderRGx',
		'SpvImageChannelOrderRx',
		'SpvImageChannelOrdersBGRA',
		'SpvImageChannelOrdersRGB',
		'SpvImageChannelOrdersRGBA',
		'SpvImageChannelOrdersRGBx',
		'SpvImageFormatR11fG11fB10f',
		'SpvImageFormatR16',
		'SpvImageFormatR16Snorm',
		'SpvImageFormatR16f',
		'SpvImageFormatR16i',
		'SpvImageFormatR16ui',
		'SpvImageFormatR32f',
		'SpvImageFormatR32i',
		'SpvImageFormatR32ui',
		'SpvImageFormatR8',
		'SpvImageFormatR8Snorm',
		'SpvImageFormatR8i',
		'SpvImageFormatR8ui',
		'SpvImageFormatRg16',
		'SpvImageFormatRg16Snorm',
		'SpvImageFormatRg16f',
		'SpvImageFormatRg16i',
		'SpvImageFormatRg16ui',
		'SpvImageFormatRg32f',
		'SpvImageFormatRg32i',
		'SpvImageFormatRg32ui',
		'SpvImageFormatRg8',
		'SpvImageFormatRg8Snorm',
		'SpvImageFormatRg8i',
		'SpvImageFormatRg8ui',
		'SpvImageFormatRgb10A2',
		'SpvImageFormatRgb10a2ui',
		'SpvImageFormatRgba16',
		'SpvImageFormatRgba16Snorm',
		'SpvImageFormatRgba16f',
		'SpvImageFormatRgba16i',
		'SpvImageFormatRgba16ui',
		'SpvImageFormatRgba32f',
		'SpvImageFormatRgba32i',
		'SpvImageFormatRgba32ui',
		'SpvImageFormatRgba8',
		'SpvImageFormatRgba8Snorm',
		'SpvImageFormatRgba8i',
		'SpvImageFormatRgba8ui',
		'SpvImageFormatUnknown',
		'SpvImageOperandsBias',
		'SpvImageOperandsConstOffset',
		'SpvImageOperandsConstOffsets',
		'SpvImageOperandsGrad',
		'SpvImageOperandsLod',
		'SpvImageOperandsMinLod',
		'SpvImageOperandsOffset',
		'SpvImageOperandsSample',
		'SpvKernelEnqueueFlagsNoWait',
		'SpvKernelEnqueueFlagsWaitKernel',
		'SpvKernelEnqueueFlagsWaitWorkGroup',
		'SpvKernelProfilingInfoCmdExecTime',
		'SpvLinkageTypeExport',
		'SpvLinkageTypeImport',
		'SpvLoopControlDontUnroll',
		'SpvLoopControlUnroll',
		'SpvMagicNumber',
		'SpvMemoryAccessAligned',
		'SpvMemoryAccessNontemporal',
		'SpvMemoryAccessVolatile',
		'SpvMemoryModelGLSL450',
		'SpvMemoryModelOpenCL',
		'SpvMemoryModelSimple',
		'SpvMemorySemanticsAcquire',
		'SpvMemorySemanticsAcquireRelease',
		'SpvMemorySemanticsAtomicCounterMemory',
		'SpvMemorySemanticsCrossWorkgroupMemory',
		'SpvMemorySemanticsImageMemory',
		'SpvMemorySemanticsRelease',
		'SpvMemorySemanticsSequentiallyConsistent',
		'SpvMemorySemanticsSubgroupMemory',
		'SpvMemorySemanticsUniformMemory',
		'SpvMemorySemanticsWorkgroupMemory',
		'SpvOpAccessChain',
		'SpvOpAll',
		'SpvOpAny',
		'SpvOpArrayLength',
		'SpvOpAtomicAnd',
		'SpvOpAtomicCompareExchange',
		'SpvOpAtomicCompareExchangeWeak',
		'SpvOpAtomicExchange',
		'SpvOpAtomicFlagClear',
		'SpvOpAtomicFlagTestAndSet',
		'SpvOpAtomicIAdd',
		'SpvOpAtomicIDecrement',
		'SpvOpAtomicIIncrement',
		'SpvOpAtomicISub',
		'SpvOpAtomicLoad',
		'SpvOpAtomicOr',
		'SpvOpAtomicSMax',
		'SpvOpAtomicSMin',
		'SpvOpAtomicStore',
		'SpvOpAtomicUMax',
		'SpvOpAtomicUMin',
		'SpvOpAtomicXor',
		'SpvOpBitCount',
		'SpvOpBitFieldInsert',
		'SpvOpBitFieldSExtract',
		'SpvOpBitFieldUExtract',
		'SpvOpBitReverse',
		'SpvOpBitcast',
		'SpvOpBitwiseAnd',
		'SpvOpBitwiseOr',
		'SpvOpBitwiseXor',
		'SpvOpBranch',
		'SpvOpBranchConditional',
		'SpvOpBuildNDRange',
		'SpvOpCapability',
		'SpvOpCaptureEventProfilingInfo',
		'SpvOpCodeMask',
		'SpvOpCommitReadPipe',
		'SpvOpCommitWritePipe',
		'SpvOpCompositeConstruct',
		'SpvOpCompositeExtract',
		'SpvOpCompositeInsert',
		'SpvOpConstant',
		'SpvOpConstantComposite',
		'SpvOpConstantFalse',
		'SpvOpConstantNull',
		'SpvOpConstantSampler',
		'SpvOpConstantTrue',
		'SpvOpControlBarrier',
		'SpvOpConvertFToS',
		'SpvOpConvertFToU',
		'SpvOpConvertPtrToU',
		'SpvOpConvertSToF',
		'SpvOpConvertUToF',
		'SpvOpConvertUToPtr',
		'SpvOpCopyMemory',
		'SpvOpCopyMemorySized',
		'SpvOpCopyObject',
		'SpvOpCreateUserEvent',
		'SpvOpDPdx',
		'SpvOpDPdxCoarse',
		'SpvOpDPdxFine',
		'SpvOpDPdy',
		'SpvOpDPdyCoarse',
		'SpvOpDPdyFine',
		'SpvOpDecorate',
		'SpvOpDecorationGroup',
		'SpvOpDot',
		'SpvOpEmitStreamVertex',
		'SpvOpEmitVertex',
		'SpvOpEndPrimitive',
		'SpvOpEndStreamPrimitive',
		'SpvOpEnqueueKernel',
		'SpvOpEnqueueMarker',
		'SpvOpEntryPoint',
		'SpvOpExecutionMode',
		'SpvOpExtInst',
		'SpvOpExtInstImport',
		'SpvOpExtension',
		'SpvOpFAdd',
		'SpvOpFConvert',
		'SpvOpFDiv',
		'SpvOpFMod',
		'SpvOpFMul',
		'SpvOpFNegate',
		'SpvOpFOrdEqual',
		'SpvOpFOrdGreaterThan',
		'SpvOpFOrdGreaterThanEqual',
		'SpvOpFOrdLessThan',
		'SpvOpFOrdLessThanEqual',
		'SpvOpFOrdNotEqual',
		'SpvOpFRem',
		'SpvOpFSub',
		'SpvOpFUnordEqual',
		'SpvOpFUnordGreaterThan',
		'SpvOpFUnordGreaterThanEqual',
		'SpvOpFUnordLessThan',
		'SpvOpFUnordLessThanEqual',
		'SpvOpFUnordNotEqual',
		'SpvOpFunction',
		'SpvOpFunctionCall',
		'SpvOpFunctionEnd',
		'SpvOpFunctionParameter',
		'SpvOpFwidth',
		'SpvOpFwidthCoarse',
		'SpvOpFwidthFine',
		'SpvOpGenericCastToPtr',
		'SpvOpGenericCastToPtrExplicit',
		'SpvOpGenericPtrMemSemantics',
		'SpvOpGetDefaultQueue',
		'SpvOpGetKernelNDrangeMaxSubGroupSize',
		'SpvOpGetKernelNDrangeSubGroupCount',
		'SpvOpGetKernelPreferredWorkGroupSizeMultiple',
		'SpvOpGetKernelWorkGroupSize',
		'SpvOpGetMaxPipePackets',
		'SpvOpGetNumPipePackets',
		'SpvOpGroupAll',
		'SpvOpGroupAny',
		'SpvOpGroupAsyncCopy',
		'SpvOpGroupBroadcast',
		'SpvOpGroupCommitReadPipe',
		'SpvOpGroupCommitWritePipe',
		'SpvOpGroupDecorate',
		'SpvOpGroupFAdd',
		'SpvOpGroupFMax',
		'SpvOpGroupFMin',
		'SpvOpGroupIAdd',
		'SpvOpGroupMemberDecorate',
		'SpvOpGroupReserveReadPipePackets',
		'SpvOpGroupReserveWritePipePackets',
		'SpvOpGroupSMax',
		'SpvOpGroupSMin',
		'SpvOpGroupUMax',
		'SpvOpGroupUMin',
		'SpvOpGroupWaitEvents',
		'SpvOpIAdd',
		'SpvOpIAddCarry',
		'SpvOpIEqual',
		'SpvOpIMul',
		'SpvOpINotEqual',
		'SpvOpISub',
		'SpvOpISubBorrow',
		'SpvOpImage',
		'SpvOpImageDrefGather',
		'SpvOpImageFetch',
		'SpvOpImageGather',
		'SpvOpImageQueryFormat',
		'SpvOpImageQueryLevels',
		'SpvOpImageQueryLod',
		'SpvOpImageQueryOrder',
		'SpvOpImageQuerySamples',
		'SpvOpImageQuerySize',
		'SpvOpImageQuerySizeLod',
		'SpvOpImageRead',
		'SpvOpImageSampleDrefExplicitLod',
		'SpvOpImageSampleDrefImplicitLod',
		'SpvOpImageSampleExplicitLod',
		'SpvOpImageSampleImplicitLod',
		'SpvOpImageSampleProjDrefExplicitLod',
		'SpvOpImageSampleProjDrefImplicitLod',
		'SpvOpImageSampleProjExplicitLod',
		'SpvOpImageSampleProjImplicitLod',
		'SpvOpImageSparseDrefGather',
		'SpvOpImageSparseFetch',
		'SpvOpImageSparseGather',
		'SpvOpImageSparseRead',
		'SpvOpImageSparseSampleDrefExplicitLod',
		'SpvOpImageSparseSampleDrefImplicitLod',
		'SpvOpImageSparseSampleExplicitLod',
		'SpvOpImageSparseSampleImplicitLod',
		'SpvOpImageSparseSampleProjDrefExplicitLod',
		'SpvOpImageSparseSampleProjDrefImplicitLod',
		'SpvOpImageSparseSampleProjExplicitLod',
		'SpvOpImageSparseSampleProjImplicitLod',
		'SpvOpImageSparseTexelsResident',
		'SpvOpImageTexelPointer',
		'SpvOpImageWrite',
		'SpvOpInBoundsAccessChain',
		'SpvOpInBoundsPtrAccessChain',
		'SpvOpIsFinite',
		'SpvOpIsInf',
		'SpvOpIsNan',
		'SpvOpIsNormal',
		'SpvOpIsValidEvent',
		'SpvOpIsValidReserveId',
		'SpvOpKill',
		'SpvOpLabel',
		'SpvOpLessOrGreater',
		'SpvOpLifetimeStart',
		'SpvOpLifetimeStop',
		'SpvOpLine',
		'SpvOpLoad',
		'SpvOpLogicalAnd',
		'SpvOpLogicalEqual',
		'SpvOpLogicalNot',
		'SpvOpLogicalNotEqual',
		'SpvOpLogicalOr',
		'SpvOpLoopMerge',
		'SpvOpMatrixTimesMatrix',
		'SpvOpMatrixTimesScalar',
		'SpvOpMatrixTimesVector',
		'SpvOpMemberDecorate',
		'SpvOpMemberName',
		'SpvOpMemoryBarrier',
		'SpvOpMemoryModel',
		'SpvOpName',
		'SpvOpNoLine',
		'SpvOpNop',
		'SpvOpNot',
		'SpvOpOrdered',
		'SpvOpOuterProduct',
		'SpvOpPhi',
		'SpvOpPtrAccessChain',
		'SpvOpPtrCastToGeneric',
		'SpvOpQuantizeToF16',
		'SpvOpReadPipe',
		'SpvOpReleaseEvent',
		'SpvOpReserveReadPipePackets',
		'SpvOpReserveWritePipePackets',
		'SpvOpReservedReadPipe',
		'SpvOpReservedWritePipe',
		'SpvOpRetainEvent',
		'SpvOpReturn',
		'SpvOpReturnValue',
		'SpvOpSConvert',
		'SpvOpSDiv',
		'SpvOpSGreaterThan',
		'SpvOpSGreaterThanEqual',
		'SpvOpSLessThan',
		'SpvOpSLessThanEqual',
		'SpvOpSMod',
		'SpvOpSMulExtended',
		'SpvOpSNegate',
		'SpvOpSRem',
		'SpvOpSampledImage',
		'SpvOpSatConvertSToU',
		'SpvOpSatConvertUToS',
		'SpvOpSelect',
		'SpvOpSelectionMerge',
		'SpvOpSetUserEventStatus',
		'SpvOpShiftLeftLogical',
		'SpvOpShiftRightArithmetic',
		'SpvOpShiftRightLogical',
		'SpvOpSignBitSet',
		'SpvOpSource',
		'SpvOpSourceContinued',
		'SpvOpSourceExtension',
		'SpvOpSpecConstant',
		'SpvOpSpecConstantComposite',
		'SpvOpSpecConstantFalse',
		'SpvOpSpecConstantOp',
		'SpvOpSpecConstantTrue',
		'SpvOpStore',
		'SpvOpString',
		'SpvOpSwitch',
		'SpvOpTranspose',
		'SpvOpTypeArray',
		'SpvOpTypeBool',
		'SpvOpTypeDeviceEvent',
		'SpvOpTypeEvent',
		'SpvOpTypeFloat',
		'SpvOpTypeForwardPointer',
		'SpvOpTypeFunction',
		'SpvOpTypeImage',
		'SpvOpTypeInt',
		'SpvOpTypeMatrix',
		'SpvOpTypeOpaque',
		'SpvOpTypePipe',
		'SpvOpTypePointer',
		'SpvOpTypeQueue',
		'SpvOpTypeReserveId',
		'SpvOpTypeRuntimeArray',
		'SpvOpTypeSampledImage',
		'SpvOpTypeSampler',
		'SpvOpTypeStruct',
		'SpvOpTypeVector',
		'SpvOpTypeVoid',
		'SpvOpUConvert',
		'SpvOpUDiv',
		'SpvOpUGreaterThan',
		'SpvOpUGreaterThanEqual',
		'SpvOpULessThan',
		'SpvOpULessThanEqual',
		'SpvOpUMod',
		'SpvOpUMulExtended',
		'SpvOpUndef',
		'SpvOpUnordered',
		'SpvOpUnreachable',
		'SpvOpVariable',
		'SpvOpVectorExtractDynamic',
		'SpvOpVectorInsertDynamic',
		'SpvOpVectorShuffle',
		'SpvOpVectorTimesMatrix',
		'SpvOpVectorTimesScalar',
		'SpvOpWritePipe',
		'SpvRevision',
		'SpvSamplerAddressingModeClamp',
		'SpvSamplerAddressingModeClampToEdge',
		'SpvSamplerAddressingModeNone',
		'SpvSamplerAddressingModeRepeat',
		'SpvSamplerAddressingModeRepeatMirrored',
		'SpvSamplerFilterModeLinear',
		'SpvSamplerFilterModeNearest',
		'SpvScopeCrossDevice',
		'SpvScopeDevice',
		'SpvScopeInvocation',
		'SpvScopeSubgroup',
		'SpvScopeWorkgroup',
		'SpvSelectionControlDontFlatten',
		'SpvSelectionControlFlatten',
		'SpvSourceLanguageESSL',
		'SpvSourceLanguageGLSL',
		'SpvSourceLanguageOpenCL_C',
		'SpvSourceLanguageOpenCL_CPP',
		'SpvSourceLanguageUnknown',
		'SpvStorageClassAtomicCounter',
		'SpvStorageClassCrossWorkgroup',
		'SpvStorageClassFunction',
		'SpvStorageClassGeneric',
		'SpvStorageClassImage',
		'SpvStorageClassInput',
		'SpvStorageClassOutput',
		'SpvStorageClassPrivate',
		'SpvStorageClassPushConstant',
		'SpvStorageClassUniform',
		'SpvStorageClassUniformConstant',
		'SpvStorageClassWorkgroup',
		'SpvVersion',
		'SpvWordCountShift'
	],
	#category : #'Dastrel-SpirV'
}

{ #category : #'constant data' }
SpirVConstants class >> dataForAccessQualifier [
	^ #(
		ReadOnly 0
		WriteOnly 1
		ReadWrite 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForAddressingModel [
	^ #(
		Logical 0
		Physical32 1
		Physical64 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForBuiltIn [
	^ #(
		PatchVertices 14
		LocalInvocationId 27
		VertexId 5
		WorkgroupSize 25
		VertexIndex 42
		Layer 9
		PrimitiveId 7
		ClipDistance 3
		WorkgroupId 26
		SubgroupLocalInvocationId 41
		TessLevelInner 12
		ViewportIndex 10
		SubgroupSize 36
		GlobalOffset 33
		GlobalInvocationId 28
		InstanceId 6
		PointCoord 16
		EnqueuedWorkgroupSize 32
		HelperInvocation 23
		LocalInvocationIndex 29
		WorkDim 30
		CullDistance 4
		SamplePosition 19
		FrontFacing 17
		SubgroupId 40
		NumEnqueuedSubgroups 39
		InvocationId 8
		PointSize 1
		SampleMask 20
		SubgroupMaxSize 37
		Position 0
		TessCoord 13
		TessLevelOuter 11
		NumSubgroups 38
		SampleId 18
		FragDepth 22
		GlobalSize 31
		NumWorkgroups 24
		InstanceIndex 43
		FragCoord 15
		GlobalLinearId 34
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForCapability [
	^ #(
		Float16 9
		StorageImageExtendedFormats 49
		Matrix 0
		ImageRect 36
		Geometry 2
		Linkage 5
		Tessellation 3
		Int64 11
		Addresses 4
		ImageReadWrite 14
		GenericPointer 38
		SampleRateShading 35
		StorageImageArrayDynamicIndexing 31
		Int64Atomics 12
		Pipes 17
		ClipDistance 32
		Shader 1
		ImageQuery 50
		MultiViewport 57
		SampledBuffer 46
		Int16 22
		Int8 39
		MinLod 42
		StorageBufferArrayDynamicIndexing 30
		TessellationPointSize 23
		StorageImageWriteWithoutFormat 56
		ImageCubeArray 34
		GeometryPointSize 24
		CullDistance 33
		TransformFeedback 53
		ImageMipmap 15
		Image1D 44
		Sampled1D 43
		Vector16 7
		Kernel 6
		Float16Buffer 8
		StorageImageMultisample 27
		ImageBasic 13
		Float64 10
		SampledCubeArray 45
		ImageGatherExtended 25
		DeviceEnqueue 19
		Groups 18
		InputAttachment 40
		InterpolationFunction 52
		LiteralSampler 20
		SampledRect 37
		SampledImageArrayDynamicIndexing 29
		AtomicStorage 21
		SparseResidency 41
		ImageBuffer 47
		GeometryStreams 54
		DerivativeControl 51
		StorageImageReadWithoutFormat 55
		UniformBufferArrayDynamicIndexing 28
		ImageMSArray 48
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForDecoration [
	^ #(
		FPFastMathMode 40
		ColMajor 5
		InputAttachmentIndex 43
		Restrict 19
		LinkageAttributes 41
		SpecId 1
		NoPerspective 13
		Index 32
		ArrayStride 6
		Stream 29
		GLSLShared 8
		XfbBuffer 36
		XfbStride 37
		NoContraction 42
		GLSLPacked 9
		Coherent 23
		Block 2
		Sample 17
		BuiltIn 11
		Patch 15
		SaturatedConversion 28
		RelaxedPrecision 0
		Binding 33
		Flat 14
		Aliased 20
		Uniform 26
		NonReadable 25
		Component 31
		Constant 22
		MatrixStride 7
		Alignment 44
		DescriptorSet 34
		RowMajor 4
		Centroid 16
		Invariant 18
		NonWritable 24
		FPRoundingMode 39
		Offset 35
		Volatile 21
		BufferBlock 3
		CPacked 10
		FuncParamAttr 38
		Location 30
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForDim [
	^ #(
		SubpassData 6
		Dim2D 1
		Rect 4
		Cube 3
		Dim3D 2
		Buffer 5
		Dim1D 0
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForExecutionMode [
	^ #(
		InputLinesAdjacency 21
		LocalSize 17
		DepthReplacing 12
		OriginLowerLeft 8
		PointMode 10
		SpacingEqual 1
		Invocations 0
		SpacingFractionalEven 2
		EarlyFragmentTests 9
		PixelCenterInteger 6
		Triangles 22
		DepthUnchanged 16
		InputTrianglesAdjacency 23
		Quads 24
		OutputLineStrip 28
		OutputPoints 27
		VertexOrderCw 4
		DepthGreater 14
		OutputVertices 26
		InputLines 20
		OutputTriangleStrip 29
		VecTypeHint 30
		ContractionOff 31
		InputPoints 19
		OriginUpperLeft 7
		DepthLess 15
		VertexOrderCcw 5
		Xfb 11
		Isolines 25
		SpacingFractionalOdd 3
		LocalSizeHint 18
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForExecutionModel [
	^ #(
		Vertex 0
		Geometry 3
		Kernel 6
		Fragment 4
		TessellationControl 1
		TessellationEvaluation 2
		GLCompute 5
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForFPFastMathMode [
	^ #(
		NotInf 1
		Fast 4
		NSZ 2
		NotNaN 0
		AllowRecip 3
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForFPRoundingMode [
	^ #(
		RTE 0
		RTZ 1
		RTP 2
		RTN 3
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForFunctionControl [
	^ #(
		Inline 0
		Pure 2
		Const 3
		DontInline 1
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForFunctionParameterAttribute [
	^ #(
		NoAlias 4
		NoWrite 6
		Zext 0
		Sret 3
		Sext 1
		NoReadWrite 7
		NoCapture 5
		ByVal 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForGroupOperation [
	^ #(
		Reduce 0
		InclusiveScan 1
		ExclusiveScan 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForImageChannelDataType [
	^ #(
		SnormInt16 1
		UnsignedInt32 12
		UnormInt101010_2 16
		SignedInt16 8
		SignedInt8 7
		UnsignedInt8 10
		UnormInt101010 6
		UnormShort555 5
		UnsignedInt16 11
		Float 14
		UnormInt16 3
		SnormInt8 0
		SignedInt32 9
		HalfFloat 13
		UnormShort565 4
		UnormInt8 2
		UnormInt24 15
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForImageChannelOrder [
	^ #(
		R 0
		DepthStencil 14
		RA 3
		RGBx 12
		sRGBx 16
		ARGB 7
		A 1
		RGBA 5
		Rx 10
		Intensity 8
		RGB 4
		RGx 11
		sRGBA 17
		BGRA 6
		RG 2
		Luminance 9
		sBGRA 18
		Depth 13
		sRGB 15
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForImageFormat [
	^ #(
		R16ui 38
		Rg16Snorm 17
		R32i 24
		R32ui 33
		Rgba8 4
		Rg32f 6
		Rgba8Snorm 5
		Rg16 12
		R11fG11fB10f 8
		R8Snorm 20
		R16f 9
		Rg32i 25
		Rg8i 27
		R8i 29
		R8 15
		R16 14
		Rgba32f 1
		Rg16ui 36
		Rg8Snorm 18
		Rgb10a2ui 34
		R16i 28
		R8ui 39
		Rgba32i 21
		Rg16f 7
		Rgba16 10
		Rgba16Snorm 16
		Rg32ui 35
		Rgba8i 23
		Unknown 0
		Rg16i 26
		Rgba16ui 31
		Rg8 13
		Rg8ui 37
		Rgba16f 2
		Rgba32ui 30
		R32f 3
		Rgba16i 22
		R16Snorm 19
		Rgb10A2 11
		Rgba8ui 32
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForImageOperands [
	^ #(
		ConstOffset 3
		Sample 6
		MinLod 7
		Grad 2
		Bias 0
		Offset 4
		ConstOffsets 5
		Lod 1
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForKernelEnqueueFlags [
	^ #(
		WaitKernel 1
		NoWait 0
		WaitWorkGroup 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForKernelProfilingInfo [
	^ #(
		CmdExecTime 0
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForLinkageType [
	^ #(
		Export 0
		Import 1
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForLoopControl [
	^ #(
		Unroll 0
		DontUnroll 1
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForMemoryAccess [
	^ #(
		Aligned 1
		Volatile 0
		Nontemporal 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForMemoryModel [
	^ #(
		Simple 0
		GLSL450 1
		OpenCL 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForMemorySemantics [
	^ #(
		UniformMemory 6
		SequentiallyConsistent 4
		AcquireRelease 3
		CrossWorkgroupMemory 9
		Acquire 1
		ImageMemory 11
		AtomicCounterMemory 10
		SubgroupMemory 7
		WorkgroupMemory 8
		Release 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForOp [
	^ #(
		OpEndPrimitive 219
		OpFSub 131
		OpUndef 1
		OpImageQueryFormat 101
		OpExecutionMode 16
		OpGetDefaultQueue 303
		OpImageSparseSampleProjExplicitLod 310
		OpImageSampleProjDrefImplicitLod 93
		OpIEqual 170
		OpGroupUMin 267
		OpFOrdGreaterThanEqual 190
		OpStore 62
		OpGroupSMax 271
		OpFunction 54
		OpConvertSToF 111
		OpPtrAccessChain 67
		OpImageQueryLevels 106
		OpUConvert 113
		OpSourceContinued 2
		OpVectorExtractDynamic 77
		OpLogicalNotEqual 165
		OpMemoryModel 14
		OpImageQueryLod 105
		OpULessThan 176
		OpDPdxFine 210
		OpFOrdGreaterThan 186
		OpReservedReadPipe 276
		OpTypePipe 38
		OpGetKernelPreferredWorkGroupSizeMultiple 296
		OpDPdx 207
		OpSetUserEventStatus 301
		OpFunctionEnd 56
		OpDecorationGroup 73
		OpTypeQueue 37
		OpIAddCarry 149
		OpConvertFToU 109
		OpExtension 10
		OpDecorate 71
		OpControlBarrier 224
		OpFwidth 209
		OpAtomicAnd 240
		OpGroupWaitEvents 260
		OpRetainEvent 297
		OpImageSparseSampleImplicitLod 305
		OpSNegate 126
		OpImageSparseDrefGather 315
		OpNoLine 317
		OpMemberDecorate 72
		OpBranch 249
		OpTypeReserveId 36
		OpBitcast 124
		OpSource 3
		OpConvertUToF 112
		OpSpecConstantFalse 49
		OpGroupAsyncCopy 259
		OpGroupUMax 270
		OpPhi 245
		OpSLessThan 177
		OpWritePipe 275
		OpBitwiseOr 197
		OpCommitReadPipe 280
		OpImageSampleDrefImplicitLod 89
		OpGroupCommitWritePipe 288
		OpImage 100
		OpAtomicFlagClear 319
		OpDPdy 208
		OpAtomicISub 235
		OpAtomicXor 242
		OpGroupCommitReadPipe 287
		OpAll 155
		OpLogicalOr 166
		OpTypeRuntimeArray 29
		OpLabel 248
		OpAny 154
		OpTranspose 84
		OpMatrixTimesVector 145
		OpImageQuerySizeLod 103
		OpShiftRightArithmetic 195
		OpCreateUserEvent 299
		OpSatConvertUToS 119
		OpSRem 138
		OpVariable 59
		OpConstantNull 46
		OpUnordered 163
		OpISub 130
		OpSourceExtension 4
		OpMemberName 6
		OpEnqueueKernel 292
		OpUMulExtended 151
		OpImageSparseSampleProjImplicitLod 309
		OpImageFetch 95
		OpImageRead 98
		OpReadPipe 274
		OpTypeOpaque 31
		OpReturn 253
		OpUGreaterThanEqual 174
		OpFUnordNotEqual 183
		OpSwitch 251
		OpTypeStruct 30
		OpTypeSampledImage 27
		OpReserveReadPipePackets 278
		OpGetNumPipePackets 283
		OpImageSparseRead 320
		OpSatConvertSToU 118
		OpAtomicOr 241
		OpSpecConstant 50
		OpConvertPtrToU 117
		OpSampledImage 86
		OpSGreaterThan 173
		OpEntryPoint 15
		OpTypePointer 32
		OpUnreachable 255
		OpGenericCastToPtrExplicit 123
		OpAtomicLoad 227
		OpArrayLength 68
		OpLifetimeStop 257
		OpIsInf 157
		OpLogicalAnd 167
		OpGroupMemberDecorate 75
		OpIsFinite 158
		OpGroupReserveWritePipePackets 286
		OpShiftRightLogical 194
		OpReservedWritePipe 277
		OpReserveWritePipePackets 279
		OpDot 148
		OpImageSparseSampleDrefExplicitLod 308
		OpImageQueryOrder 102
		OpFDiv 136
		OpFMod 141
		OpImageQuerySize 104
		OpBitwiseAnd 199
		OpBitFieldUExtract 203
		OpVectorTimesScalar 142
		OpLoad 61
		OpFUnordLessThanEqual 189
		OpAtomicIIncrement 232
		OpImageSparseSampleProjDrefExplicitLod 312
		OpTypeFloat 22
		OpConstant 43
		OpBitFieldInsert 201
		OpCopyMemorySized 64
		OpImageTexelPointer 60
		OpFAdd 129
		OpCommitWritePipe 281
		OpTypeEvent 34
		OpOuterProduct 147
		OpSpecConstantTrue 48
		OpBitwiseXor 198
		OpFUnordLessThan 185
		OpTypeInt 21
		OpVectorInsertDynamic 78
		OpEmitVertex 218
		OpSelectionMerge 247
		OpGenericPtrMemSemantics 69
		OpImageDrefGather 97
		OpGetKernelNDrangeMaxSubGroupSize 294
		OpVectorTimesMatrix 144
		OpULessThanEqual 178
		OpVectorShuffle 79
		OpBuildNDRange 304
		OpFwidthFine 212
		OpSpecConstantComposite 51
		OpReleaseEvent 298
		OpKill 252
		OpFOrdNotEqual 182
		OpGetMaxPipePackets 284
		OpTypeMatrix 24
		OpTypeBool 20
		OpGroupFAdd 265
		OpNop 0
		OpCopyObject 83
		OpImageQuerySamples 107
		OpAtomicIDecrement 233
		OpMatrixTimesScalar 143
		OpIsValidReserveId 282
		OpTypeImage 25
		OpImageSampleProjExplicitLod 92
		OpImageSparseSampleDrefImplicitLod 307
		OpCaptureEventProfilingInfo 302
		OpGroupReserveReadPipePackets 285
		OpReturnValue 254
		OpGetKernelNDrangeSubGroupCount 293
		OpAtomicIAdd 234
		OpFUnordGreaterThanEqual 191
		OpGetKernelWorkGroupSize 295
		OpCopyMemory 63
		OpLogicalEqual 164
		OpConstantComposite 44
		OpMemoryBarrier 225
		OpAtomicCompareExchange 230
		OpString 7
		OpSelect 169
		OpINotEqual 171
		OpUGreaterThan 172
		OpQuantizeToF16 116
		OpTypeDeviceEvent 35
		OpShiftLeftLogical 196
		OpIsValidEvent 300
		OpSConvert 114
		OpTypeSampler 26
		OpTypeFunction 33
		OpSDiv 135
		OpCompositeExtract 81
		OpTypeVoid 19
		OpSMod 139
		OpAccessChain 65
		OpImageSparseSampleProjDrefImplicitLod 311
		OpTypeForwardPointer 39
		OpImageSparseFetch 313
		OpImageSparseTexelsResident 316
		OpGroupBroadcast 263
		OpIAdd 128
		OpMatrixTimesMatrix 146
		OpDPdxCoarse 213
		OpExtInst 12
		OpGroupFMin 266
		OpFunctionCall 57
		OpSignBitSet 160
		OpDPdyCoarse 214
		OpImageGather 96
		OpISubBorrow 150
		OpBitReverse 204
		OpFwidthCoarse 215
		OpAtomicCompareExchangeWeak 231
		OpUDiv 134
		OpCompositeInsert 82
		OpInBoundsAccessChain 66
		OpUMod 137
		OpSpecConstantOp 52
		OpSGreaterThanEqual 175
		OpFOrdEqual 180
		OpConstantTrue 41
		OpLifetimeStart 256
		OpFOrdLessThan 184
		OpFMul 133
		OpAtomicSMin 236
		OpImageSampleExplicitLod 88
		OpLine 8
		OpConstantSampler 45
		OpIMul 132
		OpFunctionParameter 55
		OpGroupIAdd 264
		OpGroupFMax 269
		OpEnqueueMarker 291
		OpBitCount 205
		OpFNegate 127
		OpImageSparseGather 314
		OpImageSampleProjImplicitLod 91
		OpImageSampleProjDrefExplicitLod 94
		OpExtInstImport 11
		OpBranchConditional 250
		OpFUnordGreaterThan 187
		OpEmitStreamVertex 220
		OpEndStreamPrimitive 221
		OpFOrdLessThanEqual 188
		OpAtomicUMin 237
		OpGenericCastToPtr 122
		OpOrdered 162
		OpAtomicSMax 238
		OpGroupAll 261
		OpImageSparseSampleExplicitLod 306
		OpAtomicStore 228
		OpLogicalNot 168
		OpGroupAny 262
		OpSLessThanEqual 179
		OpAtomicExchange 229
		OpAtomicFlagTestAndSet 318
		OpTypeVector 23
		OpPtrCastToGeneric 121
		OpGroupDecorate 74
		OpInBoundsPtrAccessChain 70
		OpIsNan 156
		OpCompositeConstruct 80
		OpNot 200
		OpConvertFToS 110
		OpDPdyFine 211
		OpImageWrite 99
		OpFConvert 115
		OpConstantFalse 42
		OpImageSampleDrefExplicitLod 90
		OpAtomicUMax 239
		OpGroupSMin 268
		OpTypeArray 28
		OpSMulExtended 152
		OpFRem 140
		OpFUnordEqual 181
		OpIsNormal 159
		OpLessOrGreater 161
		OpLoopMerge 246
		OpImageSampleImplicitLod 87
		OpBitFieldSExtract 202
		OpName 5
		OpConvertUToPtr 120
		OpCapability 17
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForSamplerAddressingMode [
	^ #(
		Clamp 2
		None 0
		ClampToEdge 1
		Repeat 3
		RepeatMirrored 4
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForSamplerFilterMode [
	^ #(
		Nearest 0
		Linear 1
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForScope [
	^ #(
		Device 1
		Workgroup 2
		Invocation 4
		CrossDevice 0
		Subgroup 3
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForSelectionControl [
	^ #(
		DontFlatten 1
		Flatten 0
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForSourceLanguage [
	^ #(
		OpenCL_C 3
		OpenCL_CPP 4
		ESSL 1
		Unknown 0
		GLSL 2
	)
]

{ #category : #'constant data' }
SpirVConstants class >> dataForStorageClass [
	^ #(
		PushConstant 9
		CrossWorkgroup 5
		Private 6
		AtomicCounter 10
		UniformConstant 0
		Input 1
		Image 11
		Function 7
		Uniform 2
		Output 3
		Workgroup 4
		Generic 8
	)
]

{ #category : #'constant data' }
SpirVConstants class >> enumNames [
	^ #(
		SourceLanguage
		ExecutionModel
		AddressingModel
		MemoryModel
		ExecutionMode
		StorageClass
		Dim
		SamplerAddressingMode
		SamplerFilterMode
		ImageFormat
		ImageChannelOrder
		ImageChannelDataType
		ImageOperands
		FPFastMathMode
		FPRoundingMode
		LinkageType
		AccessQualifier
		FunctionParameterAttribute
		Decoration
		BuiltIn
		SelectionControl
		LoopControl
		FunctionControl
		MemorySemantics
		MemoryAccess
		Scope
		GroupOperation
		KernelEnqueueFlags
		KernelProfilingInfo
		Capability
		Op
	)

]

{ #category : #initialization }
SpirVConstants class >> initialize [
	"
	self initialize
	"
	| enumData fullName |
	super initialize.
	
	SpvMagicNumber := 16r07230203.
	SpvVersion := 16r00010000.
	SpvRevision := 3.
	SpvOpCodeMask := 16rffff.
	SpvWordCountShift := 16.
	
	self enumNames do: [ :enumName |
		enumData := self perform: (#dataFor , enumName) asSymbol.
		Transcript show: enumData; cr.
		enumData pairsDo: [ :constantName :value |
			fullName := (constantName beginsWith: enumName)
				ifTrue: [ ('Spv' , constantName) asSymbol ]
				ifFalse: [ ('Spv' , enumName, constantName) asSymbol ].
			
			(self hasClassVarNamed: fullName) ifFalse: [ 
				self addClassVarNamed: fullName.
			].
			self writeClassVariableNamed: fullName value: value
		].
	].
]