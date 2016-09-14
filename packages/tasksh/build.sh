TERMUX_PKG_HOMEPAGE=https://taskwarrior.org
TERMUX_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
TERMUX_PKG_VERSION=1.1.0
TERMUX_PKG_BUILD_REVISION=1
TERMUX_PKG_SRCURL=http://taskwarrior.org/download/tasksh-latest.tar.gz
TERMUX_PKG_SHA256=eef7c6677d6291b1c0e13595e8c9606d7f8dc1060d197a0d088cc1fddcb70024
TERMUX_PKG_DEPENDS="readline, taskwarrior, libandroid-glob"
TERMUX_PKG_FOLDERNAME=tasksh-$TERMUX_PKG_VERSION

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

termux_step_configure () {
	cd $TERMUX_PKG_BUILDDIR
	cmake -G "Unix Makefiles" $TERMUX_PKG_SRCDIR \
		-DCMAKE_AR=`which ${TERMUX_HOST_PLATFORM}-ar` \
		-DCMAKE_BUILD_TYPE=MinSizeRel \
		-DCMAKE_C_FLAGS="$CFLAGS $CPPFLAGS" \
		-DCMAKE_CROSSCOMPILING=True \
		-DCMAKE_CXX_FLAGS="$CXXFLAGS" \
		-DCMAKE_FIND_ROOT_PATH=$TERMUX_PREFIX \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_INSTALL_PREFIX=$TERMUX_PREFIX \
		-DCMAKE_LINKER=`which ${TERMUX_HOST_PLATFORM}-ld` \
		-DCMAKE_MAKE_PROGRAM=`which make` \
		-DCMAKE_RANLIB=`which ${TERMUX_HOST_PLATFORM}-ranlib` \
		-DCMAKE_SKIP_INSTALL_RPATH=ON \
		-DCMAKE_SYSTEM_NAME=Linux \
		$TERMUX_PKG_SRCDIR
}
