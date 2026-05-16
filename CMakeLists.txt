cmake_minimum_required(VERSION 3.26)
project(BibbleSDK VERSION 0.1.0)

set(BIBBLE_SDK_VERSION "${PROJECT_VERSION}" CACHE STRING "SDK version string")

include (FetchContent)

FetchContent_Declare(BibbleBytecode
    GIT_REPOSITORY https://github.com/JannikBulow/BibbleBytecode.git
    GIT_TAG        master
    GIT_SHALLOW    TRUE)

FetchContent_Declare(BibbleVM
    GIT_REPOSITORY https://github.com/JannikBulow/BibbleVM.git
    GIT_TAG        master
    GIT_SHALLOW    TRUE)

FetchContent_Declare(BibbleASM
    GIT_REPOSITORY https://github.com/JannikBulow/BibbleASM.git
    GIT_TAG        master
    GIT_SHALLOW    TRUE)

FetchContent_MakeAvailable(BibbleBytecode BibbleVM BibbleASM)

file(GENERATE
    OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/sdk-version"
    CONTENT "${BIBBLE_SDK_VERSION}\n"
)

install(
    TARGETS BibbleVM-framework-shared BibbleVM-framework-static BibbleVM-native-interface BibbleVM-main
            BibbleASM-framework-shared BibbleASM-framework-static BibbleASM-main
            BibbleBytecode-shared BibbleBytecode-static
    EXPORT BibbleSDKTargets
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/sdk-version" DESTINATION .)

include(cmake/Packaging.cmake)