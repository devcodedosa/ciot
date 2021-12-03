OPENWRT_GIT_REPO = https://github.com/openwrt/openwrt.git
#OPENWRT_GIT_COMMIT_REV = a0ef42e77c367312df7edc78dbd0d18a3faf9808
OPENWRT_GIT_COMMIT_REV = remotes/origin/openwrt-18.06
DIR_OPENWRT = openwrt
DIR_OUTPUT = out
DEFCONFIG_FILE = rpi3_bplus_defconfig
ROOT = $(shell pwd)
TARGET = target-aarch64_cortex-a53_musl
BUILD_DIR = linux-bcm27xx_bcm2710
FW_NAME = openwrt-brcm2708-bcm2710-rpi-3-ext4-sysupgrade.img.gz


all : prepare build out

.PHONY: prepare
prepare :
	@if [ ! -d $(DIR_OPENWRT) ]; then \
		echo "Create OpenWRT Build Directory....."; \
		git config --global http.sslverify false; \
		git clone $(OPENWRT_GIT_REPO) $(DIR_OPENWRT); \
		cp config/$(DEFCONFIG_FILE) $(DIR_OPENWRT); \
		cd $(DIR_OPENWRT); \
		git checkout $(OPENWRT_GIT_COMMIT_REV); \
		./scripts/feeds update -a; \
		./scripts/feeds install -a; \
		cp $(DEFCONFIG_FILE) .config; \
		make defconfig && make oldconfig; \
	fi

.PHONY: build
build :
	make V=99 -C $(DIR_OPENWRT)

.PHONY: out
out :
	mkdir -p $(DIR_OUTPUT)
	cp $(DIR_OPENWRT)/bin/targets/brcm2708/bcm2710/$(FW_NAME) $(DIR_OUTPUT)

.PHONY: clean
clean :
	make -C $(DIR_OPENWRT) clean
	rm -rf $(DIR_OUTPUT)

.PHONY: distclean
distclean :
	rm -rf $(DIR_OPENWRT) $(DIR_OUTPUT)

