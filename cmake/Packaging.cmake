cmake_minimum_required(VERSION 3.26)

find_program(MAKENSIS makensis
    PATHS
        "C:/Program Files (x86)/NSIS"
        "C:/Program Files/NSIS"
    DOC "Path to makensis.exe"
)

if(NOT MAKENSIS)
    message(WARNING
        "makensis not found — the 'installer' target will not be available. "
        "Install NSIS 3.x from https://nsis.sourceforge.io/")
endif()

set(BIBBLE_INSTALL_STAGING "${CMAKE_INSTALL_PREFIX}")
set(BIBBLE_INSTALLER_OUT
    "${CMAKE_CURRENT_BINARY_DIR}/BibbleSDK-${BIBBLE_SDK_VERSION}-win64.exe"
)

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/installer.nsi.in"
    "${CMAKE_CURRENT_BINARY_DIR}/installer.nsi"
    @ONLY
)

if (MAKENSIS)
    add_custom_target(installer
        COMMAND "${MAKENSIS}" /V2 "${CMAKE_CURRENT_BINARY_DIR}/installer.nsi"
        COMMENT "Building NSIS installer → ${BIBBLE_INSTALLER_OUT}"
        VERBATIM)
endif()