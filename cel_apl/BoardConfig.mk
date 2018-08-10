# ----------------- BEGIN MIX-IN DEFINITIONS -----------------
# Mix-In definitions are auto-generated by mixin-update
##############################################################
# Source: device/intel/project-celadon/mixins/groups/device-specific/cel_apl/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_DEVICE)/project-celadon/overlay

BOARD_USERDATAIMAGE_PARTITION_SIZE := 1073741824

BOARD_KERNEL_CMDLINE += lpj=1600000 reboot_panic=p,w

INTEL_HWC_ALWAYS_BUILD := false

DEVICE_MANIFEST_FILE := $(INTEL_PATH_DEVICE)/cel_apl/manifest.xml

# Disable ota
TARGET_SKIP_OTA_PACKAGE := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/disk-bus/auto/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/set_storage
##############################################################
# Source: device/intel/project-celadon/mixins/groups/boot-arch/efi/BoardConfig.mk
##############################################################
#
# -- OTA RELATED DEFINES --
#

# tell build system where to get the recovery.fstab.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab.recovery

# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= $(INTEL_PATH_HARDWARE)/bootctrl/recovery

# Adds edify commands swap_entries and copy_partition for robust
# update of the EFI system partition
#TARGET_RECOVERY_UPDATER_LIBS := libupdater_esp
# Extra libraries needed to be rolled into recovery updater
# libgpt_static and libefivar are needed by libupdater_esp
#TARGET_RECOVERY_UPDATER_EXTRA_LIBS := libcommon_recovery libgpt_static libefivar

# By default recovery minui expects RGBA framebuffer
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


#
# FILESYSTEMS
#

# NOTE: These values must be kept in sync with BOARD_GPT_INI
BOARD_SYSTEMIMAGE_PARTITION_SIZE ?= 3221225472
BOARD_TOSIMAGE_PARTITION_SIZE := 10485760
BOARD_BOOTLOADER_PARTITION_SIZE ?= $$((33 * 1024 * 1024))
BOARD_BOOTLOADER_BLOCK_SIZE := 4096
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE ?= 104857600
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

ifeq ($(BOARD_FLASH_UFS), 1)
BOARD_FLASH_BLOCK_SIZE = 4096
else
BOARD_FLASH_BLOCK_SIZE := 512
endif

# Partition table configuration file
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini

TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

#
#kernel always use primary gpt without command line option "gpt",
#the label let kernel use the alternate GPT if primary GPT is corrupted.
#
BOARD_KERNEL_CMDLINE += gpt

#
# Trusted Factory Reset - persistent partition
#
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_HARDWARE)/bootctrl/boot/overlay

#can't use := here, as PRODUCT_OUT is not defined yet
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(BOARD_GPT_BIN):gpt.bin
INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_BIN)

# We offer the possibility to flash from a USB storage device using
# the "installer" EFI application
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(INTEL_PATH_HARDWARE)/bootctrl/boot/startup.nsh



BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/boot-arch/generic


KERNELFLINGER_USE_RPMB_SIMULATE := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/wlan/iwlwifi/BoardConfig.mk
##############################################################
# This enables the wpa wireless driver
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_2_1_DEVEL

# Enabling iwlwifi
BOARD_USING_INTEL_IWL := true
INTEL_IWL_MODULE_SUB_FOLDER := dev
INTEL_IWL_PLATFORM := celadon
INTEL_IWL_BOARD_CONFIG := kbl
INTEL_IWL_PNVM_HW := DEFAULT
INTEL_IWL_USE_COMPAT_INSTALL := y
INTEL_IWL_COMPAT_INSTALL_DIR := updates
INTEL_IWL_COMPAT_INSTALL_PATH ?= .
INTEL_IWL_INSTALL_MOD_STRIP := INSTALL_MOD_STRIP=1
CROSS_COMPILE ?= CROSS_COMPILE=$(YOCTO_CROSSCOMPILE)
INSTALLED_KERNEL_TARGET ?= $(PREVIOUS_KERNEL_MODULE)
KERNEL_OUT_DIR ?= $(PRODUCT_OUT)/obj/kernel

COMBO_CHIP_VENDOR := intel
COMBO_CHIP := lnp

# SoftAp FW reload definitions.
# we don't really need this, it's to avoid error when the framework
# will trigger the fwReloadSoftap function, what will lead to an error
# enabling the SoftAp.
# so we set up this for letting the function execute gracefully.
WIFI_DRIVER_FW_PATH_STA := "/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_AP  := "/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_P2P := "/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_PARAM := "/dev/null"

# config_wifi_background_scan_support=true:
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-pno

DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-tcp-buffers

# Add SIM , AKA and AKA' methods in EAP entries of WiFi UI
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-eap-methods

ifneq (lhp,$(INTEL_IWL_MODULE_SUB_FOLDER))
    DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-dual-band
endif

# WiDi / Miracast Optimisations
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-miracast-go
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-p2p-connected-stop-scan
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/wlan/overlay-miracast-force-single-ch

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/wlan/load_iwlwifi


BOARD_SEPOLICY_M4DEFS += module_iwlwifi=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/wlan/iwlwifi
##############################################################
# Source: device/intel/project-celadon/mixins/groups/kernel/gmin64/BoardConfig.mk.1
##############################################################
TARGET_USES_64_BIT_BINDER := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/kernel/gmin64/BoardConfig.mk
##############################################################
# Specify location of board-specific kernel headers
TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/kernel/4.14/kernel-headers

ifneq ($(TARGET_BUILD_VARIANT),user)
KERNEL_LOGLEVEL ?= 7
else
KERNEL_LOGLEVEL ?= 2
endif

ifeq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=tty0
endif

BOARD_KERNEL_CMDLINE += \
        loglevel=$(KERNEL_LOGLEVEL) \
        androidboot.hardware=$(TARGET_DEVICE)\
        firmware_class.path=/vendor/firmware


BOARD_SEPOLICY_M4DEFS += module_kernel=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/kernel
##############################################################
# Source: device/intel/project-celadon/mixins/groups/sepolicy/permissive/BoardConfig.mk.1
##############################################################
# start kernel in permissive mode, this way we don't
# need 'setenforce 0' from init.rc files
BOARD_KERNEL_CMDLINE += enforcing=0 androidboot.selinux=permissive
##############################################################
# Source: device/intel/project-celadon/mixins/groups/sepolicy/permissive/BoardConfig.mk
##############################################################
# SELinux Policy
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)

##############################################################
# Source: device/intel/project-celadon/mixins/groups/graphics/mesa/BoardConfig.mk
##############################################################
# Use external/drm-bxt
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= intel

BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 drm.vblankoffdelay=1 i915.fastboot=1
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_INTEL_UFO_DRIVER := false
BOARD_GPU_DRIVERS := i965
BOARD_USE_CUSTOMIZED_MESA := true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

BOARD_GPU_DRIVERS ?= i965 swrast
ifneq ($(strip $(BOARD_GPU_DRIVERS)),)
TARGET_HARDWARE_3D := true
TARGET_USES_HWC2 := true
endif


BOARD_USES_DRM_HWCOMPOSER := false
BOARD_USES_IA_HWCOMPOSER := true

BOARD_USES_MINIGBM := true
BOARD_ENABLE_EXPLICIT_SYNC := true
INTEL_MINIGBM := $(INTEL_PATH_HARDWARE)/external/minigbm-intel


BOARD_USES_GRALLOC1 := true



BOARD_CURSOR_WA := false

BOARD_THREEDIS_UNDERRUN_WA := true


BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/mesa

##############################################################
# Source: device/intel/project-celadon/mixins/groups/cpu-arch/slm/BoardConfig.mk.1
##############################################################
ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
# 64b-specific items:
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := silvermont
TARGET_2ND_CPU_VARIANT := silvermont
else
# 32b-specific items:
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/cpu-arch/slm/BoardConfig.mk
##############################################################
# Items that are common between slm 32b and 64b:
TARGET_CPU_ABI_LIST_32_BIT := x86
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_SMP := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/serialport/ttyS1/BoardConfig.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=ttyS1,115200n8
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/vendor-partition/true/BoardConfig.mk
##############################################################
# Those 3 lines are required to enable vendor image generation.
# Remove them if vendor partition is not used.
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := $(shell echo 700*1048576 | bc)
##############################################################
# Source: device/intel/project-celadon/mixins/groups/trusty/true/BoardConfig.mk
##############################################################
TARGET_USE_TRUSTY := true

ifneq (, $(filter abl sbl, efi))
TARGET_USE_MULTIBOOT := true
endif

BOARD_USES_TRUSTY := true
BOARD_USES_KEYMASTER1 := true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/trusty
BOARD_SEPOLICY_M4DEFS += module_trusty=true

LKBUILD_TOOLCHAIN_ROOT = $(PWD)/$(INTEL_PATH_VENDOR)/external/prebuilts/elf/
LKBUILD_X86_TOOLCHAIN = $(LKBUILD_TOOLCHAIN_ROOT)i386-elf-4.9.1-Linux-x86_64/bin
LKBUILD_X64_TOOLCHAIN = $(LKBUILD_TOOLCHAIN_ROOT)x86_64-elf-4.9.1-Linux-x86_64/bin
TRUSTY_BUILDROOT = $(PWD)/$(PRODUCT_OUT)/obj/trusty/

TRUSTY_ENV_VAR += TRUSTY_REF_TARGET=project-celadon_64

#for trusty lk
TRUSTY_ENV_VAR += BUILDROOT=$(TRUSTY_BUILDROOT)
TRUSTY_ENV_VAR += PATH=$$PATH:$(LKBUILD_X86_TOOLCHAIN):$(LKBUILD_X64_TOOLCHAIN)
TRUSTY_ENV_VAR += CLANG_BINDIR=$(PWD)/$(LLVM_PREBUILTS_PATH)
TRUSTY_ENV_VAR += ARCH_x86_64_TOOLCHAIN_PREFIX=${PWD}/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-${TARGET_GCC_VERSION}/bin/x86_64-linux-android-

#for trusty vmm
# use same toolchain as android kernel
TRUSTY_ENV_VAR += COMPILE_TOOLCHAIN=$(YOCTO_CROSSCOMPILE)
TRUSTY_ENV_VAR += TARGET_BUILD_VARIANT=$(TARGET_BUILD_VARIANT)
TRUSTY_ENV_VAR += BOOT_ARCH=efi

# output build dir to android out folder
TRUSTY_ENV_VAR += BUILD_DIR=$(TRUSTY_BUILDROOT)
TRUSTY_ENV_VAR += LKBIN_DIR=$(TRUSTY_BUILDROOT)/build-sand-x86-64/

#Fix the cpu hotplug fail due to the trusty.
#Trusty will introduce some delay for cpu_up().
#Experiment show need wait at least 60us after
#apic_icr_write(APIC_DM_STARTUP | (start_eip >> 12), phys_apicid);
#So here override the cpu_init_udelay to have the cpu wait for 300us
#to guarantee the cpu_up success.
BOARD_KERNEL_CMDLINE += cpu_init_udelay=10

#TOS_PREBUILT := $(PWD)/$(INTEL_PATH_VENDOR)/fw/evmm/tos.img
#EVMM_PREBUILT := $(PWD)/$(INTEL_PATH_VENDOR)/fw/evmm/multiboot.img
##############################################################
# Source: device/intel/project-celadon/mixins/groups/flashfiles/ini/BoardConfig.mk
##############################################################
FLASHFILES_CONFIG ?= $(TARGET_DEVICE_DIR)/flashfiles.ini
USE_INTEL_FLASHFILES := true
VARIANT_SPECIFIC_FLASHFILES ?= false
FAST_FLASHFILES := false
##############################################################
# Source: device/intel/project-celadon/mixins/groups/widevine/L3_Gen/BoardConfig.mk
##############################################################
BOARD_USE_INTEL_OEMCRYPTO := true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/widevine/gen/gen_common

##############################################################
# Source: device/intel/project-celadon/mixins/groups/media/mesa/BoardConfig.mk
##############################################################
INTEL_STAGEFRIGHT := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
USE_MEDIASDK := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/hdcpd/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/hdcpd
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-logs/true/BoardConfig.mk
##############################################################
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
BOARD_KERNEL_CMDLINE += nokaslr
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/pstore/ram_dummy/BoardConfig.mk.1
##############################################################
BOARD_KERNEL_CMDLINE += pstore.backend=ramoops
##############################################################
# Source: device/intel/project-celadon/mixins/groups/pstore/ram_dummy/BoardConfig.mk.2
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/pstore
##############################################################
# Source: device/intel/project-celadon/mixins/groups/pstore/ram_dummy/BoardConfig.mk
##############################################################
BOARD_KERNEL_CMDLINE += \
	ramoops.record_size=0x4000

BOARD_KERNEL_CMDLINE += \
	ramoops.console_size=0x200000

BOARD_KERNEL_CMDLINE += \
	ramoops.ftrace_size=0x2000

BOARD_KERNEL_CMDLINE += \
	ramoops.dump_oops=1

##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-dvc_desc/npk/BoardConfig.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/dvc_desc
endif

##############################################################
# Source: device/intel/project-celadon/mixins/groups/bluetooth/btusb/BoardConfig.mk
##############################################################
BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_LINUX := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(INTEL_PATH_COMMON)/bluetooth/intel/car/
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan
BOARD_HAVE_BLUETOOTH_INTEL_ICNV := true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bluetooth/common

##############################################################
# Source: device/intel/project-celadon/mixins/groups/config-partition/true/BoardConfig.mk
##############################################################
BOARD_CONFIGIMAGE_PARTITION_SIZE := 8388608
BOARD_SEPOLICY_M4DEFS += module_config_partition=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/config-partition
##############################################################
# Source: device/intel/project-celadon/mixins/groups/dexpreopt/enabled/BoardConfig.mk
##############################################################
# enable dex-preoptimization.
WITH_DEXPREOPT := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/rfkill/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/rfkill
##############################################################
# Source: device/intel/project-celadon/mixins/groups/audio/project-celadon/BoardConfig.mk
##############################################################
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_GENERIC_AUDIO ?= false
USE_CUSTOM_PARAMETER_FRAMEWORK := false
ifneq ($(BOARD_USES_GENERIC_AUDIO), true)
# Audio HAL selection Flag default setting.
#  INTEL_AUDIO_HAL:= audio     -> baseline HAL
#  INTEL_AUDIO_HAL:= audio_pfw -> PFW-based HAL
INTEL_AUDIO_HAL := audio
else
INTEL_AUDIO_HAL := stub
endif

# Use XML audio policy configuration file
USE_XML_AUDIO_POLICY_CONF ?= 1
# Use configurable audio policy
USE_CONFIGURABLE_AUDIO_POLICY ?= 1
##############################################################
# Source: device/intel/project-celadon/mixins/groups/usb-gadget/configfs/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/usb-gadget/configfs
##############################################################
# Source: device/intel/project-celadon/mixins/groups/navigationbar/true/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/navigationbar/overlay

##############################################################
# Source: device/intel/project-celadon/mixins/groups/device-type/car/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += \
    packages/services/Car/car_product/sepolicy \
    device/generic/car/common/sepolicy \
    $(INTEL_PATH_SEPOLICY)/car

TARGET_USES_CAR_FUTURE_FEATURES := true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-crashlogd/true/BoardConfig.mk
##############################################################
ifeq ($(MIXIN_DEBUG_LOGS),true)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/crashlogd
BOARD_SEPOLICY_M4DEFS += module_debug_crashlogd=true
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debug-phonedoctor/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_M4DEFS += module_debug_phonedoctor=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debug-phonedoctor
##############################################################
# Source: device/intel/project-celadon/mixins/groups/factory-scripts/true/BoardConfig.mk
##############################################################
# Include factory archive in 'make dist' output
TARGET_BUILD_INTEL_FACTORY_SCRIPTS := true

##############################################################
# Source: device/intel/project-celadon/mixins/groups/memtrack/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/memtrack
##############################################################
# Source: device/intel/project-celadon/mixins/groups/security/cse/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/security
##############################################################
# Source: device/intel/project-celadon/mixins/groups/debugfs/default/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debugfs
##############################################################
# Source: device/intel/project-celadon/mixins/groups/factory-partition/true/BoardConfig.mk
##############################################################
BOARD_FACTORYIMAGE_PARTITION_SIZE := 10485760
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/factory-partition
BOARD_SEPOLICY_M4DEFS += module_factory_partition=true
##############################################################
# Source: device/intel/project-celadon/mixins/groups/aosp_carrier-config/default/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/ims/carrier/res_ims
##############################################################
# Source: device/intel/project-celadon/mixins/groups/autodetect/default/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/autodetect/false
##############################################################
# Source: device/intel/project-celadon/mixins/groups/cpuset/default/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/config_cpuset
##############################################################
# Source: device/intel/project-celadon/mixins/groups/embms/default/BoardConfig.mk
##############################################################
#setting for embms dep in framework
TARGET_HAS_EMBMS_ENABLE := false
##############################################################
# Source: device/intel/project-celadon/mixins/groups/filesystem_config/default/BoardConfig.mk
##############################################################
TARGET_FS_CONFIG_GEN += $(INTEL_PATH_COMMON)/filesystem_config/config.fs
##############################################################
# Source: device/intel/project-celadon/mixins/groups/ioc/default/BoardConfig.mk
##############################################################
ifeq (none,cbc)
IOC_USE_CBC := true
endif
##############################################################
# Source: device/intel/project-celadon/mixins/groups/jpeg-turbo/default/BoardConfig.mk
##############################################################
USE_JPEG_TURBO := no
##############################################################
# Source: device/intel/project-celadon/mixins/groups/load_modules/default/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS +=  $(INTEL_PATH_SEPOLICY)/load_modules

TARGET_FS_CONFIG_GEN += $(INTEL_PATH_COMMON)/load_modules/filesystem_config/config.fs

# ------------------ END MIX-IN DEFINITIONS ------------------
