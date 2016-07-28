set(DUKTAPEDIR ${CMAKE_CURRENT_LIST_DIR}/lib/duktape)

if(EXISTS ${DUKTAPEDIR}/extras/logging/duk_logging.c)
include_directories(
  ${DUKTAPEDIR}/src
  ${DUKTAPEDIR}/extras/logging
)
add_library(duktape STATIC
  ${DUKTAPEDIR}/src/duktape.c
  ${DUKTAPEDIR}/extras/logging/duk_logging.c
)
else()
include_directories(
  ${DUKTAPEDIR}/src
)
add_library(duktape STATIC
  ${DUKTAPEDIR}/src/duktape.c
)
endif()

if("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
  target_link_libraries(duktape
    m dl rt
  )
endif()
